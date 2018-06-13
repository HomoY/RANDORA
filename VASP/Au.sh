#!/bin/bash

for varible in {1..227}
do
	cd $varible
 	echo $varible
	cp CONTCAR ../CONTCAR
 	#grep "TOTEN" OUTCAR | tail -1
	#cp ../INCAR ./
       #cp ../POTCAR ./
	#cp ../KPOINTS ./
        #cp ../sub.sh ./
	#cp ../script ./
	#sh sub.sh
	#yhbatch -p gscomp  -N 1 -n 24 -J Au.sh ./script   
  #       echo $E >> ../energy
	#echo $varible $E >> ../comment   
	cd ../ 
done
`
