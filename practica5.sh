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
while read -r linea; do
  if [ $contador -eq 0 ]; then
    contador=$((contador + 1))
    continue
  fi
  visitas=$(echo "$linea" | cut -d',' -f8)
  likes=$(echo "$linea" | cut -d',' -f9)
  dislikes=$(echo "$linea" | cut -d',' -f10)
  # Calcular los ratios
  ratiolikes=$(( ($likes * 100) / visitas ))
  ratiodislikes=$(( ($dislikes * 100) / visitas ))
  # Guardar en el archivo de salida
  echo "$linea, $ratiolikes, $ratiodislikes" >> "$supervivents.csv"
  contador=$((contador + 1))
done < supervivents3.csv
