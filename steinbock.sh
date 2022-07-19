
#!/bin/bash

shopt -s expand_aliases
alias steinbock="docker run -v /mnt/bbdqbm/micdan/Data/20220707_Ican_p2_v07:/data -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/.Xauthority:/home/steinbock/.Xauthority:ro -u $(id -u):$(id -g) -e DISPLAY ghcr.io/bodenmillergroup/steinbock:0.13.5"

mkdir /mnt/bbdqbm/micdan/Data/20220707_Ican_p2_v07/log/
steinbock preprocess imc panel --namecol Target

steinbock preprocess imc images --hpf 50 &> /mnt/bbdqbm/micdan/Data/20220707_Ican_p2_v07/log/steinbock_img_log.txt

steinbock segment deepcell --minmax &> /mnt/bbdqbm/micdan/Data/20220707_Ican_p2_v07/log/steinbock_segmentation_log.txt

steinbock measure intensities --masks masks -o intensities
steinbock measure regionprops --masks masks -o regionprops
steinbock measure neighbors --type expansion --dmax 4 --masks masks -o neighbors
