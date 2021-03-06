# A function to echo in blue color
function blue() {
	es=`tput setaf 4`
	ee=`tput sgr0`
	echo "${es}$1${ee}"
}

if [ "$#" -ne 1 ]; then
    blue "Illegal number of parameters"
	blue "Usage: ./run-machine.sh <machine_number>"
	exit
fi

num_processes=1

for i in `seq 1 $num_processes`; do
	id=`expr $1 \* $num_processes + $i`
	port=`expr 18515 + $id`
	blue "Running client $id on port $port"
	ib_atomic_bw --ib-dev=mlx5_0 --post_list=32 --run_infinitely --port=$port --qp 64 10.113.211.71 &
	#ib_atomic_bw --ib-dev=mlx5_0 --post_list=32 --run_infinitely --port=$port --atomic_type=CMP_AND_SWAP 10.113.211.71 &
done

