#! /bin/bash

# This is the script that will be used to gather logfile information and plot it on the map.  It will run as cronjob periodically.
# Keith Calligan
# keith@drivetester.us

# Get List of LogFiles for each carrier and loop 
 

#Get TMobile Center Latitute

count=0;
total=0; 

for i in  `cat /var/www/logfiles/Google*|grep -v Timestamp|awk -F '\t' '{print $3}'`;
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
TMobileCenterLatitude=`echo "scale=10; $total / $count" | bc`;
echo $TMobileCenterLatitude;

#Get TMobile Center Longitude

count=0;
total=0; 

for i in  `cat /var/www/logfiles/Google*|grep -v Timestamp|awk -F '\t' '{print $2}'`;
   do 
     total=$(echo $total+$i | bc )
     ((count++))
   done
TMobileCenterLongitude=`echo "scale=10; $total / $count" | bc`;
echo $TMobileCenterLongitude;

# Generate top of TMobile File;

cat << EOF > /var/www/TMobile-RSRP.html

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
    <script src="TMobileTest.js" type="text/javascript"></script>
    <script>
      var map = L.map('map').setView([$TMobileCenterLatitude, $TMobileCenterLongitude], 13);
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
for timestamp in `cat /var/www/logfiles/Google*|grep -v Timestamp|awk -F '\t' '{print $1}'`; do
RSRP=`grep $timestamp /var/www/logfiles/Google*|awk -F '\t' '{print $14}'|head -1`;
Latitude=`grep $timestamp /var/www/logfiles/Google*|awk -F '\t' '{print $3}'|head -1`;
Longitude=`grep $timestamp /var/www/logfiles/Google*|awk -F '\t' '{print $2}'|head -1`;
echo $Latitude;
echo $Longitude;
echo $linecount;
echo $RSRP;

case "$RSRP" in
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
  Icon="greenIcon"
  ;;
-67)
  Icon="greenIcon"
  ;;
-68)
  Icon="greenIcon"
  ;;
-69)
  Icon="greenIcon"
  ;;
-70)
  Icon="greenIcon"
  ;;
-71)
  Icon="greenIcon"
  ;;
-72)
  Icon="greenIcon"
  ;;
-73)
  Icon="greenIcon"
  ;;
-74)
  Icon="greenIcon"
  ;;
-75)
  Icon="greenIcon"
  ;;
-76)
  Icon="greenIcon"
  ;;
-77)
  Icon="greenIcon"
  ;;
-78)
  Icon="greenIcon"
  ;;
-79)
  Icon="greenIcon"
  ;;
-80)
  Icon="greenIcon"
  ;;
-81)
  Icon="yellowIcon"
  ;;
-82)
  Icon="yellowIcon"
  ;;
-83)
  Icon="yellowIcon"
  ;;
-84)
  Icon="yellowIcon"
  ;;
-85)
  Icon="yellowIcon"
  ;;
-86)
  Icon="yellowIcon"
  ;;
-87)
  Icon="yellowIcon"
  ;;
-88)
  Icon="yellowIcon"
  ;;
-89)
  Icon="yellowIcon"
  ;;
-90)
  Icon="yellowIcon"
  ;;
-91)
  Icon="orangeIcon"
  ;;
-92)
  Icon="orangeIcon"
  ;;
-93)
  Icon="orangeIcon"
  ;;
-94)
  Icon="orangeIcon"
  ;;
-95)
  Icon="orangeIcon"
  ;;
-96)
  Icon="orangeIcon"
  ;;
-97)
  Icon="orangeIcon"
  ;;
-98)
  Icon="orangeIcon"
  ;;
-99)
  Icon="orangeIcon"
  ;;
-100)
  Icon="orangeIcon"
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

cat << EOF >> /var/www/TMobile-RSRP.html
L.marker([$Latitude, $Longitude], {icon: $Icon}).addTo(map);
EOF

linecount=`expr $linecount + 1`;
done;
cat  << EOF >> /var/www/TMobile-RSRP.html
    </script>
  </body>
</html

EOF

# Set Center of Map based on average of all entries

# Get List of all Latitudes for TMobile






#TMobileMapCenter=
#ATTMapCenter=



