#!/bin/bash

read -p "INGRESE EL NOMBRE DEL PROCESO:" PROCESO
read -p "INGRESE EL COMANDO PARA EJECUTARLO: " COMANDO

PROCESOS=$(ps -eo comm=)
encontrado=0

for proceso in $PROCESOS
do
	if [ $PROCESO == $proceso ]; then
		encontrado=1
		break
	fi
done

if [ $encontrado -eq 0 ]; then
	echo "EL PROCESO NO EXISTE."

else
	echo "PROCESO ENCONTRADO."
	if [ "$(pgrep -x "$PROCESO")" > /dev/null ]; then
		echo "EL PROCESO YA ESTÀ EN EJECUCIÒN."
	else
		eval $COMANDO
		echo "SE HA INICIADO EL PROCESO $PROCESO"
	fi

fi

