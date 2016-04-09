#!/bin/sh
. $(dirname $0)/PortDefinitions.sh
WHO=$(basename -s .ssh $0)
eval LocalPort=\$${WHO}LocalPort
eval RoutePort=\$${WHO}RoutePort
eval Name=\$${WHO}Name
eval User=\$${WHO}User
eval ExtraOptions=\$${WHO}ExtraOptions
IP=$(host $Name 8.8.8.8 | grep "has address" | awk '{printf $NF}')
#Route=$(netstat  -rn | grep default | grep en0 | awk '{printf $2}')

#echo "Adding Route for ${Name} through en0(${Route})"
#sudo route -n add ${IP} ${Route}
echo "ExtraOptions: ${ExtraOptions}"
echo "Logging into ${WHO}'s Mac on port $RoutePort, vnc port $LocalPort"
echo "\t ${User}@${Name}"
ssh  -C ${User}@${IP} -p $RoutePort -L $LocalPort:localhost:5900 $ExtraOptions "$@"
#echo "Removing Route for ${Name} through en0(${Route})"
# sudo route -n delete ${IP} ${Route}

