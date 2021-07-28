count=0;
total=0; 

for i in  `cat /var/www/logfiles/*|awk -F "\t" '{print $1}'|awk -F "." '{print $3}'|sort|uniq `;
   do for rsrqcount in `grep $i /var/www/logfiles/*|awk -F "\t" '{print $15}'|sed 's/-//'`; do
     total=$(echo $total+$rsrqcount | bc )
     ((count++))
     #echo $rsrqcount;
   done;
   #echo $total/$count;
   Average=`echo "scale=10; $total / $count" |bc`;
   echo $i $Average;
   done;
