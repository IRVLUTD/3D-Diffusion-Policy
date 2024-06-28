export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.mujoco/mujoco210/bin

# Get command line arguments
policy_name=${1}
additional_info=${2}
seed=${3}
gpu_id=${4}

# Construct list of all tasks
adroit_tasks=('door' 'hammer' 'pen')
dexart_tasks=('laptop' 'faucet' 'bucket' 'toilet')
metaworld_tasks=('assembly' 'basketball' 'bin-picking' 'box-close' 'button-press-topdown' 'button-press-topdown-wall' 'button-press' 'button-press-wall' 'coffee-button' 'coffee-pull' 'coffee-push' 'dial-turn' 'disassemble' 'door-close' 'door-lock' 'door-open' 'door-unlock' 'hand-insert' 'drawer-close' 'drawer-open' 'faucet-open' 'faucet-close' 'hammer' 'handle-press-side' 'handle-press' 'handle-pull-side' 'handle-pull' 'lever-pull' 'peg-insert-side' 'pick-place-wall' 'pick-out-of-hole' 'reach' 'push-back' 'push' 'pick-place' 'plate-slide' 'plate-slide-side' 'plate-slide-back' 'plate-slide-back-side' 'peg-unplug-side' 'soccer' 'stick-push' 'stick-pull' 'push-wall' 'reach-wall' 'shelf-place' 'sweep-into' 'sweep' 'window-open' 'window-close')

all_tasks=()

for task in "${adroit_tasks[@]}"; do
  all_tasks+=("adroit_$task")
done

# Expert demonstration generation for dexart isn't working 
# for task in "${dexart_tasks[@]}"; do
#   all_tasks+=("dexart_$task")
# done

for task in "${metaworld_tasks[@]}"; do
  all_tasks+=("metaworld_$task")
done

# Training the policies
task_count=0
total_tasks=${#all_tasks[@]}
for task in "${all_tasks[@]}"; do
    echo "$task_count / $total_tasks - Training $policy_name on $task"
    echo "Running: bash scripts/train_policy.sh $policy_name $task $additional_info $seed $gpu_id"
    bash scripts/train_policy.sh $policy_name $task $additional_info $seed $gpu_id
    ((task_count++))
done

echo "Finished training policies"