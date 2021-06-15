# Spoken-ObjectNet
Official code for Spoken ObjectNet: A Bias-Controlled Spoken Caption Dataset


## Setup
1.  Clone this module and any submodules
2.  Follow the directions in [data.md](data/data.md) to set up ObjectNet images and the Spoken ObjectNet-50k corpus
3.  If you want to use pretrained `ResDAVEnet-VQ` models, follow the instructions in [exps.md](exps/exps.md).


## Running Experiments
There is an [example script](scripts/train.sh) in this repository that creates a directory for an experiment and runs the `ResDAVEnet-VQ` training code.  This script accepts three arguments:
* `vqon`: The vector quantization layers to turn on (explained in greater detail in the [ResDAVEnet-VQ repo](https://github.com/wnhsu/ResDAVEnet-VQ)
* `name`: The name of the experiment, which will be the name of the `./exps/name` directory
* `args`: Arguments to pass on to the Python script.  These can include the following:
    * `--resume True`: attempts to resume training from a checkpoint saved in `exps/name`
    * `--freeze-image-model True`: freeze the image model during training
    * `--lr 0.001`: Change the model learning rate

### Examples:
Run an experiment with no VQ layers, called `RDVQ_test`:
`source scripts/train.sh 00000 RDVQ_test`

Run the above experiment, now with a frozen image branch:
`source scripts/train.sh 00000 RDVQ_test "--freeze-image-branch True"`

Resume training from a pretrained checkpoint, which was extracted into the `exps/RDVQ_00000` directory:
`source scripts/train.sh 00000 RDVQ_00000_resume "--resume True"`
