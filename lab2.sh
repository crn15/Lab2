#!/bin/bash

read -p "INGRESE EL ID DEL PROCESO: " ID

PROCESOS=$(ps aux | awk '{print $2}')
encontrado=0

for proceso in $PROCESOS
do
        if [ $ID == $proceso ]; then
                encontrado=1
                break
        fi
done

if [ $encontrado -eq 0 ]; then
        echo "PROCESO NO EXISTE."
else
	echo -e "\nPROCESO ENCONTRADO.\n"
	nombre=$(ps -p $ID -o comm=)
	echo -e "Nombre del proceso:\n $nombre\n"
	id=$ID
	echo -e "ID:\n $id\n"
	parent_process_id=$(ps -p $ID -o ppid)
	echo -e "Parent_process_id:\n $parent_process_id\n"
	usuario=$(ps -p $ID -o user)
	echo -e "Usuario dueño:\n $usuario\n"
	CPU=$(ps -p $ID -o %cpu)
	echo -e "Porcentaje de uso del CPU:\n $CPU\n"
	memoria=$(ps -p $ID -o %mem)
	echo -e "Consumo de memoria:\n $memoria\n"
	estado=$(ps -p $ID -o state)
	echo -e "Estado:\n $estado\n"
	path=$(ps -p $ID -o cmd=)
	echo -e "Path del ejecutable:\n $path\n"

fi


