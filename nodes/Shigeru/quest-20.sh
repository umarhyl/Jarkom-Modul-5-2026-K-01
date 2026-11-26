#!/bin/bash

# Quest 20: Uji Kebakaran Geofront (Node 2/3 — Router Cabang Shigeru)

# Siapkan script pemulihan rute idempoten di /root/shigeru.sh
cat <<'EOF' > /root/shigeru.sh
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1 >/dev/null
ip route replace default via 10.64.4.113
ip route replace 10.64.4.88/29 via 10.64.4.146
EOF
chmod +x /root/shigeru.sh

echo "=== [1] Backup iptables ke /root/shigeru.rules ==="
iptables-save > /root/shigeru.rules
ls -la /root/shigeru.rules

echo "=== [2] Hapus semua rule iptables (filter + nat) & rute statis ==="
iptables -F && iptables -X
iptables -P INPUT ACCEPT && iptables -P FORWARD ACCEPT && iptables -P OUTPUT ACCEPT
iptables -t nat -F && iptables -t nat -X
ip route del default 2>/dev/null
ip route del 10.64.4.88/29 2>/dev/null
echo "Setelah hapus -> filter: $(iptables -S | wc -l) baris | nat: $(iptables -t nat -S | wc -l) baris | route: $(ip route show | wc -l) baris"

echo "=== [3] Pemulihan PERTAMA ==="
iptables-restore < /root/shigeru.rules
/root/shigeru.sh
F1=$(iptables -S | wc -l)
N1=$(iptables -t nat -S | wc -l)
R1=$(ip route show | wc -l)
echo "Pemulihan #1 -> filter: $F1 baris | nat: $N1 baris | route: $R1 baris"

echo "=== [4] Pemulihan KEDUA (berturut-turut) ==="
iptables-restore < /root/shigeru.rules
/root/shigeru.sh
F2=$(iptables -S | wc -l)
N2=$(iptables -t nat -S | wc -l)
R2=$(ip route show | wc -l)
echo "Pemulihan #2 -> filter: $F2 baris | nat: $N2 baris | route: $R2 baris"

echo "=== [5] Uji fungsi Shigeru setelah pemulihan ==="
ping -c 2 10.64.4.90
ping -c 2 8.8.8.8
