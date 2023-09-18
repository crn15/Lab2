#!/bin/bash

directorio=/home/crojas/Lab2

log=/home/crojas/Lab2/log.txt
inotifywait=/usr/bin/inotifywait

archivo_log() {
mensaje_log="$1"
hora_fecha=$(date +"%Y-%m-%d %H:%M:%S")
echo "[hora_fecha] $tipo_cambio: $archivo" >> "$log"
}

cambio=$($inofitywait -m -r -e creado,modificado,eliminado "$directorio")
tipo_cambio=$(echo "$cambio" | awk '{print $1}')
archivo=&(echo "$cambio" | awk '{print $2}')

while read -r $directorio $tipo_cambio $archivo;
do
	mensaje_log="Se ha $tipo_cambio en $directorio/$archivo"
	archivo_log "$mensaje_log"
done
