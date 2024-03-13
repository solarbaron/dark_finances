#!/bin/bash
#darksouls 4

#vsechny funkce
function game() {
trap 'cleanup' SIGTERM SIGINT #EXIT 
pocet_pujcek=0
trezor_bal=0
pocet_pujcek=0
xp=0
health=0
attack=0
luck=0
special_ability=0
money=0
#character=0 #classa hrace
infocentrum_view=0 #nastaveni zobrazovani napovedy infocentra
arena_kc_random=0 #kill count random bojovniku arena
nickname=none

current_location=Prague_predmesti

#vsechny banka funkce
#diky tomuhle se pri vypnuti procesu udelaji jeste nejaky veci
function cleanup() {
save
exit
}
function timer_port() {
  
time_seconds=20
while [ $time_seconds -gt 0 ]; do
  sleep 1
  time_seconds=$((time_seconds - 1))
  echo $time_seconds > $HOME/.ds_data/timer
done
#nekonecnej loop
while :
do
    sleep 60 #delay
done
}
function save() {
  echo "Chcete hru uložit? (ano/ne)"
  read save_1
  if [ "$save_1" == "ano" ]; then
    echo "jak chcete save file pojmenovat"
    read save_name
    touch "$HOME/.ds_data/save/$save_name"
    {
      echo "pocet_pujcek=$pocet_pujcek"
      echo "trezor_bal=$trezor_bal"
      echo "xp=$xp"
      echo "health=$health"
      echo "attack=$attack"
      echo "luck=$luck"
      echo "special_ability=$special_ability"
      echo "money=$money"
      echo "character=$character"
      echo "nickname=$nickname"
      echo "heslo=$heslo"
    } > "$HOME/.ds_data/save/$save_name"
 else
    echo "konec"
  fi
}

function registrace() {
    clear
    echo "Pro používání této hry a save systému se zaregistruj"
    echo ""
    echo "-----------------------------------"
    echo "Váš nový nickname:"
    echo "-----------------------------------"
    sleep 0.2
    read -r nickname
    clear
    echo "Pro používání této hry a save systému se zaregistruj"
    echo ""
    echo "-----------------------------------"
    echo "Váš nový nickname: $nickname"
    echo "-----------------------------------"
    sleep 0.2
    echo "Zadejte své heslo:"
    echo "-----------------------------------"
    heslo=""
    while IFS= read -s -n 1 char; do
        # Pokud je stisknut Enter, ukončíme smyčku
        if [[ $char == $'\0' ]]; then
            break
        fi
        heslo+="*"
        echo -n "*"
    done
    echo ""
}

function login() {
    clear
    echo "Přihlášení:"
    echo ""
    echo ""
    echo "-----------------------------------"
    echo "  Zadejte svůj nickname"
    echo "-----------------------------------"
    sleep 0.2
    read -r nickname1

    if [[ "$nickname1" == "$nickname" ]]; then
        echo "-----------------------------------"
        echo "  Zadejte své heslo"
        echo "-----------------------------------"
        sleep 0.2
        heslo1=""
        while IFS= read -s -n 1 char; do
            # Pokud je stisknut Enter, ukončíme smyčku
            if [[ $char == $'\0' ]]; then
                break
            fi
            heslo1+="*"
            echo -n "*"
        done
        echo ""

        if [[ "$heslo" == "$heslo1" ]]; then
            clear
            echo "Úspěšně jste se přihlásil"
            sleep 0.2
            clear
        else 
            echo "Zadali jste nesprávné heslo. Zkuste to znovu :("
        fi
    else
        echo "Uživatel s tímto jménem neexistuje."
    fi 
}


function loading1() {

for i in {1..10}; do
  echo "█▒▒▒▒▒▒▒▒▒▒ $((i * 1)) %"
   sleep 0.1
   clear
   done
  for i in {10..20}; do
  echo "██▒▒▒▒▒▒▒▒▒ $((i * 1)) %"
   sleep 0.1
   clear
   done
  for i in {20..30}; do
  echo "███▒▒▒▒▒▒▒▒ $((i * 1)) %"
   sleep 0.1
   clear
   done
  for i in {30..40}; do
  echo "████▒▒▒▒▒▒▒ $((i * 1)) %"
   sleep 0.1
  clear
done
for i in {40..50}; do
  echo "█████▒▒▒▒▒▒ $((i * 1)) %"
   sleep 0.1
   clear
   done
  for i in {50..60}; do
  echo "██████▒▒▒▒▒ $((i * 1)) %"
   sleep 0.1
   clear
   done
  for i in {60..70}; do
  echo "███████▒▒▒▒ $((i * 1)) %"
   sleep 0.1
   clear
   done
  for i in {70..80}; do
  echo "████████▒▒▒ $((i * 1)) %"
   sleep 0.1
  clear
done
for i in {80..93}; do
  echo "█████████▒▒ $((i * 1)) %"
   sleep 0.1
  clear
done
for i in {93..98}; do
  echo "██████████▒ $((i * 1)) %"
   sleep 1.5 
  clear
done
for i in {98..100}; do
  echo "██████████▒ $((i * 1)) %"
   sleep 6
  clear
  if [[ $i == 99 ]]; then
  echo "Loading completed!"
  sleep 4
  clear
  fi
done

}

function s_load() {
echo "chcete nacist save (ano/ne)"
read load_1
case $load_1 in
ano)
ls $HOME/.ds_data/save/
echo "vyberte save file"
read s_load_name
if [ -f "$HOME/.ds_data/save/$s_load_name" ]; then
source $HOME/.ds_data/save/$s_load_name
#echo $health #debug
else
echo "tento save file neexistuje"
s_load
fi
;;
ne)
echo " "
;;
*)
s_load
esac
}

#funkce na placení úroků
function p_uroky() {
if [[ pocet_obdobi_pujcka == 0 ]]; then
pocet_pujcek=0
fi
if [[ $pocet_pujcek == 0 ]]; then
echo "nemate pujcku na zaplaceni"
banka
fi
echo "výteje chcete zaplatit urok "$name"?"
time_left=$(cat $HOME/.ds_data/timer)
if [[ $time_left -le 0 ]]; then
echo "uz to melo byt davno zaplacene ale tak kdyz uz jste tady"
else
time_left=$(cat $HOME/.ds_data/timer)
echo "do zaplaceni vam zbyva jeste $time_left sekund"
fi
echo "zbyva vam jeste $pocet_obdobi_pujcka splátek"
read -p "chcete zaplatit urok $name? bude vas stat $urok_jedno_obdobi: " p_uroky_volba
case $p_uroky_volba in
ano)
if [[ $money -le $urok_jedno_obdobi ]]; then
echo "nemate na zaplaceni pujcky dostatek peněz"
banka
fi
money=$((money-urok_jedno_obdobi))
pocet_obdobi_pujcka=$((pocet_obdobi_pujcka-1))
kill $timer_pid
timer_port &
banka
;;
ne)
banka
;;
*)
echo "neplatna volba"
p_uroky
esac
}

#function pujcka

function pujcka() {
  echo "Chcete se podívat na podmínky půjčky?"
  read pujcka_tos_vyber
  case $pujcka_tos_vyber in
    ano)
    echo "|------------------------------"
    echo "|  Měsíční úrok: 5% z pujcene castky + pujcena castka / poctem období."
    echo "|  Pokud nezaplatíte jen jeden ůrok v ujednaném čase bude za vámi vyslán vymahač."
    echo "|  Počet splátek je je min 2 obdobi max 24 obdobi."
    echo "|  Na každou splátku máte čas na zaplacení 1h reálného času."
    echo "|------------------------------"
    ;;
    ne)
    ;;
    *)
    echo "Neplatná volba."
    pujcka
    ;;
  esac
  echo "Pořád si přejete si půjčit?"
  read pujcka_vyber
  case $pujcka_vyber in
  ano)
    echo "Kolik chcete splátek?"
    read pocet_obdobi_pujcka_volba
    if [ $pocet_obdobi_pujcka_volba -ge 2 ] && [ $pocet_obdobi_pujcka_volba -le 24 ]; then
    pocet_obdobi_pujcka=$((pocet_obdobi_pujcka_volba))
    echo "Počet splátek je $pocet_obdobi_pujcka"
    else
    echo "Omlouváme se vám $name ale vase pujcka nesplnuje pozadavky na pocet obdobi pujcky"
    pujcka
    fi
    echo "Kolik peněz si chcete půjčit?"
    read pujcka_money_volba
    if [[ $pujcka_money_volba -gt $((3*(money+bank))) ]] || [[ $pocet_pujcek -ge 1 ]] || [[ $pujcka_money_volba -le 0 ]]; then
    echo "Omlouváme se vám $name ale nesplnujete pozadavky pro pujcku"
    banka
    
    else
      pujcka_money=$((pujcka_money_volba))
      pocet_pujcek=$((pocet_pujcek+1))
      echo "Půjčili jste si $pujcka_money Kč"
      money=$((money+pujcka_money))
      urok_jedno_obdobi=$(((pujcka_money / pocet_obdobi_pujcka) + (pujcka_money / 20)))
      celkem=$((pocet_obdobi_pujcka * urok_jedno_obdobi))
      echo "Váš úrok na jednmo období je $urok_jedno_obdobi Kč"
      echo "platíte $pocet_obdobi_pujcka období"
      echo "Celkem zaplatíte $celkem Kč"
      timer_port &
      timer_pid=$!
      sleep 5
      time_left=$(cat $HOME/.ds_data/timer)
      echo "do zaplacení další splátky vám zbvývá $time_left sekund"
      banka
    fi
  ;;
  ne)
  banka
  ;;
  *)
  echo "Neplatná volba."
  pujcka
  esac
}
function podpis_banka () {
echo "Prosíme podepište tuto smlouvu svým jménem"
read podpis
if [ "$podpis" == "$name" ]; then
  echo "úspěšně jste podepsali smlouvu"
else
  echo "To se snad neumíte podpsat nebo co?"
  podpis_banka
fi
}
#trezor
function trezor() {
  echo "Chceš vybrat peníze, uložit nebo odejít?"
  echo "|------------------------------"
  echo "|  U sebe mate $money peněz"
  echo "|  V bance máte uloženo $trezor_bal peněz"
  echo "|------------------------------"
  echo "|         1. Uložit"
  echo "|         2. Vybrat"
  echo "|         3. zpět"
  echo "|------------------------------"
  read vyber_trezor
  case $vyber_trezor in

    1 | uložit | ULOŽIT | ulozit | ULOZIT)
    echo "U sebe mate $money peněz"
    echo "V bance máte uloženo $trezor_bal peněz"
    echo "Kolik chcete uložit?"
    read ulozit_trezor_money
    if [ $ulozit_trezor_money -gt $money ]; then
    echo "U sebe nemate dostatek penez."
    else
    money=$((money-ulozit_trezor_money))
    trezor_bal=$((trezor_bal+ulozit_trezor_money))
    trezor
    fi
    ;; 
    2 | vybrat | VYBRAT)
    echo "U sebe mate $money peněz"
    echo "V bance máte uloženo $trezor_bal peněz"
    echo "Kolik chcete vybrat?"
    read vybrat_trezor_money
    if [ $vybrat_trezor_money -gt $trezor_bal ]; then
    echo "V trezoru nemate dostatek penez."
    else
    trezor_bal=$((trezor_bal-vybrat_trezor_money))
    money=$((money+vybrat_trezor_money))
    fi
    trezor
    ;;
    3 | zpět | ZPĚT | zpet | ZPET)
    echo "Odchazite"
    banka
    ;;
    esac
    }
#location
function banka() {
  echo "Vítej v bance $name"
  echo ""
  echo "Co chcete provést"
  echo ""
  #read -p "Stiskni enter pro otevření nabídky" key
  echo "|------------------------------"
  echo "|         1. Uložit nebo vybrat peníze z trezoru."
  echo "|         2. Půjčení"
  echo "|         3. Platit uroky"
  echo "|         4. Odejít"
  echo "|------------------------------"
  read -p "Zadej číslo: " vyber_bank
  case $vyber_bank in
    1)
    trezor
    ;;
    2)
    pujcka
    ;;
    3)
    p_uroky
    ;;
    4)
    $current_location
    ;;
    *)
    echo "neplatna volba"
    banka
  esac
}
function arena() {
  echo "Vítej v aréně $name"
  echo "Pro vypsání pravidel (rules)"
  echo "Pro souboje (fight)"
  read pravidla_arena_vyber
  case $pravidla_arena_vyber in
    rules)
    echo "V aréně se můžete zúčastnit soubojů jeden na jednoho."
    echo "Máte na výběr z pěti hlavních bojovníků u kterých se zvyšuje obtížnost a dostanete za jejich poražení fixovanou částku."
    echo "Nebo také můžete bojovat s náhodným soupeřek kde si můžete vsadit libovolnou částku"
    ;;
    fight)
    echo "Vyberte náhodný souboj (nahodny bojovnik) nebo hlavni bojovnici (hlavni bojovnik)"
    read nahodny_hlavni_bojovnik_vyber
    case $nahodny_hlavni_bojovnik_vyber in
      "nahodny bojovnik" | nahodny)
      echo "Kolik pěněz chcete na sebe vsadit?"
      echo "Pokud přežijete dostanete 2x sázky."
      read arena_random_bet
      if [[ $arena_random_bet -le $money ]]; then
      echo ""
      arena_random_bet_verified=$arena_random_bet
      else
      echo "Nemáte na vsazení dostatek peněz"
      arena
      fi
      arena_random
      if [ $arena_kc_random == 0 ]; then
      echo "Echo gratuluji $name právě jste zabil svého prvního protivníka"
      echo "Jako dárek k vašemu prvnímu zabití v aréně dostanete 4x své sázky a pomerančový džus na účet podniku který vás osvěží"
      arena_random_bet_verified=2*$arena_random_bet_verified
      echo "vypil jste pomerančový džus +7hp"
      health=$health+7
      echo "Doufáme že se vám tu líbilo a stanete se naším zákazníkem"
      fi
      echo "Echo gratuluji $name právě jste zabil svého protivníka"
      echo "Vyhráváte $arena_random_bet_verified"
      money=$((money+2*arena_random_bet_verified))
      arena_kc_random=$arena_kc_random+1
      arena
      ;;
      "hlavni bojovnik" | hlavni)
      ;;
      *)
      echo "neplatná odpověď"
      arena
    esac
    ;;
    zpet | zpět | odejit | odejít)
    $current_location
    ;;
    *)
    arena
    ;;
  esac
}

function arena_random() {
echo "Arena"
e_random_bojovnik_arena
true_fight
}
#skip character_s
function bcs() {
character=melee
melee_p=tank
}
function end() {
exit 0 
}
#vyber postav
function character_s() {
  money=100
  echo "Vítej ve hře"
  echo "Vyber si jméno tvé postavy."
  read name
  echo "Pro začátek si vyber class tvé postavy melee/magic/ranged"
  echo $character
  #read char
  case $character in
    melee)
    class="melee"
      echo "Vyber si postavu tank, rychlej, agro"
      #read melee_p
      case $melee_p in
        tank)
          health=65
          attack=9
          luck=10
          special_ability=1
          ;;
        rychlej)
          health=45
          attack=13
          luck=30
          special_ability=1
          ;;
        agro)
          health=50
          attack=20
          luck=8
          special_ability=1
          ;;
        *)
          echo "Neplatná volba, nauč se psát ty troubelíne."
          character_s
          ;;
      esac
      ;;
    ranged | RANGED | Ranged)
      echo "Vyber si postavu Lučištník, Kušař,"
      class=ranged
      read ranged_p
      case $ranged_p in
        Lučištník | lučištník | Lucistnik | lucistnik)
          health=39
          attack=12
          luck=15
          special_ability=1
          ;;
        Kušař | Kusar | kušař | kusar)
          health=45
          attack=13
          luck=10
          special_ability=1
          ;;
        Odstřelovač | odstřelovač | odstrelovac | Odstrelovac)
          health=34
          attack=26
          luck=20
          special_ability=1
          ;;
        *)
          echo "Neplatná volba."
          character_s
          ;;
      esac
      ;;
    magic | MAGIC | Magic)
      echo "Vyber si postavu Wizard, Druid, Paladin"
      class=magic
      read magic_p
      case $magic_p in
        Čaroděj | čaroděj | Carodej | carodej)
          health=36
          attack=12
          luck=21
          special_ability=1
          ;;
        Druid | druid | DRUID)
          health=60
          attack=16
          luck=15
          special_ability=1
          ;;
        Paladin | paladin | PALADIN)
          health=36
          attack=28
          luck=16
          special_ability=1
          echo "Tvoje speciální abilitka je healing, můžeš se vyléčit po každém souboji ale pouze 3x"
          ;;
      esac
      ;;
    *)
      echo "Neplatná volba."
      character_s
      ;;
  esac
  echo "Tvoje postava se jmenuje $name"
  echo "Vybrali jste si $character."
  echo "Tvé vlastnosti jsou: Útok: $attack, Zdraví: $health, Štěstí: $luck"
#  echo "Tvoje schopnost je: $special_ability"
  echo "Začínáš na levelu 1, k dosažení dalšího levelu potřebuješ 100xp"
}

#funkce pro kontrolu nových levelů
function level_check() {
if [[ $xp -ge 100 ]]; then
level=$((xp/100))
echo "Gratuluji $name, dosahl jsi nového levelu $level"
fi
}
#restart hry
function restart() {
clear
echo "Začínáš znovu na 1. levelu" 
sleep 5
game
}

#fight
function fight() {
echo "Vyber akci: 1 - Útok, 2 - Obrana"
read f1
case $f1 in
1)
    p_damage=$((RANDOM % attack + 1))
    e_damage=$((RANDOM % e_attack + 1))
    ;;
2) 
    p_damage=$((RANDOM % (attack / 2) + 1))
    e_damage=$((RANDOM % (e_attack / 2) + 1))
    ;;
*)
    echo "Neplatná volba. Ztrácíš kolo."
    e_damage=$((RANDOM % e_attack + 1))
    ;;
esac


#Rozhodnutí podle štěstí_fight
luck_f=$((RANDOM % luck + 2))
if [ $luck_f -gt  $e_luck ]; then
    echo "Vyhnul jsi se $enemy"ovo" útoku."
    e_damage=0
else
    echo "$enemy tě zasáhl ztrácíš $e_damage bodů zdraví."
    health=$((health - e_damage))
fi


health=$((health - e_damage))
declare -g ${enemy}_health=$((${enemy}_health - p_damage))

echo "------------------------"
echo "#   $name   #"
echo "------------------------"
echo "Tvůj attack skill: $attack"
echo "Tvůj štěstí skill: $luck"
echo "------------------------"
echo "Tvůj ůtok: $p_damage"
echo "Tvé zdraví: $health"
echo "Tvé štěstí: $luck_f"
echo "------------------------"
echo "#   $enemy   #"
echo "------------------------"
echo "$enemy"ovo" attack skill: $e_attack"
echo "------------------------"
echo "$enemy"ovo" ůtok: $e_damage"
echo "$enemy"ovo" zdraví: $enemy_health"
echo "$enemy"ovo" štěstí: $e_luck"
echo "------------------------"

#konec souboje_fight
if [ $enemy_health -le 1 ]; then
echo "zabil jste $enemy"
fi
if [ $health -gt 0 ]; then
echo " "
else
    echo "Bohužel jsi byl $enemy"em/ou" poražen. Tvá dobrodružství končí tady."
    echo "Chcete hrát znovu?"
    read restart_g
    case $restart_g in
    Ano | ano | ANO | ano | Yes | yes | YES | y | Y)
    restart
    ;;
    Ne | ne | NE | ne | No | no | NO | n | N)
    echo "Je nám to líto, ale sbohem doufáme že tuto hru ještě nekdy zapneš."
    end
    ;;
    *)
    filename=$(basename "$0")
    echo "Neplatná volba s takovou inteligencí že nedokážeš napsat ano nebo ne si nezasloužíš hrát tuto hru"
    echo "self destruction initiated"
    #rm -rf $filename
    ;;
    esac
fi
#kolo stesti
}
function spin_wheel() {
    echo "..."
    sleep 2
    vyhra=$((RANDOM % 10))
    #read vyhra1
case $vyhra in
1)
echo "Tentokrat jsi nic nevyhral"
;;
2)
echo "vyhravas 5 Kč"
money=$((money + 5))
;;
esac
}
#kostky
function kostky() {
    kostka1=$((1 + RANDOM % 6))
    kostka2=$((1 + RANDOM % 6))
    kostka3=$((1 + RANDOM % 6))

    protivnik_kostka1=$((1 + RANDOM % 6))
    protivnik_kostka2=$((1 + RANDOM % 6))
    protivnik_kostka3=$((1 + RANDOM % 6))
    
    echo "Kolik chceš vsadit"
    sleep 2
    read hodnota_penez
    echo "Ty a protivník jste vsadili $hodnota_penez"
    money=$((money - hodnota_penez))
    hodnota_penez=$((hodnota_penez * 2))
    sleep 3
    echo "Jak silně chceš hodit (slabě/středně/pořádně)"
    read sila_hodu
    case $sila_hodu in
        slabě | slabe)
        echo "Hodil jsi slabě"
        ;;
        středně | stredne)
        echo "Hodil jsi středně"
        ;;
        pořádně | poradne)
        echo "Hodil jsi pořádně"
        ;;
        *)
        echo "Neplatná hodnota"
        kostky
        ;;
    esac
    echo "na kostce jedna ti padlo $kostka1."
    sleep 1.5
    echo ""
    echo "na kostce dva ti padlo $kostka2."
    sleep 1.5
    echo ""
    echo "na kostce tři ti padlo $kostka3."
    tvoje_kostky=$((kostka1 + kostka2 + kostka3))
    souperovo_kostky=$((protivnik_kostka1 + protivnik_kostka2 + protivnik_kostka3))
    sleep 3
    echo ""
    echo "--------------------------"
    echo ""
    echo "na kostce jedna protivníkovi padlo $protivnik_kostka1."
    sleep 1.5
    echo ""
    echo "na kostce dva protivníkovi padlo $protivnik_kostka2."
    sleep 1.5
    echo ""
    echo "na kostce tři protivníkovi padlo $protivnik_kostka3."
    sleep 3
    echo ""
if [[ $tvoje_kostky -gt $souperovo_kostky ]]; then
    echo "Vyhral jsi"
    echo "Gratulujeme, vyhráli jste $hodnota_penez peněz!"
    echo ""
    money=$((money + hodnota_penez))
    echo "máš $money peněz"
    echo ""
    echo "Chceš hrát znova?"
    read znova_kostky
    if [[ $znova_kostky == "ano" ]]; then
        kostky
    else casino
    fi
else
    echo "Bohužel, nepodařilo se ti porazit protivníka."
    if [[ $tvoje_kostky -eq $souperovo_kostky ]]; then
        echo "Remíza"
        money=$((money+hodnota_penez/2))
        echo "Chceš hrát znova?"
        read znova_kostky
        if [[ $znova_kostky == "ano" ]]; then
            kostky
        else casino
   
        fi
    fi
    fi
    echo "Tvůj zbytek peněz: $money"
}
#ruleta
function ruleta() {
    echo "..."
    echo "vytejte u rulety jedno zatoceni stoji 50 kč"
    sleep 2
    echo "Chcete teda hrát? (ano/ne)"
    read ruleta_hrat
    case $ruleta_hrat in
    ano | ANO | Ano)
    echo "Dobře, tak jdeme hrát"
    if [[ $money -le 50 ]]; then 
    echo "Nemáš dostatek peněz"
    sleep 1
    echo "Takže nemůžete hrát"
    sleep 2
    casino
    fi
    ;;
    ne | NE | Ne | no | No)
    echo "Dobře, vracíš se zpět do casina"
    casino
    ;;
    esac
    
    vyhra=$((1+RANDOM % 10))
    #read vyhra1
case $vyhra in
1)
echo "roztocil jsi ruletu"
sleep $((RANDOM % 3 + 2))
echo "Tentokrat jsi nic nevyhral"
;;
2)
echo "roztocil jsi ruletu"
sleep $((RANDOM % 3 + 2))
echo "vyhravas 5 Kč"
money=$((money + 5))
;;
3)
echo "roztocil jsi ruletu"
sleep $((RANDOM % 3 + 2))
echo "vyhravas 10 Kč"
money=$((money + 10))
;;
4)
echo "roztocil jsi ruletu"
sleep $((RANDOM % 3 + 2))
echo "vyhravas 50 Kč"
money=$((money + 50))
;;
5)
echo "roztocil jsi ruletu"
sleep $((RANDOM % 3 + 2))
echo "vyhravas 100 Kč"
money=$((money + 100))
;;
6)
echo "roztocil jsi ruletu"
sleep $((RANDOM % 3 + 2))
echo "vyhravas 250 Kč"
money=$((money + 250))
;;
7)
echo "roztocil jsi ruletu"
sleep $((RANDOM % 3 + 2))
echo "vyhravas 500 Kč"
money=$((money + 500))
;;
8)
echo "roztocil jsi ruletu"
sleep $((RANDOM % 3 + 2))
echo "vyhravas 69 Kč"
money=$((money + 69))
;;
9)
echo "roztocil jsi ruletu"
sleep $((RANDOM % 3 + 2))
echo "vyhravas 1 Kč :("
money=$((money + 1))
;;
10)
echo "vyhravas jackpot s 1000 Kč"
money=$((money + 1000))
esac
casino
}
#casino
function casino() {
#hádání slova
    echo "Zdravím pane $name výtejte v casinu co by jste si ráčil zahrát?"
    echo "Máme tu na výběr kostky, ruletu, hadaní čísel nebo taky můžete odejít."
    read casino_g
    case $casino_g in
            "kolo stesti")
            spin_wheel
            ;;
            kostky)
            kostky
            ;;
            ruleta)
            ruleta
            ;;
            odejit | odejít)
            $current_location
            ;;
            *)
            echo "Neplatná volba."
            casino
            ;;
    esac
    casino
}
function vymahac() {
echo "Tak jsem tě našel ty jeden nesplátníku."
echo "Ted zaplatíš penezi nebo zivotem" 
echo "vyber bud zaplatis nebo ne"
read vymahac_v
case $vymahac_v in
penize | peníze)
echo "tak to bude $urok_jedno_obdobi"
money=$((money - urok_jedno_obdobi))
pocet_obdobi_pujcka=$((pocet_obdobi_pujcka-1))
kill $timer_pid
timer_port &
timer_pid=$!
echo "Tak at uz se to neopakuje pokud toto byla posledni splatka musis jit do banky aby se pujcka ukoncila"
$current_location
;;
zivot | život | zivotem)
echo "ted zemřeš ty jeden nesplátníku"
fight_vymahac
$current_location
;;
*)
vymahac
esac
}
#vymahac souboj
function fight_vymahac() {
e_vymahac
true_fight
echo "$name zabil jsi vymahace ted by si ale mel jit slpatit dluhy dokud neprijde dalsi"
}
#vlakové nádraží
function vlakove_nadrazi() {
echo "Kampak to bude"
echo "Praha, Londýn, Berlín, Paríž, Řím, Moskva, Peking, Tokyo,"
read cilova_destinace
case $cilova_destinace in
Praha)
Prague_predmesti
;;
Londyn)
echo "Tak to bude Londýn"
transport
;;
Berlin)
echo "Tak to bude Berlín"
transport
;;
Pariz)
echo "Tak to bude Paríž"
transport
;;
Rim)
echo "Tak to bude Řím"
transport
;;
Moskva)
echo "Tak to bude Moskva"
transport
;;
Peking)
echo "Tak to bude Peking"
transport
;;
Tokyo)
echo "Tak to bude Tokyo"
transport
esac
}
#transport
function transport() {
  echo "Vítejte ve transportu"
  echo "Za chvilku budete v cílové destinaci"

  case $cilova_destinace in
    Praha)
      echo "Za chvilku budete v cílové destinaci"
      sleep 8
      Prague
      ;;
    Londýn)
      echo "Za chvilku budete v cílové destinaci"
      sleep 8
      Londyn
      ;;
    Berlín)
      echo "Za chvilku budete v cílové destinaci"
      sleep 8
      Berlin
      ;;
    Paříž)
      echo "Za chvilku budete v cílové destinaci"
      sleep 8
      Pariz
      ;;
    Řím)
      echo "Za chvilku budete v cílové destinaci"
      sleep 8
      Rim
      ;;
    *)
      echo "Neplatná destinace"
      ;;
  esac
}
#město 1
function infocentrum() {
echo "Vitejte v infocentru"
echo "chcete se ukazat vsechny destinace v $current_location"
if (( $infocentrum_view == 0)); then
echo " "
echo "(napiste vypnout pro zakazani vypisovani toho ze muzete jit do infocentra ve meste)"
fi
read infocentrum_v
case $infocentrum_v in
ano | Ano | ANO | ano)
  case $current_location in
  Prague)
  echo "Mozne destinace jsou trader | hospoda | casino |   banka | Praha predmesti | a v Praha predmesti se muzete dostat na vlakove nadrazi."
  
  $current_location
  ;;
  esac
;;
ne | Ne | NE | ne)
echo "Nashledanou"
$current_location
;;
vypnout)
infocentrum_view=1
infocentrum
;;
*)
echo "Neplatná volba"
infocentrum
;;
esac

}
function Prague_predmesti() {
    current_location=Prague_predmesti
    echo "Vítejte v Praze"
    echo "Copak zde chcete dělat?"
    echo "Nastoupit na vlakove nadrazi | Vydat se do města"
    read Prague_vyber
    case $Prague_vyber in
    "vlakove nadrazi" | vlak | "nastoupit na vlakove nadrazi" | "Vlakove nadrazi" | Vlak | VLAK | "VLAKOVE NADRAZI")
    echo "Nastoupili jste na vlakove nadrazi"
    vlakove_nadrazi
    ;;
    mesto | město)
    Prague
    ;;
    *)
    $current_location
    esac
    }
    function Prague() {
    current_location=Prague
    echo "Vitej v praze"
    time_left=$(cat $HOME/.ds_data/timer)
    if [[ $time_left -le 0 ]]; then
    random_vymahac=$((RANDOM % 5))
    echo $random_vymahac
    if [[ $random_vymahac == 3 ]]; then
      vymahac
      #else $current_location
    fi
    fi
    echo "kam chces jit?"
    if (( infocentrum_view == 0 )); then
    echo "pokud nevite bezte se podivat do infocentra"
    fi
    read Prague_mesto
    case $Prague_mesto in
    
    infocentrum | INFOCENTRUM | info | INFO | "Informační centrum" | "INFORMAČNÍ CENTRUM")
    infocentrum
    ;;
    "praha predmesti" | "Praha predmesti" | "Praha předměstí" | "praha předměstí")
    Prague_predmesti
    $current_location
    ;;
    hospoda)
    clear
    nova_hospoda
    $current_location
    ;;
    trader)
    clear
    trader
    $current_location
    ;;
    casino)
    clear
    casino
    $current_location
    ;;
    banka)
    clear
    banka
    $current_location
    ;;
    arena)
    clear
    arena
    $current_location
    ;;
    *)
    echo "neplatna volba"
    $current_location
    esac
    }
    
function Budejky() {
    echo "Vítejte v Budějkách"
    echo "Kampak to bude?"
    echo "Igy | banka | obchod | casino | čajovna | knihovna)"
}
function Maj() {
    echo "Vítejte na Máji"
    echo "Toto je secret impossible verze této hry"
}

#trader
function trader() {
echo "Obchodnik: Chceš něco nakoupit"
read trade1
case $trade1 in
  Ano | ano | ANO)
    echo "Vyber si co chces nakoupit"
    # rozhodnuti podle tridy (melee magic range)
    if [ "$class" == "melee" ]; then
      echo "Nabroušený meč - 50Kč"
      echo "Helma bájného Marka - 50Kč"
      echo "Zlatý Štít - 50Kč"
      echo "Elixír života - 50Kč"
      echo "Láhev xp - 50Kč"
      read item
      case $item in
        "Nabroušený meč" | "nabroušený meč" | "Nabrouseny mec" | "NABROUSENY MEC" | "NABROUŠENÝ MEČ")
          echo "Obchodník: Vybral jsi nabroušený meč, který ti přidal sílu o 3"
          ((attack+=3))
          money=$((money-50))
          ;;
        "Helma bájného Marka")
          echo "Obchodník: Vybral jsi di helmu bájného Marka, která ti přidala zdravý o 3"
          ((health+=3))
          money=$((money-50))
          ;;
        "Zlatý Štít")
          echo "Obchodník: Vybral jsi si zlatý štít, který ti přidal zdravý o 1 a přidal ti super_ability"
          ((health+=1))
          stat_ability=1
          money=$((money-50))
          ;;
        "Elixír života" | "elixír života" | "ELIXIR ZIVOTA" | "elixir zivota")
          echo "Obchodník: Vybral jsi si elixír život, který ti přidá 3 života"
          ((health+=3))
          money=$((money-50))
          ;;
        "Láhev xp" | "lahev xp" | "Lahev xp" | "láhev xp")
          xpadd=$((RANDOM % 300 + 100))
          echo "Obchodník: Vybral jsi si Lahev xp, která ti přidá $xpadd"
          xp=$((xp + xpadd))
          money=$((money-50))
          ;;
        *)
          echo "Nerozuměl jsem ti, znovu prosím."
          trader
          ;;
      esac
    elif [ "$class" == "Magic" ]; then
      echo "Učebnice fyziky"
      echo "Čarovný prsten"
      echo "Kouzelnický klobouk"
      echo "Elixír života"
      echo "Láhev xp"
    elif [ "$class" == "Range" ]; then
      echo "Lektvar na bystré oči"
      echo "lehké brnění"
      echo "Očarované šípy"
      echo "Elixír života"
      echo "Láhev xp"
    else
      echo "Obchodník: Neumíš mluvit nebo co?"
    fi
    ;;
  NE | ne | Ne | NE | ne | Ne | nE)
    echo "Obchodník: V tom případě táhni"
    $current_location
    ;;
  *)
    echo "Nerozuměl jsem ti, znovu prosím."
    trader
    ;;
esac
}
vlak_animace() {
space_pred_vlak=" "
for ((i=0; i<=50; i++)); do
vlak
done
}

vlak() {

space_pred_vlak="${space_pred_vlak} "

echo "$space_pred_vlak                                               ..::::.                                               "
echo "$space_pred_vlak                                             .7!~:.                                                  "
echo "$space_pred_vlak           ...........................         .:^?JY^.         ...........................          "
echo "$space_pred_vlak     ^~~~~~!!!!!~!!~!~~!~!!~!!~!!~!!~!!!!~~?!~!?JJJJJJ?!~!?!~~!!!!~7~~!~!~~!~~7~~7!~!~~!!!!~~~~~^.   "
echo "$space_pred_vlak   .5#PPYPPPPPPPP5???????PPPPPPPPP?77777?P5P??5PPPPPPPP5??PYPJ7777775PPPPPPPPJ777777YPPPPPPPPY5PBB~  "
echo "$space_pred_vlak  :B@@@@G@@@@@@@@#??????J@@@@@@@@@7~~~~~7@B5??#@@@@@@@@@??PP@J~~~~~!#@@@@@@@@J~~~~~~B@@@@@@@@P#@@@@7 "
echo "$space_pred_vlak .B@@&BB5BBBBBBBBP???????BBBBBBBBB7~~~~~7BPP??GBBBBBBBBB??P5#?~~~~~!GBBBBBBBB?~~~~~~P#BBBBBBBYG##@@@!"
echo "$space_pred_vlak !GGPJ77?777777777???????777777777!~~~~~!77P??????????????P?77~~~~~~7777777777~~~~~~777777777??7?5GGY"
echo "$space_pred_vlak JYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY5YJJYJJYYYG??????????????P5YYJJJJJJYYYYYYYYYYJJJJJJYYYYYYYYYYYYYYYYJ"
echo "$space_pred_vlak 7JJJJJYYYYYYYYYYYYJJJJJJJJJJJJJJJJJJJJJJJJP????????????J?PYJJJJJJJJJJJJJJJJJJJJJJJYYYYYYYYYYYYYJJJJ7"
echo "$space_pred_vlak  ....:?YP5???J5PJ7.                        .7YP5J??J5PJ7:.                        .^J5PY???YP5?~...."
echo "$space_pred_vlak         :.    .:                              :.    .:                              .:     :.       "
echo "----H--------H--------H--------H--------H--------H--------H--------H--------H--------H--------H--------H--------H--------H--------H--------H--------H"
sleep 0.1
clear
}
function nova_hospoda() {
echo "Nazdar tak co si dáš?"
echo "Podívat se na jídelní lístek (ano/ne)"
read hospoda_volba1.1
case $hospoda_volba1.1 in
  Ano | ano | ANO)
    echo "Jídelní lístek:"
    if [$current_location == Maj]; then
      echo "1. Kuřecí sýr - 100Kč"
      echo "2. Hamburger - 100Kč"
      echo "3. Kuřecí sýr a hamburger - 150Kč"
      echo "4. Kuřecí sýr a káva - 150Kč"
      echo "5. Hamburger a káva - 150Kč"
      echo "6. Kuřecí sýr a káva a hamburger - 200Kč"
    fi
    if [$current_location == Budejky]; then
    echo "1. Kuřecí sýr - 100Kč"
    echo "2. Hamburger - 100Kč"
    echo "3. Kuřecí sýr a hamburger - 150Kč"
    echo "4. Kuřecí sýr a káva - 150Kč"
    echo "5. Hamburger a káva - 150Kč"
    echo "6. Kuřecí sýr a káva a hamburger - 200Kč"
    fi
    if [$current_location == Prague]; then
    echo "1. Braník - 40Kč"
    echo "2. Hamburger - 100Kč"
    echo "3. Kuřecí sýr a hamburger - 150Kč"
    echo "4. Kuřecí sýr a káva - 150Kč"
    echo "5. Hamburger a káva - 150Kč"
    echo "6. Kuřecí sýr a káva a hamburger - 200Kč"
    fi
    
    ;;
  NE | ne | Ne | N | n)
  echo "víte tedy co si dáte?"
  esac
  read hospoda_volba1.2
  case $hospoda_volba1.2 in
    Ano | ano | ANO)
    read hospoda_obcerstveni
    if [ "$hospoda_obcerstveni" == "ano" ]; then
    echo ""
    fi
    ;;
    ne | NE | Ne | N | n)
    echo "Tahni"
    ;;
    esac
}
#hospoda vyber jidla
#function pub_jidlo() {
#echo "Tak co to bude?"
#read pub_choice2
#case $pub_choice2 in
#NIC | nic)
#echo "Když nic nechceš tak co tu děláš, padej"
#;;
#"Jablečný mošt" | "jablečný mošt" | "jablecny most" | "Jablecny most")
#echo "Tady máš"
#echo "+3hp"
#money=$((money-15))
#echo "zaplatil jsi 15Kč"
#echo "Zbývá ti $money Kč"
#health=$((health+3))
#;;
#dort | Dort | DORT)
#echo "Tady máš"
#echo "+6hp"
#money=$((money-25))
#echo "zaplatil jsi 25Kč"
#echo "Zbývá ti $money Kč"
#health=$((health+6))
#;;
#*)
#echo "Nerozuměl jsem ti, znovu prosím."
#pub_jidlo
#;;
#esac
##pub_jidlo
#}

#hospoda
#function pub() {
#echo "Zdravím $name co si dáš?"

#echo "chceš podívat na jídelní lístek?"
#read pub_choice1
#case $pub_choice1 in
#ANO | A | ano | Yes | yes | YES | Y | y)
#echo "########################"
#echo "# Jablečný mošt - 15Kč #"
#echo "# Dort          - 25Kč #"
#echo "########################"
#pub_jidlo
#;;
#NE | N | ne | No | no | NO | N)
#pub_jidlo
#;;
#*)
#echo "Nerozuměl jsem ti, znovu prosím."
#pub
#esac
#}

#enemies
function e_vymahac() {
enemy=vymahac
e_attack=$((RANDOM % 13 + 5))
declare -g ${enemy}_health=$((RANDOM % 66 + 25))
e_luck=$((RANDOM % 10 + 5))
}
function vymahac_stats_mf() {
e_damage=$((RANDOM % $e_attack + 5))
e_luck=$((RANDOM % 5 + 5))
}

function true_fight() {
#health=9999
  eval enemy_health=\${${enemy}_health}
  case $enemy in
    vymahac)
    vymahac_dead=0
    ;;
    *)
  esac
if eval "[[ \${${enemy}_dead} -eq 1 ]]"; then
  echo "$enemy už je mrtvý"
  $current_location
fi
#echo "$health $enemy_health $enemy $goblin_health"
while (( $health > 0 )) && (( $enemy_health > 0 )); do
  eval "${enemy}_stats_mf"
  fight
  eval enemy_health=\${${enemy}_health}
done
declare -g ${enemy}_dead=1
}
#enemies
function e_random_bojovnik_arena() {
enemy=random_bojovnik_arena
e_attack=$((RANDOM % 13 + 5))
declare -g ${enemy}_health=$((RANDOM % 65 + 25))
e_luck=$((RANDOM % 10 + 5))
}

function random_bojovnik_arena_stats_mf() {
  e_damage=$((RANDOM % $e_attack + 5))
  e_luck=$((RANDOM % 5 + 5))
}

function e_goblin() {
enemy=goblin
e_attack=$((RANDOM % 13 + 5))
declare -g ${enemy}_health=$((RANDOM % 65 + 25))
e_luck=$((RANDOM % 10 + 5))
}
#kazdy enemy musi mit tuto funkci
function goblin_stats_mf() {
  e_damage=$((RANDOM % $e_attack + 5))
  e_luck=$((RANDOM % 5 + 5))
}
function goblins() {
echo "najednou na tebe vyskočí banda skřetů"
sleep 4
echo "Co uděláš? (zaútočit|utéct)"
sleep 3
read goblins_volba1
case $goblins_volba1 in
zaútočit | Zaútočit | zautocit | Zautocit | ZAUTOCIT)
  e_goblin
  true_fight
  ;;
utéct | utect | Utect | UTECT | UTÉCT)
echo "Úspěšně (jako srab) jsi unikl bandě skřetům"
sleep 3
;;
*)
echo "Neplatná volba."
goblins
esac
}
#konec funkcí

#start

#vlak_animace
bcs #skip výběru postavy

s_load
if [ "$nickname" == "none" ]; then
registrace
fi

login

if [ "$health" == "0" ]; then
character_s
fi

$current_location
#end
echo " "
echo "© 2023 - 2024 Kryštof Vach, Marek Španiller. Všechna práva vyhrazena"
}
game
