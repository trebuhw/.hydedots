#!/usr/bin/env bash

set -e # Przerwij przy błędzie

# Sprawdź czy nie jest uruchamiany jako root
if [[ $EUID -eq 0 ]]; then
  echo "Błąd: Nie uruchamiaj tego skryptu jako root!"
  exit 1
fi

echo "Instalacja HyDE..."

# Sprawdź czy jesteś na Arch Linux
if ! command -v pacman &>/dev/null; then
  echo "Błąd: Ten skrypt wymaga Arch Linux (pacman nie znaleziony)"
  exit 1
fi

echo "Pobieranie niezbędnych pakietów Archlinux"
sudo pacman -S --needed git base-devel

# Sprawdź czy katalog już istnieje
if [[ -d ~/HyDE ]]; then
  echo "Ostrzeżenie: Katalog ~/HyDE już istnieje. Usuwam..."
  rm -rf ~/HyDE
fi

echo "Klonowanie repozytorium HyDE"
git clone --depth 1 https://github.com/HyDE-Project/HyDE ~/HyDE

echo "Uruchamiam instalację HyDE"
cd ~/HyDE/Scripts

# Sprawdź czy skrypt instalacyjny istnieje
if [[ ! -f ./install.sh ]]; then
  echo "Błąd: Nie znaleziono skryptu install.sh"
  exit 1
fi

# Upewnij się że skrypt jest wykonywalny
chmod +x ./install.sh
./install.sh

echo "Instalacja HyDE zakończona!"
