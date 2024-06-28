export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.mujoco/mujoco210/bin

timeout_duration="90s" 

androit_tasks=('door' 'hammer' 'pen')
for task in "${androit_tasks[@]}"; do
    echo "Generating Adroit $task"
    if timeout $timeout_duration bash scripts/gen_demonstration_adroit.sh $task; then
        echo "Generated Adroit $task successfully"
    else
        echo "Timeout reached for $task, skipping to the next task"
    fi
done

dexart_tasks=('laptop' 'faucet' 'bucket' 'toilet')
for task in "${dexart_tasks[@]}"; do
    echo "Generating Dexart $task"
    if timeout $timeout_duration bash scripts/gen_demonstration_dexart.sh $task; then
        echo "Generated Dexart $task successfully"
    else
        echo "Timeout reached for $task, skipping to the next task"
    fi
done

metaworld_tasks=('assembly' 'basketball' 'bin-picking' 'box-close' 'button-press-topdown' 'button-press-topdown-wall' 'button-press' 'button-press-wall' 'coffee-button' 'coffee-pull' 'coffee-push' 'dial-turn' 'disassemble' 'door-close' 'door-lock' 'door-open' 'door-unlock' 'hand-insert' 'drawer-close' 'drawer-open' 'faucet-open' 'faucet-close' 'hammer' 'handle-press-side' 'handle-press' 'handle-pull-side' 'handle-pull' 'lever-pull' 'peg-insert-side' 'pick-place-wall' 'pick-out-of-hole' 'reach' 'push-back' 'push' 'pick-place' 'plate-slide' 'plate-slide-side' 'plate-slide-back' 'plate-slide-back-side' 'peg-unplug-side' 'soccer' 'stick-push' 'stick-pull' 'push-wall' 'reach-wall' 'shelf-place' 'sweep-into' 'sweep' 'window-open' 'window-close')
for task in "${metaworld_tasks[@]}"; do
    echo "Generating Metaworld $task"
    if timeout $timeout_duration bash scripts/gen_demonstration_metaworld.sh $task; then
        echo "Generated Metaworld $task successfully"
    else
        echo "Timeout reached for $task, skipping to the next task"
    fi
done

echo "All demonstrations generated."