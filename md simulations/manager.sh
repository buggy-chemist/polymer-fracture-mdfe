#!/bin/bash

bndint=500 # set bond breaking interval

for i in 3 4 5
do
  mkdir -p seed$i
  cd seed$i
  for bb in {0,15,20,25,30,35,40,50,60}
  # choose bond breaking threshold based on energy
  do
    case $bb in
      15)
        bnd1=6.0922
        bnd2=6.3008
        bnd3=6.0682
        ;;
      20)
        bnd1=6.2129
        bnd2=6.364
        bnd3=6.1963
        ;;
      25)
        bnd1=6.2956
        bnd2=6.4149
        bnd3=6.2862
        ;;
      30)
        bnd1=6.3536
        bnd2=6.4563
        bnd3=6.3558
        ;;
      35)
        bnd1=6.4008
        bnd2=6.492
        bnd3=6.4122
        ;;
      40)
        bnd1=6.441
        bnd2=6.5235
        bnd3=6.4502
        ;;
      50)
        bnd1=6.5478
        bnd2=6.574
        bnd3=6.5203
        ;;
      60)
        bnd1=6.6823
        bnd2=6.644
        bnd3=6.6061
        ;;
      0)
        bnd1=16.0 # threshold greater than largest bond length is no bond breaking.
        bnd2=16.0
        bnd3=16.0
        ;;
    esac
    mkdir -p UniaxialTensile
    cd UniaxialTensile
      mkdir -p ld$bb
      #rm -f ld$bb/*
      cp /data/yjain/bond_breaking_wuyang_sys/PS_equil_orig_ld.in ld${bb}/PS_equil_orig.in
      sed -i 's/${bndint}/'"${bndint}"'/g' ld$bb/PS_equil_orig.in
      sed -i 's/${bndbrk1}/'"${bnd1}"'/g' ld$bb/PS_equil_orig.in  
      sed -i 's/${bndbrk2}/'"${bnd2}"'/g' ld$bb/PS_equil_orig.in  
      sed -i 's/${bndbrk3}/'"${bnd3}"'/g' ld$bb/PS_equil_orig.in
      cp /data/yjain/bond_breaking_wuyang_sys/job_lammps.sh ld$bb/
      cd ld$bb
        sed -i '/break 500 1 16.0/ s/^/#/' PS_equil_orig.in
        sed -i '/break 500 2 16.0/ s/^/#/' PS_equil_orig.in
        sed -i '/break 500 3 16.0/ s/^/#/' PS_equil_orig.in
        sbatch -J W_s${i}ld${bb} job_lammps.sh
      cd ..
    cd ..    

    mkdir -p YZconstant
    cd YZconstant
      mkdir -p yz$bb
      #rm -f yz$bb/*
      cp /data/yjain/bond_breaking_wuyang_sys/PS_equil_orig_yz.in yz${bb}/PS_equil_orig.in
      sed -i 's/${bndint}/'"${bndint}"'/g' yz$bb/PS_equil_orig.in
      sed -i 's/${bndbrk1}/'"${bnd1}"'/g' yz$bb/PS_equil_orig.in  
      sed -i 's/${bndbrk2}/'"${bnd2}"'/g' yz$bb/PS_equil_orig.in  
      sed -i 's/${bndbrk3}/'"${bnd3}"'/g' yz$bb/PS_equil_orig.in
      cp /data/yjain/bond_breaking_wuyang_sys/job_lammps.sh yz$bb/
      cd yz$bb
        sed -i '/break 500 1 16.0/ s/^/#/' PS_equil_orig.in
        sed -i '/break 500 2 16.0/ s/^/#/' PS_equil_orig.in
        sed -i '/break 500 3 16.0/ s/^/#/' PS_equil_orig.in
        sbatch -J W_s${i}yz${bb} job_lammps.sh
      cd ..
    cd ..
  done
  cd ..
done 