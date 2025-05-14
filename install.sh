#!/bin/bash

# Warna
biru='\033[1;34m'
reset='\033[0m'

# Banner
clear
echo -e "${biru}"
figlet KikiXploit | lolcat
echo -e "${biru}Termux Auto Setup by KikiXploit${reset}"
sleep 2

# Update & install dependensi dasar
pkg update -y && pkg upgrade -y
pkg install git zsh curl wget nano neofetch toilet figlet ruby -y
gem install lolcat

# Install Zsh & Powerlevel10k
pkg install zsh -y
chsh -s zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k

# Salin .zshrc
cat <<EOF > ~/.zshrc
export ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.p10k.zsh
autoload -Uz compinit && compinit
alias update='pkg update && pkg upgrade'
alias cls='clear'
alias menu='bash ~/kikixploit/menu.sh'
EOF

# Default powerlevel10k config
cat <<EOF > ~/.p10k.zsh
# Contoh konfigurasi sederhana powerlevel10k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator time)
EOF

# Menu GUI
mkdir -p ~/kikixploit
cat <<EOF > ~/kikixploit/menu.sh
#!/bin/bash
while true; do
  pilihan=\$(dialog --clear --stdout --title "KikiXploit Menu" \
  --menu "Pilih tool yang ingin kamu jalankan:" 15 50 6 \
  1 "Nmap" \
  2 "Metasploit" \
  3 "Sqlmap" \
  4 "HTTP Server" \
  5 "Neofetch" \
  0 "Keluar")

  case \$pilihan in
    1) pkg install nmap -y && nmap ;;
    2) pkg install unstable-repo -y && pkg install metasploit -y && msfconsole ;;
    3) git clone https://github.com/sqlmapproject/sqlmap && cd sqlmap && python sqlmap.py ;;
    4) echo -e "\nJalankan: python3 -m http.server 8080\n" && sleep 3 ;;
    5) neofetch ;;
    0) clear; exit ;;
  esac
done
EOF

chmod +x ~/kikixploit/menu.sh

echo -e "\n${biru}Install selesai! Restart Termux, lalu ketik: menu${reset}"
