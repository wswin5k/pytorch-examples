bss=(8192)
nodes=(des02 des03 des04 des06 des07 des08 des09)
#bss=(4096)

ws=$((${#nodes[@]}+1))

for itit in {0..4} ; do
    #export TR=`python -c "import random; r = list(range($ws)) ;random.shuffle(r) ; print(''.join(map(str, r)))"`
    for bsit in ${bss[@]}; do
        echo "##########################################"
        echo ITER: $itit BATCH SIZE: $bsit
        echo "##########################################"
        export bs=$bsit
        export it=$itit
        ./run.sh
    done
done

