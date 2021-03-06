

#########################################################################
##                                                                     ##
## Script : calcula_dia_ini_semana.ksh                                 ##
## Ojtvo  : Calcular el primer dia de incio de cualquier semana y año  ##
##                                                                     ##
## SIntaxis: calcula_dia_ini_semana.ksh ANIO SEMANA                    ##
##                                                                     ##
##                                                                     ##
##                                                                     ##
##                                                                     ##
##                                                                     ##
#########################################################################

LIMITE_SEMANAS=53
SPACE="     "
ANIO=$1
LIMITE=$1
SEMANA_INI=$2
DIA=86400
LUNES=1
PRIMER_DIA=$ANIO"-01-01"
EU_PRIMER_DIA=`date --date=$PRIMER_DIA +%s`
SEM_PRIMER_DIA=`date --date=$PRIMER_DIA +%u`
DIAS_COMPL=`expr \( $SEMANA_INI - 1 \) \* 7  `
EU_DIAS_COMPL=`expr $DIAS_COMPL \* $DIA `
EU_TOTAL=`expr  $EU_PRIMER_DIA + $EU_DIAS_COMPL `

BANDERA_53=`expr \( $ANIO + $ANIO / 4 - $ANIO / 100 + $ANIO / 400 \) % 7`
#echo "BANDERA_53>>"$BANDERA_53

if [ $SEMANA_INI -gt $LIMITE_SEMANAS  ] 
then
	echo "Este anio "$ANIO " excede en semanas >>"$SEMANA_INI
	exit 1
else
	if [ $BANDERA_53 -ne 4  ] && [ $BANDERA_53 -ne 3  ] && [ $LIMITE_SEMANAS -eq $SEMANA_INI  ]
	then
		echo "Este anio "$ANIO " No tiene  $SEMANA_INI  semanas "
		exit 2
	fi
fi

#echo "PRIMER_DIA >>"$PRIMER_DIA" EU_PRIMER_DIA>>"$EU_PRIMER_DIA" DIAS_COMPL>>"$DIAS_COMPL" SEM_PRIMER_DIA>>"$SEM_PRIMER_DIA
#echo "EU_DIAS_COMPL >>"$EU_DIAS_COMPL" EU_TOTAL>>"$EU_TOTAL

#date --date="@$EU_TOTAL" +"%Y-%m-%d %Y %V %u"
ANIO_LOOP=`date --date="@$EU_TOTAL" +"%Y"`
SEM_LOOP=`date --date="@$EU_TOTAL" +"%V"`
DIA_LOOP=`date --date="@$EU_TOTAL" +"%u"`

#echo "ANIO_LOOP>>"$ANIO_LOOP
#echo "SEM_LOOP>>"$SEM_LOOP
#echo "DIA_LOOP>>"$DIA_LOOP

while true
do
	if [ $ANIO_LOOP -eq $ANIO ]
	then
		if  [ $SEMANA_INI -eq $SEM_LOOP ]
		then
			if  [ $DIA_LOOP -eq $LUNES ]
			then
				#echo "IF EU_TOTAL>>"$EU_TOTAL
				#PRIMER_DIA_SEMANA=`date --date="@$EU_TOTAL" +"%Y-%m-%d  %G %V %u"`
				ANIO_SEM_DIA=`date --date="@$EU_TOTAL" +"%G %V %u"`
				PRIMER_DIA_SEMANA=`date --date="@$EU_TOTAL" +"%Y-%m-%d"`
				#echo "Primer dia de la semana >>"$PRIMER_DIA_SEMANA
				echo "$PRIMER_DIA_SEMANA|$ANIO_SEM_DIA|"
				break
			else
				echo "Recalculo de dias"
				RECALCULO=`expr \( $DIA_LOOP - 1 \) \* $DIA`
				EU_TOTAL=`expr $EU_TOTAL - $RECALCULO `
				#date --date="@$EU_TOTAL" +"%Y-%m-%d %G %V %u"
				ANIO_LOOP=`date --date="@$EU_TOTAL" +"%G"`
				SEM_LOOP=`date --date="@$EU_TOTAL" +"%V"`
				DIA_LOOP=`date --date="@$EU_TOTAL" +"%u"`
				#echo "ANIO_LOOP>>"$ANIO_LOOP
				#echo "SEM_LOOP>>"$SEM_LOOP
				#echo "DIA_LOOP>>"$DIA_LOOP
				#echo "EU_TOTAL>>"$EU_TOTAL
			fi
		else
			#echo  "$SPACE RECALCULO POR SEMANAS  SEM_LOOP>>"$SEM_LOOP" SEMANA_INI>>"$SEMANA_INI
			if  [ $SEMANA_INI -gt $SEM_LOOP ]
			then
				#echo "$SPACE SEMANA_INI $SEMANA_INI mayor a SEM_LOOP $SEM_LOOP "
				RECALCULO=`expr \( 7 - $DIA_LOOP  + 1  \) \* $DIA`
				EU_TOTAL=`expr $EU_TOTAL +  $RECALCULO `
				#date --date="@$EU_TOTAL" +"%Y-%m-%d %G %V %u"
				ANIO_LOOP=`date --date="@$EU_TOTAL" +"%G"`
				SEM_LOOP=`date --date="@$EU_TOTAL" +"%V"`
				DIA_LOOP=`date --date="@$EU_TOTAL" +"%u"`
				
			else
				#echo "$SPACE Recalculo de Semanas"
				RECALCULO=`expr \( 7 - $DIA_LOOP + 1  \) \* $DIA`
				EU_TOTAL=`expr $EU_TOTAL +  $RECALCULO `
				#date --date="@$EU_TOTAL" +"%Y-%m-%d %G %V %u"
				ANIO_LOOP=`date --date="@$EU_TOTAL" +"%G"`
				SEM_LOOP=`date --date="@$EU_TOTAL" +"%V"`
				DIA_LOOP=`date --date="@$EU_TOTAL" +"%u"`
				#echo "$SPACE ANIO_LOOP>>"$ANIO_LOOP
				#echo "$SPACE SEM_LOOP>>"$SEM_LOOP
				#echo "$SPACE DIA_LOOP>>"$DIA_LOOP
				#echo "$SPACE EU_TOTAL>>"$EU_TOTAL
			fi
		fi
	else
		echo "ERROR ANIO_LOOP>>"$ANIO_LOOP
	fi
done



