#! /bin/bash

# This is the script that will be used to gather logfile information and plot it on the map.  It will run as cronjob periodically.
# Keith Calligan
# keith@drivetester.us

echo > /tmp/TMobile-Neighbor-average-tmp.txt;

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

cat << EOF > /var/www/TMobile-Neighbor-average-tmp.html

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


for i in `cat /var/www/logfiles/Google*|grep -v -e Calligan -e Longitude| awk -F "\t" '{print $3","$2}'`; do
echo $i;
    count=0
    total=0
Latitude=`echo $i|awk -F "," '{print $1}'`;
Longitude=`echo $i|awk -F "," '{print $2}'`;
RoundedLatitude=`printf '%.*f\n' 3 $Latitude`;
RoundedLongitude=`printf '%.*f\n' 3 $Longitude|sed 's/-//g'`;


for Neighbor in `cat /var/www/logfiles/Google*|grep -E $RoundedLatitude| grep -E $RoundedLongitude|awk -F "\t" '{print $89","$99","$109","$119","$129","$139","$149","$159","$169","$179","$189","$199","$209","$219","$229","$239","$249}'`; do


#    for Neighbor in `cat /var/www/logfiles/Verizon*|grep -E $RoundedLatitude |grep -E $RoundedLongitude|awk -F "\t" '{print $15}'|sort|uniq|sed 's/-//g'`; do
    #echo $RoundedLatitude;
    #echo $RoundedLongitude;
     NeighborCount=`echo $Neighbor|awk -F "," '{print $1"\n"$2"\n"$3"\n"$4"\n"$5"\n"$6"\n"$7"\n"$8"\n"$9"\n"$10"\n"$11"\n"$12"\n"$13"\n"$14"\n"$15"\n"$16"\n"$17}'|grep -e 1 -e 2 -e 3 -e 4 -e 5 -e 6 -e 7 -e 8 -e 9 |wc -l`;
#     echo Neighbor is $Neighbor;
#     echo i is $i;
#     echo Count is $NeighborCount;
     total=$(echo $total+$NeighborCount | bc )
     ((count++))
     done
NeighborAverage=`echo "$total / $count" | bc`;
echo $NeighborAverage;

linecount=0;

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

echo "L.marker([$RoundedLatitude, "-"$RoundedLongitude], {icon: $Icon}).addTo(map);" >> /tmp/TMobile-Neighbor-average-tmp.txt;

echo $linecount;
done;

cat /tmp/TMobile-Neighbor-average-tmp.txt|sort|uniq >> /var/www/TMobile-Neighbor-average-tmp.html;

cat  << EOF >> /var/www/TMobile-Neighbor-average-tmp.html
    </script>
  </body>
</html>

EOF

# Set Center of Map based on average of all entries

# Get List of all Latitudes for TMobile

mv /var/www/TMobile-Neighbor-average-tmp.html /var/www/TMobile-Neighbor-average.html




#TMobileMapCenter=
#ATTMapCenter=



