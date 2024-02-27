#!/bin/bash
function updater {
echo "Vítejte v updateru hry dark finances"
echo -e "vyberte:\n[1] nainstalovat/updatovat požadované balíčky\n[2] opravit/aktualizovat software\n[3] odinstalovat hru i updater\n[4] ukončit program"
read updater_v1
case $updater_v1 in
1)
    echo "Jaký package manager používáte?"
    echo -e "1 - Pacman\n2 - APT\n3 - DNF"
    read pkginstall_v2
        case $pkginstall_v2 in
        1 | pacman | Pacman)
        sudo pacman -S wget
        ;;
        2 | apt | APT)
        sudo apt install wget
        ;;
        3 | dnf | DNF)
        sudo dnf install wget
        ;;
        *)
        echo "neplatná odpověď"
        updater
        esac
        updater
;;
2)
    sudo unlink /bin/dfinances
    sudo unlink /bin/dfinances-updater
    mkdir -p $HOME/.ds_data/
    mkdir -p $HOME/.ds_data/save
    touch $HOME/.ds_data/timer
    wget -O $HOME/.ds_data/main_df.sh https://raw.githubusercontent.com/solarbaron/dark_finances/main/main_df.sh
    wget -O $HOME/.ds_data/updater_df.sh https://raw.githubusercontent.com/solarbaron/dark_finances/main/updater_df.sh
    sudo ln -s $HOME/.ds_data/main_df.sh /bin/dfinances
    sudo ln -s $HOME/.ds_data/updater_df.sh /bin/dfinances-updater
    updater
;;
3)
 echo "opravdu chcete hru odstranit z tohoto zařízeni?"
 read uninstall_v1
 case $uninstall_v1 in
 ano)
    sudo rm -rf /usr/bin/dfinances
    sudo rm -rf /usr/bin/dfinances-updater
    rm -rf $HOME/.ds_data/
    echo "software byl úspěšně odstraněn z vašeho zařízení, litujeme že jsem se takto rozhodli."
    exit
 ;;
 ne)
 updater
 ;;
 *)
 echo "neplatná odpověď"
 updater
 esac
;;
4)
    exit
;;
*)
echo "neplatná volba"
updater
esac
}
updater