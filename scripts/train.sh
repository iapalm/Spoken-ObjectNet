#!/bin/bash 

vqon=$1    # 00000
name=$2    # RDVQ_00000
args=$3    # "--resume True --freeze-image-model True --lr 0.0001"

data_tr="data/Spoken-ObjectNet-50k/metadata/SON-train.json"
data_dt="data/Spoken-ObjectNet-50k/metadata/SON-val.json"
# data_dt="data/Spoken-ObjectNet-50k/metadata/SON-test.json"

vqonarg=$(echo $vqon | sed 's/./&,/g' | sed 's/,$//g')  # insert ',' in between

expdir="./exps/$name"

echo "DIRECTORY: $expdir"
[ -d "$expdir" ] || mkdir -p "$expdir"

python -u ResDAVEnet-VQ/run_ResDavenetVQ.py --mode train \
    --VQ-turnon $vqonarg --exp-dir $expdir \
    --data-train $data_tr --data-val $data_dt \
    $args >> "$expdir/train.out" 2>&1
