# Setup

```bash
pyenv install 2.7.12
pyenv install 3.5.2

pyenv virtualenv 2.7.12 neovim2
pyenv virtualenv 3.5.2 neovim3

pyenv activate neovim2
pip install neovim
pyenv which python  # Note the path

pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path
```
