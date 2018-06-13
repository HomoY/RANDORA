#!/bin/csh
# Defining various SGE parameters
#$ -cwd
#$ -N testmatlab
#$ -e myjob2.err
matlab -nodisplay -nosplash -nodesktop < /home/yhm/jugg/run.m 1>running.log 2>running.err &
