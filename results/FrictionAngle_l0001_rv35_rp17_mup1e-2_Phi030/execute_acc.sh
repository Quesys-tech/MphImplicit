#!/bin/bash

nvidia-smi --query-gpu=index,gpu_bus_id --format=csv,noheader | while read line
do
   col1=$(echo $line | cut -d ',' -f 1)
   col2=$(echo $line | cut -d ',' -f 2)

  if [  $( nvidia-smi --query-compute-apps=pid,gpu_bus_id --format=csv,noheader | grep -c "$col2" ) -eq 0 ]; then
    export CUDA_VISIBLE_DEVICES=${col1}
    echo "CUDA_VISIBLE_DEVICES:$CUDA_VISIBLE_DEVICES"

	../../source/Mph_acc stuck.data stuck.grid stuck%03d.prof stuck%03d.vtk stuck_acc.log 1
	../../source/Mph_acc stuck_cont.data stuck10000.prof stuck%03d.prof stuck%03d.vtk stuck_cont_acc.log 1

    break
  fi
done


