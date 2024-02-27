#!/bin/bash
function installer() {
    echo "Vítejte v installeru hry Dark finances"
    echo "Pro fungovaní installeru a hry budete potřebovat nainstalovat balíčky"
    echo "Chete balíčky nainstalovat automaticky nebo jen vypsat seznam. (1 - nainstalovat/ 2 - vypsat)"
    read pkginstall_v1
    case $pkginstall_v1 in
    vypsat | 2)
    echo -e "\nwget\n"
    ;;
    nainstalovat | 1)
    echo "Jaký package manager používáte?"
    echo -e "1 - Pacman\n2 - APT\n3 - DNF"
    read pkginstall_v2
        case $pkginstall_v2 in
        1 | pacman | Pacman)
        sudo pacman -S wget
        ;;
        2 | apt | APT)
        apt update
        sudo apt install wget
        ;;
        3 | dnf | DNF)
        sudo dnf install wget
        ;;
        *)
        echo "neplatná odpověď"
        installer
        esac
    ;;
    *)
    echo "neplatná odpověď"
    installer
    esac
    mkdir -p $HOME/.ds_data/
    mkdir -p $HOME/.ds_data/save
    touch $HOME/.ds_data/timer
    wget -O $HOME/.ds_data/main_df.sh https://raw.githubusercontent.com/solarbaron/dark_finances/main/main_df.sh
    wget -O $HOME/.ds_data/updater_df.sh https://raw.githubusercontent.com/solarbaron/dark_finances/main/updater_df.sh
    sudo ln -s $HOME/.ds_data/main_df.sh /bin/dfinances
    sudo ln -s $HOME/.ds_data/updater_df.sh /bin/dfinances-updater
    echo "Pro spuštní napište příkaz dfinances nebo pro autualizaci dfinances-updater"

}
installer