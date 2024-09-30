#!/bin/bash
cut -d',' -f'1-11,13-15' supervivents.csv > supervivents2.csv
lineas1=$(wc -l supervivents2.csv)
awk '$15 != True' supervivents2.csv > supervivents3.csv
lineas2=$(wc -l supervivents3.csv)
echo $(($lineas2-$lineas1))



