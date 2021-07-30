#! /bin/bash

# This is the script that will be used to gather logfile information and plot it on the map.  It will run as cronjob periodically.
# Keith Calligan
# keith@drivetester.us

CurrentDate=`date +%Y"."%m`

echo > /tmp/Verizon-RSRQ-average-tmp.txt;

# Get List of LogFiles for each carrier and loop 
 

#Get Verizon Center Latitute


count=0;
total=0; 

for i in  `cat /var/www/logfiles/Verizon*|grep $CurrentDate|grep -v Timestamp|awk -F '\t' '{print $3}'`;
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
VerizonCenterLatitude=`echo "scale=10; $total / $count" | bc`;
echo $VerizonCenterLatitude;

#Get Verizon Center Longitude

count=0;
total=0; 

for i in  `cat /var/www/logfiles/Verizon*|grep $CurrentDate|grep -v Timestamp|awk -F '\t' '{print $2}'`;
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
VerizonCenterLongitude=`echo "scale=10; $total / $count" | bc`;
echo $VerizonCenterLongitude;

# Generate top of Verizon File;

cat << EOF > /var/www/Verizon-RSRQ-average-tmp.html

<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.3.1/leaflet.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.3.1/leaflet.js"></script>
    <style>
      #map {position: absolute; top: 0; right: 0; bottom: 0; left: 0;}
    </style>
  </head>
  <body>
    <div id="map">
      <a href="https://www.maptiler.com" style="position:absolute;left:10px;bottom:10px;z-index:999;"><img src="https://api.maptiler.com/resources/logo.svg" alt="MapTiler logo"></a>
    </div>
    <p><a href="https://www.maptiler.com/copyright/" target="_blank">&copy; MapTiler</a> <a href="https://www.openstreetmap.org/copyright" target="_blank">&copy; OpenStreetMap contributors</a></p>
    <script>
      var map = L.map('map').setView([$VerizonCenterLatitude, $VerizonCenterLongitude], 13);
      L.tileLayer('https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=S3P9GzyoztmyHTfFGU2a',{
        tileSize: 512,
        zoomOffset: -1,
        minZoom: 1,
        attribution: "\u003ca href=\"https://www.maptiler.com/copyright/\" target=\"_blank\"\u003e\u0026copy; MapTiler\u003c/a\u003e \u003ca href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\"\u003e\u0026copy; OpenStreetMap contributors\u003c/a\u003e",
        crossOrigin: true
      }).addTo(map);

var greenIcon = L.icon({
    iconUrl: 'green.png',

    iconSize:     [24, 24], // size of the icon
    iconAnchor:   [12, 24], // point of the icon which will correspond to marker's location
    popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
});

var yellowIcon = L.icon({
    iconUrl: 'yellow.png',
    iconSize:     [24, 24], // size of the icon
    iconAnchor:   [12, 24], // point of the icon which will correspond to marker's location
    popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
});

var orangeIcon = L.icon({
    iconUrl: 'orange.png',

    iconSize:     [24, 24], // size of the icon
    iconAnchor:   [12, 24], // point of the icon which will correspond to marker's location
    popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
});

var redIcon = L.icon({
    iconUrl: 'red.png',

    iconSize:     [24, 24], // size of the icon
    iconAnchor:   [12, 24], // point of the icon which will correspond to marker's location
    popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
});

EOF

for i in `cat /var/www/logfiles/Verizon*|grep $CurrentDate|grep -v -e Calligan -e Longitude| awk -F "\t" '{print $3","$2}'`; do
echo $i;
    count=0
    total=0
Latitude=`echo $i|awk -F "," '{print $1}'`;
Longitude=`echo $i|awk -F "," '{print $2}'`;
RoundedLatitude=`printf '%.*f\n' 3 $Latitude`;
RoundedLongitude=`printf '%.*f\n' 3 $Longitude|sed 's/-//g'`;
    for rsrq in `cat /var/www/logfiles/Verizon*|grep $CurrentDate|grep -E $RoundedLatitude |grep -E $RoundedLongitude|awk -F "\t" '{print $15}'|sort|uniq|sed 's/-//g'`; do
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


echo "L.marker([$RoundedLatitude, "-"$RoundedLongitude], {icon: $Icon}).addTo(map);" >> /tmp/Verizon-RSRQ-average-tmp.txt;

done;

cat /tmp/Verizon-RSRQ-average-tmp.txt|sort|uniq >> /var/www/Verizon-RSRQ-average-tmp.html;

cat  << EOF >> /var/www/Verizon-RSRQ-average-tmp.html
    </script>
  </body>
</html>

EOF

# Set Center of Map based on average of all entries

# Get List of all Latitudes for Verizon

mv /var/www/Verizon-RSRQ-average-tmp.html /var/www/Verizon-RSRQ-average.html




#VerizonMapCenter=
#ATTMapCenter=



