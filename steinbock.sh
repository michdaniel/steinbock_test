#!/bin/bash

shopt -s expand_aliases
alias steinbock="docker run -v /mnt/immucan_volume/processed_data/Panel_1/LUNG_cohort:/data -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/.Xauthority:/home/steinbock/.Xauthority:ro -u $(id -u):$(id -g) -e DISPLAY ghcr.io/bodenmillergroup/steinbock:0.13.5"

mkdir /mnt/immucan_volume/processed_data/Panel_1/LUNG_cohort/log/

steinbock preprocess imc panel --namecol Clean_Target

steinbock preprocess imc images --hpf 50 &> /mnt/immucan_volume/processed_data/Panel_1/LUNG_cohort/log/steinbock_img_log.txt

steinbock segment deepcell --minmax &> /mnt/immucan_volume/processed_data/Panel_1/LUNG_cohort/log/steinbock_segmentation_log.txt

steinbock measure intensities --masks masks -o intensities
steinbock measure regionprops --masks masks -o regionprops
steinbock measure neighbors --type expansion --dmax 4 --masks masks -o neighbors
