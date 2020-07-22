nodes=(des02 des03 des04 des05 des06 des07 des08 des09 des10 des11 des12 des13 des14)

for node in ${nodes[@]}; do
    echo "killing screens on $node"
    ssh $node.kask "killall screen"
    rank=$((rank+1))
done

killall screen

