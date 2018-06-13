# RANDORA
Structure classification, Physics, Random structure, PES prediction, structure comparison
% software trees
 run.m Control all the part 
    1.  Parameter Part
        > ParameterInput.m --> Define the Parameter

    2.  Parallel Work Part --> set the parallel workspace 
        > RandSeedGenerate.m -->Get the random result, AtomNamePositionMatrix is [Name, X, Y, Z] data structures until the input to the compare
        > CoreSet.m --> set the core and matlab environment
        > UploadWork.m -->upload work and get the PID

    2.  Lammps Dealing Part  --> use lammps generate and calssiied them original structure, this function can be repalced by the data with (name, x, y, z) format
        > LammpsGenerate.m --> use lammps run the original structure
        > K_H files(KabschIterateHungarian.m, Kabsch.m, Munkres.m) --> Compare two structure and get the distance
        > PerCoreWork.m --> Use LammpsGenerate.m to generate structure and then classify them

    4.  Vasp Run Part  --> run the vasp
        >VaspParameter --> This can be used to generate the Vasp parameter
        >VaspRun.m --> Set automated uploading program
