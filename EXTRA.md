## Activate environment

```
mamba activate dp3
```

## Generating all the demonstrations

Ran form the `3D-Diffusion-Policy` folder

```
bash scripts/gen_demonstrations_all.sh
```

## Training policies

For training one polices these are the arguments:

```
bash scripts/train_policy.sh <policy> <task_env>_<task> <info (for saving name)> <seed> <gpu_id>
```

### Training all policies script

```
bash scripts/train_all_policies.sh <policy> <info (for saving name)> <seed> <gpu_id>
```

