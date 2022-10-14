# zsh-pyenv

Another zsh plugin for pyenv based the oh-my-zsh version of pyenv plugin with modifications from the rbenv and jenv plugins.

## Usage

To use it, install [`pyenv`](https://github.com/pyenv/pyenv) first.

Then clone this repository into the custom plugins directory as `pyenv` of your
zsh plugin manager which is `$ZSH_CUSTOM`, the following is for
[Oh My Zsh](https://ohmyz.sh/) which is `~/.oh-my-zsh/custom/plugins`.

```bash
git clone https://github.com/TwoPizza9621536/zsh-pyenv.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/exa
```

Finally, add pyenv to the plugins array of your zshrc file:

```bash
plugins=(... pyenv)
```

## License

Under the MIT License with the following SPDX expression:

```text
SPDX-License-Identifier: MIT
```
