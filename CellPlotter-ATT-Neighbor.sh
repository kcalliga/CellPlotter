#! /bin/bash

# This is the script that will be used to gather logfile information and plot it on the map.  It will run as cronjob periodically.
# Keith Calligan
# keith@drivetester.us

# Get List of LogFiles for each carrier and loop 
 

#Get ATT Center Latitute

count=0;
total=0; 

for i in  `cat /var/www/logfiles/ATT*|grep -v Timestamp|awk -F '\t' '{print $3}'`;
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
ATTCenterLatitude=`echo "scale=10; $total / $count" | bc`;
echo $ATTCenterLatitude;

#Get ATT Center Longitude

count=0;
total=0; 

for i in  `cat /var/www/logfiles/ATT*|grep -v Timestamp|awk -F '\t' '{print $2}'`;
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
ATTCenterLongitude=`echo "scale=10; $total / $count" | bc`;
echo $ATTCenterLongitude;

# Generate top of ATT File;

cat << EOF > /var/www/ATT-Neighbor-tmp.html

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
    <script src="ATTTest.js" type="text/javascript"></script>
    <script>
      var map = L.map('map').setView([$ATTCenterLatitude, $ATTCenterLongitude], 13);
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

linecount=0;
for timestamp in `cat /var/www/logfiles/ATT*|grep -v Timestamp|awk -F '\t' '{print $1}'`; do
NeighborCount=`grep $timestamp /var/www/logfiles/ATT*|head -1|awk -F "\t" '{print $89"\n"$99"\n"$109"\n"$119"\n"$129"\n"$139"\n"$149"\n"$159"\n"$169"\n"$179"\n"$189"\n"$199"\n"$209"\n"$219"\n"$229"\n"$239"\n"$249}'|grep -e 1 -e 2 -e 3 -e 4 -e 5 -e 6 -e 7 -e 8 -e 9 |wc -l`;
Latitude=`grep $timestamp /var/www/logfiles/ATT*|awk -F '\t' '{print $3}'|head -1`;
Longitude=`grep $timestamp /var/www/logfiles/ATT*|awk -F '\t' '{print $2}'|head -1`;
echo $Latitude;
echo $Longitude;
echo $linecount;
echo $NeighborCount;

case "$NeighborCount" in
0)
  Icon="redIcon"
  ;;
1)
  Icon="redIcon"
  ;;
2)
  Icon="orangeIcon"
  ;;
3)
  Icon="orangeIcon"
  ;;
4)
  Icon="yellowIcon"
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
  Icon="greenIcon"
  ;;
9)
  Icon="greenIcon"
  ;;
10)
  Icon="greenIcon"
  ;;
11)
  Icon="greenIcon"
  ;;
12)
  Icon="greenIcon"
  ;;
13)
  Icon="greenIcon"
  ;;
14)
  Icon="greenIcon"
  ;;
15)
  Icon="greenIcon"
  ;;
16)
  Icon="greenIcon"
  ;;
17)
  Icon="greenIcon"
  ;;
18)
  Icon="greenIcon"
  ;;
esac

cat << EOF >> /var/www/ATT-Neighbor-tmp.html
L.marker([$Latitude, $Longitude], {icon: $Icon}).addTo(map);
EOF

linecount=`expr $linecount + 1`;
done;
cat  << EOF >> /var/www/ATT-Neighbor-tmp.html
    </script>
  </body>
</html

EOF

# Set Center of Map based on average of all entries

# Get List of all Latitudes for ATT

grep -v "{icon: }" /var/www/ATT-Neighbor-tmp.html > /var/www/ATT-Neighbor.html;




#TMobileMapCenter=
#ATTMapCenter=



