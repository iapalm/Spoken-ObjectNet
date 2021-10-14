Official code for our Interspeech 2021 - [Spoken ObjectNet: A Bias-Controlled Spoken Caption Dataset](https://www.isca-speech.org/archive/pdfs/interspeech_2021/palmer21_interspeech.pdf) [1]*.

Visually-grounded spoken language datasets can enable models to learn cross-modal correspondences with very weak supervision. However, modern audio-visual datasets contain biases that undermine the real-world performance of models trained on that data. We introduce Spoken ObjectNet, which is designed to remove some of these biases and provide a way to better evaluate how effectively models will perform in real-world scenarios. This dataset expands upon ObjectNet, which is a bias-controlled image dataset that features similar image classes to those present in ImageNet.

***Note: please see the ArXiv version for additional results on the test set.**


## Setup
1.  Clone this module and any submodules: `git clone --recurse-submodules git@github.com:iapalm/Spoken-ObjectNet.git`
2.  Follow the directions in [data.md](data/data.md) to set up ObjectNet images and the Spoken ObjectNet-50k corpus
3.  This code was tested with PyTorch 1.9 with CUDA 10.2 and Python 3.8.8.
4.  To train the models with the code as-is, we use 2 GPUs with 11 Gb of memory. A single GPU can be used, but the batch size or other parameters should be reduced.
5.  **Note about the speed of this code:** This code will work as-is on the Spoken ObjectNet audio captions, but the speed could be greatly improved. A main bottleneck is the resampling of the audio wav files from 48 kHz to 16 kHz, which is done with librosa [here](https://github.com/roudimit/ResDAVEnet-VQ/blob/master/dataloaders/utils.py#L37). We suggest to pre-process the audio files into the desired format first, and then remove this line or the on-the-fly spectrogram conversion entirely. We estimate the speed will improve 5x.
6. On our servers, the zero-shot evaluation takes around 20-30 minutes and training takes around 4-5 days. As mentioned in the previous point, this could be improved with audio pre-processing.

## Running Experiments
We support 3 experiments that can be used as baselines for future work: 
- (1) Zero-shot evaluation of the ResDAVEnet-VQ model trained on Places-400k [2].
- (2) Fine-tuning the ResDAVEnet-VQ model trained on Places-400k on Spoken ObjectNet with a frozen image branch .
- (3) Training the ResDAVEnet-VQ model from scratch on Spoken ObjectNet with a frozen image branch.
- Note: fine-tuning the image branch on Spoken ObjectNet is not permitted, but fine-tuning the audio branch is allowed.

### Zero-shot transfer from Places-400k
- Download and extract the directory containing the model weights from this [link](https://data.csail.mit.edu/placesaudio/Spoken-ObjectNet/models/RDVQ_00000.tar.gz). Keep the folder named `RDVQ_00000` and move it to the `exps` directory.
- In `scripts/train.sh`, change `data_dt` to `data/Spoken-ObjectNet-50k/metadata/SON-test.json` to evaluate on the test set instead of the validation set.
- Run the following command for zero-shot evaluation: `source scripts/train.sh 00000 RDVQ_00000 "--resume True --mode eval"`
- The results are printed in `exps/RDVQ_00000_transfer/train.out`


### Fine-tune the model from Places-400k
- Download and extract the directory containing the `args.pkl` file which specifies the fine-tuning arguments. The directory at this [link](https://data.csail.mit.edu/placesaudio/Spoken-ObjectNet/models/RDVQ_00000_finetune.tar.gz) contains the `args.pkl` file as well as the model weights. 
- The model weights of the fine-tuned model are provided for easier evaluation. Run the following command to evaluate the model using those weights: `source scripts/train.sh 00000 RDVQ_00000_finetune "--resume True --mode eval"`
- Otherwise, to fine-tune the model yourself, first move the model weights to a new folder `model_dl`, then make a new folder `model` to save the new weights, and then run the following command: `source scripts/train.sh 00000 RDVQ_00000_finetune "--resume True"`. This still require the `args.pkl` file mentioned previously.
- Plese note the value of `data_dt` in `scripts/train.sh`. The code saves the best performing model during training, which is why it should be set to the validation set during training. During evaluation, it loads the best performing model, which is why it should be set to the test set during evaluation.

### Train the model from scratch on Spoken ObjectNet
- Run the following command to train the model from scratch: `source scripts/train.sh 00000 RDVQ_scratch_frozen "--lr 0.001 --freeze-image-model True"`
- The model weights can be evaulated with `source scripts/train.sh 00000 RDVQ_scratch_frozen "--resume True --mode eval"`
- We also provide the trained model weights at this [link](https://data.csail.mit.edu/placesaudio/Spoken-ObjectNet/models/RDVQ_scratch_frozen.tar.gz).
- Plese note the value of `data_dt` in `scripts/train.sh`. The code saves the best performing model during training, which is why it should be set to the validation set during training. During evaluation, it loads the best performing model, which is why it should be set to the test set during evaluation.

## Contact
If You find any problems or have any questions, please open an issue and we will try to respond as soon as possible. You can also try emailing the first corresponding author.


## References
[1] Palmer, I., Rouditchenko, A., Barbu, A., Katz, B., Glass, J. (2021) Spoken ObjectNet: A Bias-Controlled Spoken Caption Dataset. Proc. Interspeech 2021, 3650-3654, doi: 10.21437/Interspeech.2021-245

[2] David Harwath*, Wei-Ning Hsu*, and James Glass. Learning Hierarchical Discrete Linguistic Units from Visually-Grounded Speech. Proc. International Conference on Learning Representations (ICLR), 2020

## Spoken ObjectNet - Bibtex:
```bibtex
@inproceedings{palmer21_interspeech,
  author={Ian Palmer and Andrew Rouditchenko and Andrei Barbu and Boris Katz and James Glass},
  title={{Spoken ObjectNet: A Bias-Controlled Spoken Caption Dataset}},
  year=2021,
  booktitle={Proc. Interspeech 2021},
  pages={3650--3654},
  doi={10.21437/Interspeech.2021-245}
}
```