#!/bin/bash
cut -d',' -f'1-11,13-15' supervivents.csv > supervivents2.csv
lineas1=$(wc -l < supervivents2.csv)
awk -F',' '$14 != "True"' supervivents2.csv > supervivents3.csv
lineas2=$(wc -l < supervivents3.csv)
lineas=$(( $lineas1 - $lineas2 ))
echo $lineas
awk -F',' '{ if ($8 <= 1000000) { print $0", bo" } else { print } }' supervivents3.csv > supervivents1.csv
awk -F',' '{ if ($8 > 1000000 && $8 <= 10000000) { print $0", excel·lent" } else { print } }' supervivents1.csv > supervivents2.csv
awk -F',' '{ if ($8 > 10000000) { print $0", estrella" } else { print } }' supervivents2.csv > supervivents3.csv
contador=0
echo "" > sortida.csv
while read -r linea; do
if [ $contador -eq 0 ]; then
contador=$((contador + 1))
echo "video_id,trending_date,title,channel_title,category_id,publish_time,tags,views,likes,dislikes,comment_count,comments_disabled,ratings_disabled,video_error_or_removed, Ranking_views, Rlikes, RDislikes" >> "sortida.csv"
continue
fi
visitas=$(echo "$linea" | cut -d',' -f8)
likes=$(echo "$linea" | cut -d',' -f9)
dislikes=$(echo "$linea" | cut -d',' -f10)
ratiolikes=$(( ($likes * 100) / visitas ))
ratiodislikes=$(( ($dislikes * 100) / visitas ))
echo "$linea, $ratiolikes, $ratiodislikes" >> "sortida.csv"
contador=$((contador + 1))
done < supervivents3.csv
if [ "$#" -lt "1" ]; then
echo "No hay ningún argumento"
else
busqueda=$(grep "$1" sortida.csv | cut -d',' -f3,6,8,9,10,15,16,17)
echo "$busqueda"
fi
