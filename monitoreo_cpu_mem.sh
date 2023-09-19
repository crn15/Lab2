#!/bin/bash

read -p "INGRESE EL NOMBRE DEL PROCESO: " PROCESO

encontrado=0
REGISTRO=registro.log
intervalo_lectura_seg=1
ID=$(pgrep $PROCESO)
PROCESOS=$(ps -eo comm=)

registro_consumo() {
	tiempo=$(date +"%T")
	pidstat -p $ID -r -u $intervalo_lectura_seg 1 | tail -n 1 | awk '{print $6, $7}' >> "$REGISTRO"
}



for proceso in $PROCESOS
do
	if [ $PROCESO == $proceso ]; then
		encontrado=1
		break
	fi
done

if [ $encontrado -eq 0 ]; then
	echo -e "\nPROCESO NO EXISTE.\n"
else
	echo -e "\nPROCESO ENCONTRADO.\n"
	$PROCESO &
        echo "TIEMPO %CPU %MEM" > "$REGISTRO"
        while ps -p $ID > /dev/null;
        do
                registro_consumo
                sleep $intervalo_lectura_seg
        done

        gnuplot <<EOF
                set terminal png
                set output 'grafica.png'
                set xlabel 'Tiempo'
                set ylabel 'Uso'
		set title 'Porcentaje de consumo de CPU Y MEMORIA'
                plot "$REGISTRO" using 1:2 title 'CPU' with lines, "$REGISTRO" using 1:3 title 'Memoria' with lines
EOF
	echo -e "\nProceso finalizado.\n"
fi
