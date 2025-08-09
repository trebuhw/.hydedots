#!/usr/bin/env bash

# Instalacja dodatkowych programów
echo "Instalacja programów..."
yay -S --noconfirm --needed bat btop eza fish konsole pcloud-drive starship stow tldr trash-cli yazi zoxide

# Backup oryginalnych plików przed użyciem stow
echo "Tworzenie kopii zapasowych..."

# Sprawdzanie i tworzenie katalogów jeśli nie istnieją
mkdir -p ~/.config/{fastfetch,fish,hypr,kitty,starship,waybar}
mkdir -p ~/.local/{lib/hyde,share/{hyde,hyprland,waybar/modules}}

# fastfetch
if [ -f ~/.config/fastfetch/config.jsonc ]; then
    mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.org
fi

# fish
if [ -f ~/.config/fish/user.fish ]; then
    mv ~/.config/fish/user.fish ~/.config/fish/user.fish.org
fi

# hyde - theme.switch
if [ -f ~/.local/lib/hyde/theme.switch.sh ]; then
    mv ~/.local/lib/hyde/theme.switch.sh ~/.local/lib/hyde/theme.switch.sh.org
fi

# local hyprland
if [ -f ~/.local/share/hyde/hyprland.conf ]; then
    mv ~/.local/share/hyde/hyprland.conf ~/.local/share/hyde/hyprland.conf.org
fi

# waybar modules (poprawiona nazwa pliku)
if [ -f ~/.local/share/waybar/modules/clock.jsonc ]; then
    mv ~/.local/share/waybar/modules/clock.jsonc ~/.local/share/waybar/modules/clock.jsonc.org
fi

# hypr
if [ -f ~/.config/hypr/keybindings.conf ]; then
    mv ~/.config/hypr/keybindings.conf ~/.config/hypr/keybindings.conf.org
fi

# kitty (poprawiona nazwa pliku)
if [ -f ~/.config/kitty/kitty.conf ]; then
    mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.org
fi

# starship
if [ -f ~/.config/starship/starship.toml ]; then
    mv ~/.config/starship/starship.toml ~/.config/starship/starship.toml.org
fi

# Vscode
if [ -d ~/.vscode-oss ]; then
    mv ~/.vscode-oss ~/.vscode-oss.bak
fi

# waybar
if [ -f ~/.config/waybar/theme.css-hw ]; then
    mv ~/.config/waybar/theme.css-hw ~/.config/waybar/theme.css-hw.bak
fi

# Klonowanie repozytoriów
echo "Klonowanie repozytoriów..."

# .dotfiles
cd ~/
if [ ! -d ~/.dotfiles ]; then
    git clone --depth=1 https://github.com/trebuhw/.dotfiles.git
else
    echo "Katalog .dotfiles już istnieje"
fi

# .hydedots
cd ~/
if [ ! -d ~/.hydedots ]; then
    git clone --depth=1 https://github.com/trebuhw/.hydedots.git
else
    echo "Katalog .hydedots już istnieje"
fi

# Aplikowanie konfiguracji za pomocą stow
echo "Aplikowanie konfiguracji..."

if [ -d ~/.dotfiles ]; then
    cd ~/.dotfiles
    echo "Aplikowanie konfiguracji z .dotfiles..."
    stow --no-folding bat/ btop/ bin/ eza/ starship/ yazi/ 2>/dev/null || echo "Niektóre pliki z .dotfiles już istnieją - pomijam"
else
    echo "Błąd: katalog ~/.dotfiles nie istnieje"
fi

if [ -d ~/.hydedots ]; then
    cd ~/.hydedots
    echo "Aplikowanie konfiguracji z .hydedots..."
    stow --no-folding fastfetch/ fish/ hydelocal/ hypr/ kitty/ starship/ vscode/ waybar/ 2>/dev/null || echo "Niektóre pliki z .hydedots już istnieją - pomijam"
else
    echo "Błąd: katalog ~/.hydedots nie istnieje"
fi

echo "Instalacja zakończona!"