set -x

for i in `cat /var/www/logfiles/Verizon_SIM2_2021.07.27*|grep -v -e Calligan -e Longitude| awk -F "\t" '{print $3","$2}'`; do
echo $i;
    count=0
    total=0
Latitude=`echo $i|awk -F "," '{print $1}'`;
Longitude=`echo $i|awk -F "," '{print $2}'`;
RoundedLatitude=`printf '%.*f\n' 3 $Latitude`;
RoundedLongitude=`printf '%.*f\n' 3 $Longitude|sed 's/-//g'`;
    for rsrq in `cat /var/www/logfiles/Verizon_SIM2_2021.07.27*|grep -E $RoundedLatitude |grep -E $RoundedLongitude|awk -F "\t" '{print $15}'|sort|uniq|sed 's/-//g'`; do
    #echo $RoundedLatitude;
    #echo $RoundedLongitude;
     echo $rsrq;
     echo $i;
     total=$(echo $total+$rsrq | bc )
     ((count++))
     done
RSRQAverage=`echo "$total / $count" | bc`;
echo $RSRQAverage;

linecount=0;

case "$RSRQAverage" in
1)
  Icon="greenIcon"
  ;;
2)
  Icon="greenIcon"
  ;;
3)
  Icon="greenIcon"
  ;;
4)
  Icon="greenIcon"
  ;;
5)
  Icon="greenIcon"
  ;;
6)
  Icon="greenIcon"
  ;;
7)
  Icon="greenIcon"
  ;;
8)
  Icon="yellowIcon"
  ;;
9)
  Icon="yellowIcon"
  ;;
10)
  Icon="yellowIcon"
  ;;
11)
  Icon="yellowIcon"
  ;;
12)
  Icon="orangeIcon"
  ;;
13)
  Icon="orangeIcon"
  ;;
14)
  Icon="orangeIcon"
  ;;
15)
  Icon="redIcon"
  ;;
16)
  Icon="redIcon"
  ;;
17)
  Icon="redIcon"
  ;;
18)
  Icon="redIcon"
  ;;
19)
  Icon="redIcon"
  ;;
esac


echo "L.marker([$RoundedLatitude, $RoundedLongitude], {icon: $Icon}).addTo(map)" >> /var/www/test.html;

done;

#linecount=`expr $linecount + 1`;

