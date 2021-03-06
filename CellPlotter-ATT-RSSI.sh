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

cat << EOF > /var/www/ATT-RSSI.html

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
RSSI=`grep $timestamp /var/www/logfiles/ATT*|awk -F '\t' '{print $18}'|head -1`;
Latitude=`grep $timestamp /var/www/logfiles/ATT*|awk -F '\t' '{print $3}'|head -1`;
Longitude=`grep $timestamp /var/www/logfiles/ATT*|awk -F '\t' '{print $2}'|head -1`;
echo $Latitude;
echo $Longitude;
echo $linecount;
echo $RSSI;

case "$RSSI" in
-30)
  Icon="greenIcon"
  ;;
-31)
  Icon="greenIcon"
  ;;
-32)
  Icon="greenIcon"
  ;;
-33)
  Icon="greenIcon"
  ;;
-34)
  Icon="greenIcon"
  ;;
-35)
  Icon="greenIcon"
  ;;
-36)
  Icon="greenIcon"
  ;;
-37)
  Icon="greenIcon"
  ;;
-38)
  Icon="greenIcon"
  ;;
-39)
  Icon="greenIcon"
  ;;
-40)
  Icon="greenIcon"
  ;;
-41)
  Icon="greenIcon"
  ;;
-42)
  Icon="greenIcon"
  ;;
-43)
  Icon="greenIcon"
  ;;
-44)
  Icon="greenIcon"
  ;;
-45)
  Icon="greenIcon"
  ;;
-46)
  Icon="greenIcon"
  ;;
-47)
  Icon="greenIcon"
  ;;
-48)
  Icon="greenIcon"
  ;;
-49)
  Icon="greenIcon"
  ;;
-50)
  Icon="greenIcon"
  ;;
-51)
  Icon="greenIcon"
  ;;
-52)
  Icon="greenIcon"
  ;;
-53)
  Icon="greenIcon"
  ;;
-54)
  Icon="greenIcon"
  ;;
-55)
  Icon="greenIcon"
  ;;
-56)
  Icon="greenIcon"
  ;;
-57)
  Icon="greenIcon"
  ;;
-58)
  Icon="greenIcon"
  ;;
-59)
  Icon="greenIcon"
  ;;
-60)
  Icon="greenIcon"
  ;;
-60)
  Icon="greenIcon"
  ;;
-61)
  Icon="greenIcon"
  ;;
-62)
  Icon="greenIcon"
  ;;
-63)
  Icon="greenIcon"
  ;;
-64)
  Icon="greenIcon"
  ;;
-65)
  Icon="greenIcon"
  ;;
-66)
  Icon="yellowIcon"
  ;;
-67)
  Icon="yellowIcon"
  ;;
-68)
  Icon="yellowIcon"
  ;;
-69)
  Icon="yellowIcon"
  ;;
-70)
  Icon="yellowIcon"
  ;;
-71)
  Icon="yellowIcon"
  ;;
-72)
  Icon="yellowIcon"
  ;;
-73)
  Icon="yellowIcon"
  ;;
-74)
  Icon="yellowIcon"
  ;;
-75)
  Icon="yellowIcon"
  ;;
-76)
  Icon="orangeIcon"
  ;;
-77)
  Icon="orangeIcon"
  ;;
-78)
  Icon="orangeIcon"
  ;;
-79)
  Icon="orangeIcon"
  ;;
-80)
  Icon="orangeIcon"
  ;;
-81)
  Icon="orangeIcon"
  ;;
-82)
  Icon="orangeIcon"
  ;;
-83)
  Icon="orangeIcon"
  ;;
-84)
  Icon="orangeIcon"
  ;;
-85)
  Icon="orangeIcon"
  ;;
-86)
  Icon="redIcon"
  ;;
-87)
  Icon="redIcon"
  ;;
-88)
  Icon="redIcon"
  ;;
-89)
  Icon="redIcon"
  ;;
-90)
  Icon="redIcon"
  ;;
-91)
  Icon="redIcon"
  ;;
-92)
  Icon="redIcon"
  ;;
-93)
  Icon="redIcon"
  ;;
-94)
  Icon="redIcon"
  ;;
-95)
  Icon="redIcon"
  ;;
-96)
  Icon="redIcon"
  ;;
-97)
  Icon="redIcon"
  ;;
-98)
  Icon="redIcon"
  ;;
-99)
  Icon="redIcon"
  ;;
-100)
  Icon="redIcon"
  ;;
-101)
  Icon="redIcon"
  ;;
-102)
  Icon="redIcon"
  ;;
-103)
  Icon="redIcon"
  ;;
-104)
  Icon="redIcon"
  ;;
-105)
  Icon="redIcon"
  ;;
-106)
  Icon="redIcon"
  ;;
-107)
  Icon="redIcon"
  ;;
-108)
  Icon="redIcon"
  ;;
-109)
  Icon="redIcon"
  ;;
-110)
  Icon="redIcon"
  ;;
-111)
  Icon="redIcon"
  ;;
-112)
  Icon="redIcon"
  ;;
-113)
  Icon="redIcon"
  ;;
-114)
  Icon="redIcon"
  ;;
-115)
  Icon="redIcon"
  ;;
-116)
  Icon="redIcon"
  ;;
-117)
  Icon="redIcon"
  ;;
-118)
  Icon="redIcon"
  ;;
-119)
  Icon="redIcon"
  ;;
-120)
  Icon="redIcon"
  ;;
esac


cat << EOF >> /var/www/ATT-RSSI.html
L.marker([$Latitude, $Longitude], {icon: $Icon}).addTo(map);
EOF

linecount=`expr $linecount + 1`;
done;
cat  << EOF >> /var/www/ATT-RSSI.html
    </script>
  </body>
</html

EOF

# Set Center of Map based on average of all entries

# Get List of all Latitudes for ATT






#TMobileMapCenter=
#ATTMapCenter=



