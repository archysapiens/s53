ANIO=1900
while true
do
        if [ "$ANIO" -le 2050 ]
        then
		ANIO_MAIN=$ANIO
                #echo $ANIO
                DIA=1
                while true
                do
                        FECHA="$ANIO-01-0"$DIA
                        SEMANA=`date -d $FECHA +"%V"`
                        U=`date -d $FECHA +"%u"`
			U_ORI=$U
			echo "Fecha a analizar  >>" $FECHA " SEMANA>"$SEMANA" DIA >"$U

			if [ "$U" -eq 1 ] && [ "$SEMANA" = "01" ]
			then 
				#echo "Es el Primer dia de la semana >>" $FECHA " SEMANA>"$SEMANA" DIA >"$U
				echo "$ANIO=>> $U_ORI =>>"$FECHA " SEMANA =>>"$SEMANA" DIA =>>"$U
                		DIA=0
				break
			else
				echo "       #### buscando primer dia desde la fecha >>" $FECHA " SEMANA>"$SEMANA" DIA >"$U
				if [ "$SEMANA" = "01" ]
				then
					echo "ABAJO"

					DIA_ANT=1
					ANIO_TMP=$ANIO
					ANIO=`expr $ANIO - 1`
					while true
					do
						DIA_MES=`grep "^""$DIA_ANT" posisionador.txt|awk '{print $2}'`
						NUEVA_FECHA="$ANIO""-12-"$DIA_MES
						UU=`date -d $NUEVA_FECHA +"%u"`
						SEMANA_NUEVA=`date -d $NUEVA_FECHA +"%V"`
						echo "       ##### NUEVA_FECHA >>"$NUEVA_FECHA"<< SEMANA >>"$SEMANA_NUEVA" DIA >>"$UU

						if [ "$DIA_ANT" -eq 8 ] || [ "$UU" -eq 1 ]
						then
							#echo "       Encontre  el primer dia de la semana FECHA >>"$NUEVA_FECHA" SEMANA >>"$SEMANA_NUEVA" DIA>>"$UU
							echo "$ANIO_MAIN=>> $U_ORI =>>"$NUEVA_FECHA " SEMANA =>>"$SEMANA_NUEVA" DIA =>>"$UU
							DIA=0
							break
						fi
						DIA_ANT=`expr $DIA_ANT + 1`
					done
					ANIO=$ANIO_TMP
					echo "       ##### fin while  1"
					if [ "$DIA" -eq 0 ] 
					then
						break
					fi
				else
					echo "ARRIBA"
				fi 
			fi
			

                        DIA=`expr $DIA + 1`
                        #echo "fecha " $FECHA " SEMANA>"$SEMANA" DIA >"$U
			echo "#######################"
			echo ""

                        if [ "$DIA" -ge 10 ]
                        then
				echo "Break DIA >>" $DIA
                                break
                        fi

                done
        else
                exit
        fi
        ANIO=`expr $ANIO + 1`
	echo "       ##### fin while  2"
done
