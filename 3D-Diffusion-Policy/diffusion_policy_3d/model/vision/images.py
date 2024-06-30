from robomimic.models.obs_core import VisualCore
from diffusion_policy_3d.common.pytorch_util import replace_submodules
import torch.nn as nn
from typing import Tuple

def get_dp_image_encoder(input_shape: Tuple[int, int, int], out_features: int = 128) -> VisualCore:
    core_kwargs = dict(
        backbone_class = 'ResNet18Conv',
        backbone_kwargs = dict(pretrained = False, input_coord_conv = False),
        pool_class = "SpatialSoftmax",
        pool_kwargs = dict(num_kp=32, learnable_temperature = False, temperature = 1.0, noise_std = 0.0),
    )

    vis_net = VisualCore(
        input_shape=input_shape,
        feature_dimension=out_features,
        **core_kwargs,
    )

    replace_submodules(
        root_module=vis_net,
        predicate=lambda x: isinstance(x, nn.BatchNorm2d),
        func=lambda x: nn.GroupNorm(num_groups=x.num_features//16, num_channels=x.num_features),
    )

    return vis_net

