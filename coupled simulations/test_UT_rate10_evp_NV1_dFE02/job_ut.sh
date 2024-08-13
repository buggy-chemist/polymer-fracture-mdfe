#!/bin/bash -l
#
# allocate X nodes with 72 cores per node
#SBATCH --nodes=1
#SBATCH --tasks-per-node=72
#SBATCH --partition=singlenode
#SBATCH --time=24:00:00
#SBATCH --export=NONE
#SBATCH --mail-type=ALL

# do not export environment variables
unset SLURM_EXPORT_ENV
# jobs always start in submit directory

# switch to current directory
cd  ${SLURM_SUBMIT_DIR}

# load required modules (compiler, MPI, ...)
module load openmpi/4.1.2-gcc11.2.0
module load matlab/R2022a

# run
../../source/Capriccio_FEMD_main_WZ.sh input_parameters/Capriccio.prm
