## Experiment Setup

If you wish to use pretrained `ResDAVEnet-VQ` models, follow these steps:
* Download one of the pretrained models from the `ResDAVEnet-VQ` repository: https://github.com/wnhsu/ResDAVEnet-VQ
* Extract the archive into `exps/`, creating a new experiment folder.  Make a copy if desired.
* Use the `--resume True` Python option when running `train.sh` from the repository root directory, and set the name equal to the name of the experiment directory you just created.
