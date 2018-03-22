
#l/bin/bash
#numero de procesos
NUEMPROCESOS=$( ps ax | tail -n +2 | wc -l)

#memoria ram libre
valorMemoriaLibre=$(vmstat | tail -n 1 | awk '{print $4}')

#memoria ram total
valorMemoriaTotal=$(free | grep Mem | awk '{print $2}')

#porcentaje memoria ram libre
mulRam=$((${valorMemoriaLibre} * 100))
porcentajeRam=$((${mulRam} / ${valorMemoriaTotal}))


echo ${porcentajeRam}
#porcentaje libre HD

porcentajeHD=$(df | grep root | awk '{print $5}' | cut -c1-2)
porcentajeHD=$((100 - ${porcentajeHD}))

echo ${porcentajeHD}


echo ${NUEMPROCESOS}
curl --silent --request POST --header "X-THINGSPEAKAPIKEY:DEDTHRLIXWNGPFR3" --data "field1=${NUEMPROCESOS}&field2=${porcentajeRam}&field3=${porcentajeHD}" http://api.thingspeak.com/update


