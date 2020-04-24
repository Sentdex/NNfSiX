# Neural Networks from Scratch in `X`


The idea here is to share [Neural Networks from Scratch tutorial parts](https://www.youtube.com/playlist?list=PLQVvvaa0QuDcjD5BAw2DxE6OF2tius3V3) / [Neural Networks from Scratch book](https://nnfs.io) in various other programming languages, besides just Python.

If you're following along in another language, feel free to contribute to your specific language via a pull request. If you're considering trying to use another language, you can see how others have achieved writing the neural networks from scratch in other languages here too.


## How to contribute:


The plan is to share code from video part #s. I will be updating the Python variants, so, if you are just following the [book](https://nnfs.io), you can see which block(s) of code should be translated by checking out the Python versions.


## Git Submodules notes


Git submodules enable including code from other repositories within this one, which requires a few (though not many) additional Git commands to download and update changes.


Utilize the `--recurse-submodule` options to clone this project along with any Git submodules, eg...


```Bash
git clone --recurse-submodules git@github.com:Sentdex/NNfSiX.git
```


Update/upgrade submodules after pulling via...


```Bash
git pull

git submodule update --init --merge --recursive
```


To contribute to external Git submodules, fork related URL(s) found within the `.gitmodules` file and submit Pull Requests to the related repository. Once accepted by those maintainers a Pull Requests may be submitted here automatically via [Dependabot](https://github.com/marketplace/dependabot-preview) within ~24 hours.
