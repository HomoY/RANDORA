#This file is used to collect the file in the linux and put all of them in one file  
mkdir CollectAu
#arr_number=(1 13 26 35 31 45);
arr_number=(1);
for var in {4..4}
do 
    #Read from every files content
    for fileNumber in {1..${arr_number[$var-3]}}
    do
        mkdir CollectAu/$var
        cp Au$var/VaspInCaF/$fileNumber/CONTCAR CollectAu/$var/$fileNumber 
        grep 'free  energy   TOTEN' Au$var/VaspInCaF/$fileNumber/OUTCAR > CollectAu/Energy$fileNumber

    done



done    