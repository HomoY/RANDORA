#!/bin/bash

#mkdir structure

for var in {1..45}
do
#  cd structure
  
  cp INCAR ./VaspInCaF/$var
  cp POTCAR ./VaspInCaF/$var
  cp KPOINTS ./VaspInCaF/$var
 # echo ../$var/POSCAR
  cp script ./VaspInCaF/$var
  cp sub.sh ./VaspInCaF/$var
  cd ./VaspInCaF/$var
  sh sub.sh
  cd ../../
done

