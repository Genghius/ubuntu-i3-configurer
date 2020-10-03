yikes="not installed, proceeding to install..."
echo "Checking that all required packages are installed..."
rofi -v 2> /dev/null 1> /dev/null || echo "rofi $yikes"&& sudo apt install -y rofi
awk -V 2> /dev/null 1> /dev/null || echo "awk $yikes" && sudo apt install -y mawk
feh -v 2> /dev/null 1> /dev/null || echo "feh $yikes" && sudo apt install -y feh
sensors -v 2> /dev/null 1> /dev/null || echo "sensors $yikes" && sudo apt install -y lm-sensors
scrot -v 2> /dev/null 1> /dev/null || echo "scrot $yikes" && sudo apt install -y scrot
dmenu -v 2> /dev/null 1> /dev/null || echo "dmenu $yikes" && sudo apt install -y dmenu
i3blocks -V 2> /dev/null 1> /dev/null || echo "i3blocks $yikes" && sudo apt install -y i3blocks
pulseaudio --version 2> /dev/null 1> /dev/null || echo "pulseaudio $yikes" && sudo apt install -y pulseaudio

echo "checking i3 or i3-gaps is installed..."
i3 -v 2> /dev/null 1> /dev/null || echo "i3-gaps $yikes" && sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake libxcb-xrm-dev && git clone https://www.github.com/Airblader/i3 i3-gaps && cd i3-gaps && git checkout gaps && git pull && autoreconf --force --install && rm -rf build && mkdir build && cd build && ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers && make && sudo make install

user=$(who | awk '{print $1}')
echo "proceeding to create directories, copy and overwrite dotfiles"
ls /usr/share/i3blocks/ 2> /dev/null 1> /dev/null || sudo mkdir /usr/share/i3blocks
ls /home/$user/.config/i3 2> /dev/null 1> /dev/null || mkdir /home/$user/.config/i3
ls /home/$user/.config/rofi 2> /dev/null 1> /dev/null || mkdir /home/$user/.config/rofi
sudo cp -r $PWD/dotfiles/blocks/* /usr/share/i3blocks
sudo cp -r $PWD/dotfiles/i3blocks.conf /etc
cp -r $PWD/dotfiles/config /home/$user/.config/i3
cp -r $PWD/misc/HK.jpg /home/$user/.config/i3
cp -r $PWD/dotfiles/config.rasi /home/$user/.config/rofi

echo "done, proceeding to delete script and related garbage."
trap "rm -rf $PWD" EXIT
