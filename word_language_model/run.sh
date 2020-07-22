nodes=(des02 des04 des08 des09 des10 des11 des13)
# des08 des09 des12 des13)

path="/macierz/home/s160690/masters/examples-dist/imagenet/"
url="tcp://172.20.83.201:23456"
args="--epochs 1 --batch-size 128" 

ws=$((${#nodes[@]}+1))

exports="export CCL_TREE_THRESHOLD=1000000000; export CCL_RINGS='3 1 2 0' ; export CCL_TREE=07265143 ; export NCCL_START_RANKS='0123'; export NCCL_START_SEGMENTS='0123'; export NCCL_DEBUG='TRACE'"

rank=1
for node in ${nodes[@]}; do
    echo "starting $node"
    ssh $node.kask "cd $path && screen -dmS torch bash -c \"$exports ; rm $node ; python main.py $args --rank $rank --world-size $ws --dist-url $url 2>> $node \""
    rank=$((rank+1))
done

eval $exports

dir="/macierz/home/s160690/masters/examples-dist/meas/wert/world_language_model/LSTM/ring/ranks$ws/bs$bs/$it"
#dir="/tmp/meas/"
mkdir -p $dir
#echo $NCCL_TREE > "$dir/tree.txt"

node=des01; rm $node

cd $path
python main.py $args --rank 0 --world-size $ws --dist-url "$url"  2>> $node

mv des* $dir
