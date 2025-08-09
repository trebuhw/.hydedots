#!/usr/bin/env bash

# instalacja dodatkowych programów
yay -S --noconfirm --needed bat &
yay -S --noconfirm --needed btop &
yay -S --noconfirm --needed eza &
yay -S --noconfirm --needed fish &
yay -S --noconfirm --needed konsole &
yay -S --noconfirm --needed pcloud-drive &
yay -S --noconfirm --needed starship &
yay -S --noconfirm --needed stow &
yay -S --noconfirm --needed tldr &
yay -S --noconfirm --needed trash-cli &
yay -S --noconfirm --needed yazi &
yay -S --noconfirm --needed zoxide &

## backup oryginalnych plików do stow
#
# fastfetch
mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.org &
# fish
mv ~/.config/fish/user.fish ~/.config/fish/user.fish.org &
## hydelocal
# hyde - theme.switch
mv ~/.local/lib/hyde/theme.switch.sh ~/.local/lib/hyde/theme.switch.sh.org &
# local hyprland
mv ~/.local/share/hyde/hyprland.conf ~/.local/share/hyprland/hyprland.conf.org &
# waybar modules
mv ~/.local/share/waybar/modules/clock.jsonc ~/.local/share/waybar/modules/jsonc.org &
# hypr
mv ~/.config/hypr/keybindings.conf ~/.config/hypr/keybindings.conf.org &
# kitty
mv ~/.config/kitty/kity.conf ~/.config/kitty/kity.conf.org &
# starship
mv ~/.config/starship/starship.toml ~/.config/starship/starship.toml.org &
# Vscode
mv ~/.vscode-oss ~/.vscode-oss.bak &
# waybar
mv ~/.config/waybar/theme.css-hw ~/.config/waybar/theme.css-hw.bak &

# Klonowanie
#.dotfiles
cd ~/
git clone --depth=1 https:github.com/trebuhw/.dotfiles.git &
#.hydedots
cd ~/
git clone --depth=1 https://github.com/trebuhw/.hydedots.git &

# stow
cd ~/.dotfiles
stow bat/ btop/ bin/ eza/ starship/ yazi/ &
cd ~/.hydedots
stow fastfetch/ fish/ hydelocal/ hypr/ kitty/ starship/ vscode/ waybar/
