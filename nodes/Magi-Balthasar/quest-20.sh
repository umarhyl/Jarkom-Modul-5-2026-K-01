#!/bin/bash

# Quest 20: Uji Kebakaran Geofront (Node 3/3 — Host Magi-Balthasar)

# Siapkan script pemulihan rute idempoten di /root/balthasar.sh
cat <<'EOF' > /root/balthasar.sh
#!/bin/bash
ip route replace default via 10.64.4.57
EOF
chmod +x /root/balthasar.sh

echo "=== [1] Backup iptables ke /root/balthasar.rules ==="
iptables-save > /root/balthasar.rules
ls -la /root/balthasar.rules

echo "=== [2] Hapus semua rule iptables (filter + nat) & rute default ==="
iptables -F && iptables -X
iptables -P INPUT ACCEPT && iptables -P FORWARD ACCEPT && iptables -P OUTPUT ACCEPT
iptables -t nat -F && iptables -t nat -X
ip route del default 2>/dev/null
echo "Setelah hapus -> filter: $(iptables -S | wc -l) baris | nat: $(iptables -t nat -S | wc -l) baris | route: $(ip route show | wc -l) baris"

echo "=== [3] Pemulihan PERTAMA ==="
iptables-restore < /root/balthasar.rules
/root/balthasar.sh
F1=$(iptables -S | wc -l)
N1=$(iptables -t nat -S | wc -l)
R1=$(ip route show | wc -l)
echo "Pemulihan #1 -> filter: $F1 baris | nat: $N1 baris | route: $R1 baris"

echo "=== [4] Pemulihan KEDUA (berturut-turut) ==="
iptables-restore < /root/balthasar.rules
/root/balthasar.sh
F2=$(iptables -S | wc -l)
N2=$(iptables -t nat -S | wc -l)
R2=$(ip route show | wc -l)
echo "Pemulihan #2 -> filter: $F2 baris | nat: $N2 baris | route: $R2 baris"

echo "=== [5] Uji fungsi Magi-Balthasar setelah pemulihan ==="
ping -c 2 8.8.8.8
