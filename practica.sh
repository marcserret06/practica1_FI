#!/bin/bash
cut -d',' -f'1-11,13-15' supervivents.csv > supervivents2.csv
lineas1=$(wc -l supervivents2.csv)
awk '$15 != True' supervivents2.csv > supervivents3.csv
lineas2=$(wc -l supervivents3.csv)
echo $(($lineas2-$lineas1))
awk -F',' '{ if ($8 <= 1000000) { print $0",bo" } else { print } }' supervivents3.csv > supervivents1.csv
awk -F',' '{ if ($8 > 1000000 && $8 <= 10000000) { print $0",excel·lent" } else { print } }' supervivents1.csv >> supervivents1.csv
awk -F',' '{ if ($8 > 10000000) { print $0",estrella" } else { print } }' supervivents1.csv >> supervivents1.csv
i = 0
while [ $i -lt $lineas2 ]; do
i++
read visitas
visitas=$(cut -d',' -f8 <<< "$visitas")
read likes
likes=$(cut -d',' -f9 <<< "$likes")
read dislikes
dislikes=$(cut -d',' -f10 <<< "$dislikes")
ratiolikes=$(($likes * 100 / $visitas))
ratiodislikes=$(($dislikes * 100 / $visitas))
echo $ratiolikes
echo $ratiodislikes
done < supervivents3.csv
