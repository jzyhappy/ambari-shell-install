echo "0.0.0.0   0.0.0.0" >> /etc/hosts;
for i in {001..26};
do
echo "$VLAN$[$i+190-1] $HOSTSPEC$i" >> /etc/hosts;
done
