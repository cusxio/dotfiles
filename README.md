1. Trackpad/Mouse/Dock/Mission Control settings (align monitors correctly in Display to get hot corners)

# https://apple.stackexchange.com/questions/31947/how-to-disable-accentuated-char-suggestion-on-long-click-on-mac
defaults write -g ApplePressAndHoldEnabled -bool false


# https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x/83923#83923
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# Change Textedit to open in Raw


2. Change macOS icons settings


3. Install Homebrew manually

4. Install Dropbox/1Password cask

5. Change computer name in System Preferences -> Sharing

6. sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

7. Make iTerm default Terminal, can do it via iTerm

8. Change Spotlight to Alfred

9. Install Betterzip

10. Setup VSCode Sync Settings. > Sync Download after providing token and gist

https://stackoverflow.com/questions/9270734/ssh-permissions-are-too-open-error

11. chmod 400 ssh key

12. https://github.com/Hammerspoon/hammerspoon/issues/2175
