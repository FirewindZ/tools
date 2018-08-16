#!/bin/bash

for x in `ls /root/scripts/gpscut/raw_gps/|grep *.gps.bak`; do
 echo $x
 n1=`cat $x |wc -l`
 ((n2=$n1-1))
 echo $n1
 
 for ((i=1;i<=${n2};i++)); do

  n3=`cat $x |wc -l`
  ((n2=$n3-1))

  a1=`sed -n "${i}p" $x`
  ((i1=$i+1))
  a2=`sed -n "${i1}p" $x`
    
  echo $a1 > ./a1.txt
  echo $a2 > ./a2.txt
  
  b1=`echo ${a1:4:13}`
  b2=`echo ${a2:4:13}`

  b3=$((b2-b1))
  b4=$(echo "scale=1; $b3/1000"|bc)
  b5=$(echo "scale=0; ${b4}+0.5"|bc)
  b6=`echo $((${b5//.*/}))`
  echo $b6
  
    if [ $b6 -gt 1 ]; then
     c1=`awk -F ',' '{print $2}' ./a1.txt`
     c2=`awk -F ',' '{print $2}' ./a2.txt` 
     c3=$((c2-c1))
     c4=$((c3/b6))
         
     c5=$((c1+c4))
        

     d1=`awk -F ',' '{print $3}' ./a1.txt`
     d2=`awk -F ',' '{print $3}' ./a2.txt`
     d3=$((d2-d1))
     d4=$((d3/b6))

     d5=$((d1+d4))
     

     ((b7=$b1+1000))

     echo $a1 > ./a2.txt
     z1=`awk -F ',' '{print $4}' ./a1.txt`
     z2=`awk -F ',' '{print $5}' ./a1.txt`
     z3=`awk -F ',' '{print $6}' ./a1.txt`

     sed -i -e "${i}a\GPS:$b7,$c5,$d5,$z1,$z2,$z3" $x

   fi


  #a2=`head -i+1 $x`
 done

#??????
# l1=`head -1 $x`
# l2=`tail -1 $x`
#
# #echo $l1
#
# t1=`echo ${l1:4:13}`
# t2=`echo ${l2:4:13}`
#
# echo $t1
# echo $t2
#
# ((t3=$t2-$t1))
# echo $t3
## ((t4=$t3/1000))
# t4=$(echo "scale=1; $t3/1000"|bc) 
#echo $t4
# t5=$(echo "scale=0; ${t4}+0.5"|bc)
#echo $t5
# t6=`echo $((${t5//.*/}))`
#echo $t6
done
