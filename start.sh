yikes="not installed, proceeding to install..."
echo "Checking that all required packages are installed..."
rofi -v 2> /dev/null 1> /dev/null || echo "rofi $yikes"&& sudo apt install -y rofi
awk -V 2> /dev/null 1> /dev/null || echo "awk $yikes" && sudo apt install -y mawk
feh -v 2> /dev/null 1> /dev/null || echo "feh $yikes" && sudo apt install -y feh
scrot -v 2> /dev/null 1> /dev/null || echo "scrot $yikes" && sudo apt install -y scrot
dmenu -v 2> /dev/null 1> /dev/null || echo "dmenu $yikes" && sudo apt install -y dmenu
i3blocks -V 2> /dev/null 1> /dev/null || echo "i3blocks $yikes" && sudo apt install -y i3blocks
pulseaudio --version 2> /dev/null 1> /dev/null || echo "pulseaudio $yikes" && sudo apt install -y pulseaudio

echo "proceeding to create directories, copy and overwrite dotfiles"
ls /usr/share/i3blocks/ 2> /dev/null 1> /dev/null || sudo mkdir /usr/share/i3blocks
ls /home/*/.config/i3 2> /dev/null 1> /dev/null || mkdir /home/*/.config/i3
ls /home/*/.config/rofi 2> /dev/null 1> /dev/null || mkdir /home/*/.config/rofi
sudo cp -r $PWD/dotfiles/blocks/* /usr/share/i3blocks
sudo cp -r $PWD/dotfiles/i3blocks.conf
cp -r $PWD/dotfiles/config /home/*/.config/i3
cp -r $PWD/misc/HK.jpeg /home/*/.config/i3
cp -r $PWD/dotfiles/config.rasi /home/*/.config/rofi

echo "done, proceeding to delete script and related garbage."
trap "rm -rf $PWD" EXIT
