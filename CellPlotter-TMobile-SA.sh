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

cat << EOF > /var/www/TMobile-SA-tmp.html

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
SAExists=`grep $timestamp /var/www/logfiles/Google*|awk -F '\t' '{print $12,$13}'|grep '5G 5G'|head -1|wc -l`;
Latitude=`grep $timestamp /var/www/logfiles/Google*|awk -F '\t' '{print $3}'|head -1`;
Longitude=`grep $timestamp /var/www/logfiles/Google*|awk -F '\t' '{print $2}'|head -1`;
#echo $Latitude;
#echo $Longitude;
echo $linecount;
echo $SAExists;

case "$SAExists" in
1)
  Icon="greenIcon"
  ;;
*)
  Icon="None"
  ;;
esac


cat << EOF >> /var/www/TMobile-SA-tmp.html
L.marker([$Latitude, $Longitude], {icon: $Icon}).addTo(map);
EOF

linecount=`expr $linecount + 1`;
done;
cat  << EOF >> /var/www/TMobile-SA-tmp.html
    </script>
  </body>
</html

EOF

grep -v "{icon: None" /var/www/TMobile-SA-tmp.html > /var/www/TMobile-SA.html;

# Set Center of Map based on average of all entries

# Get List of all Latitudes for TMobile






#TMobileMapCenter=
#ATTMapCenter=



