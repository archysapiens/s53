ANIO=2000

while true
do
        if [ "$ANIO" -le 2030 ]
        then
                #echo $ANIO
                ANIO=`expr $ANIO + 1`
                DIA=1
                while true
                do
                        FECHA="$ANIO-01-0"$DIA
                        SEMANA=`date -d $FECHA +"%V"`
                        U=`date -d $FECHA +"%u"`
                        DIA=`expr $DIA + 1`
                        echo "fecha " $FECHA "SEMANA>"$SEMANA"DIA >"$U
                        if [ "$DIA" -ge 10 ]
                        then
                                break
                        fi

                done
        else
                exit
        fi
done
