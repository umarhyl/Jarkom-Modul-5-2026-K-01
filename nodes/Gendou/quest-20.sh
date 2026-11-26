#!/bin/bash

# Quest 20: Uji Kebakaran Geofront (Node 1/3 — Router Utama Gendou)

# Siapkan script pemulihan rute idempoten di /root/gendou.sh
cat <<'EOF' > /root/gendou.sh
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1 >/dev/null
ip route replace 10.64.4.56/29 via 10.64.4.110
ip route replace 10.64.4.136/30 via 10.64.4.110
ip route replace 10.64.3.192/27 via 10.64.4.110
ip route replace 10.64.4.140/30 via 10.64.4.110
ip route replace 10.64.4.72/29 via 10.64.4.110
ip route replace 10.64.4.80/29 via 10.64.4.114
ip route replace 10.64.4.144/30 via 10.64.4.114
ip route replace 10.64.4.88/29 via 10.64.4.114
ip route replace 10.64.4.64/29 via 10.64.4.118
ip route replace 10.64.4.100/30 via 10.64.4.122
ip route replace 10.64.4.96/30 via 10.64.4.126
ip route replace 10.64.4.148/30 via 10.64.4.126
ip route replace 10.64.3.128/26 via 10.64.4.126
ip route replace 10.64.4.152/30 via 10.64.4.126
ip route replace 10.64.4.48/29 via 10.64.4.126
ip route replace 10.64.2.0/24 via 10.64.4.130
ip route replace 10.64.4.156/30 via 10.64.4.130
ip route replace 10.64.3.224/27 via 10.64.4.130
ip route replace 10.64.3.0/25 via 10.64.4.134
ip route replace 10.64.4.160/30 via 10.64.4.134
ip route replace 10.64.4.32/28 via 10.64.4.134
ip route replace 10.64.4.164/30 via 10.64.4.134
ip route replace 10.64.0.0/23 via 10.64.4.134
ip route replace 10.64.4.168/30 via 10.64.4.134
ip route replace 10.64.4.0/27 via 10.64.4.134
EOF
chmod +x /root/gendou.sh

echo "=== [1] Backup iptables ke /root/gendou.rules ==="
iptables-save > /root/gendou.rules
ls -la /root/gendou.rules

echo "=== [2] Hapus semua rule iptables (filter + nat) & rute statis ==="
iptables -F && iptables -X
iptables -P INPUT ACCEPT && iptables -P FORWARD ACCEPT && iptables -P OUTPUT ACCEPT
iptables -t nat -F && iptables -t nat -X
ip route show | awk '/^10\.64\..* via / {print $1}' | while read net; do
    ip route del "$net" 2>/dev/null
done
echo "Setelah hapus -> filter: $(iptables -S | wc -l) baris | nat: $(iptables -t nat -S | wc -l) baris | route: $(ip route show | wc -l) baris"

echo "=== [3] Pemulihan PERTAMA ==="
iptables-restore < /root/gendou.rules
/root/gendou.sh
F1=$(iptables -S | wc -l)
N1=$(iptables -t nat -S | wc -l)
R1=$(ip route show | wc -l)
echo "Pemulihan #1 -> filter: $F1 baris | nat: $N1 baris | route: $R1 baris"

echo "=== [4] Pemulihan KEDUA (berturut-turut) ==="
iptables-restore < /root/gendou.rules
/root/gendou.sh
F2=$(iptables -S | wc -l)
N2=$(iptables -t nat -S | wc -l)
R2=$(ip route show | wc -l)
echo "Pemulihan #2 -> filter: $F2 baris | nat: $N2 baris | route: $R2 baris"

echo "=== [5] Uji fungsi Gendou setelah pemulihan ==="
ping -c 2 10.64.4.66
ping -c 2 8.8.8.8
