# Check if command is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please start the script as root with: sudo ./start.sh"
  exit
fi

# Variable for commands below
yikes="is not installed, proceeding to install..."

# Check required packages and install them if necessary
echo "Checking that all required packages are installed..."
rofi -v 2> /dev/null 1> /dev/null || (echo "rofi $yikes" && sudo apt install -y rofi 1> /dev/null 2> /dev/null )
awk -V 2> /dev/null 1> /dev/null || (echo "awk $yikes" && sudo apt install -y mawk 1> /dev/null 2> /dev/null )
feh -v 2> /dev/null 1> /dev/null || (echo "feh $yikes" && sudo apt install -y feh 1> /dev/null 2> /dev/null )
sensors -v 2> /dev/null 1> /dev/null || (echo "sensors $yikes" && sudo apt install -y lm-sensors 1> /dev/null 2> /dev/null )
mpstat -V 2> /dev/null 1> /dev/null || (echo "mpstat $yikes" && sudo apt install -y sysstat 1> /dev/null 2> /dev/null )
scrot -v 2> /dev/null 1> /dev/null || (echo "scrot $yikes" && sudo apt install -y scrot 1> /dev/null 2> /dev/null )
dmenu -v 2> /dev/null 1> /dev/null || (echo "dmenu $yikes" && sudo apt install -y dmenu 1> /dev/null 2> /dev/null )
i3blocks -V 2> /dev/null 1> /dev/null || (echo "i3blocks $yikes" && sudo apt install -y i3blocks 1> /dev/null 2> /dev/null )
pulseaudio --version 2> /dev/null 1> /dev/null || (echo "pulseaudio $yikes" && sudo apt install -y pulseaudio 1> /dev/null 2> /dev/null )
dunst -v 2> /dev/null 1> /dev/null || (echo "dunst $yikes" && sudo apt install -y dunst 1> /dev/null 2> /dev/null )

# At this point why havent i called it debian i3 configurer? lolkek
ps -e | grep X 2> /dev/null 1> /dev/null || X -v 2> /dev/null 1> /dev/null || (echo "Xorg $yikes" && sudo apt install -y xorg 1> /dev/null 2> /dev/null && echo "exec i3" >> /home/$user/.xinitrc)

# More checking
echo "checking i3 or i3-gaps is installed..."
i3 -v 2> /dev/null 1> /dev/null || (echo "i3-gaps $yikes" && sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake libxcb-xrm-dev 1> /dev/null && git clone https://www.github.com/Airblader/i3 i3-gaps && cd i3-gaps && git checkout gaps && git pull && autoreconf --force --install && rm -rf build && mkdir build && cd build && ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers && make && sudo make install && cd ..)

# Finds the user and store in a variable
# Can alternatively use $(who -m | awk 'RN==1 {print $1})'
user=$(logname)

# Copy dotfiles
# Create directories
echo "Creating directories to copy and overwrite dotfiles if do not exist"
ls /home/$user/.config/i3blocks 2> /dev/null 1> /dev/null || mkdir -p /home/$user/.config/i3blocks
ls /home/$user/.config/i3 2> /dev/null 1> /dev/null || mkdir -p /home/$user/.config/i3
ls /home/$user/.config/rofi 2> /dev/null 1> /dev/null || mkdir -p /home/$user/.config/rofi
ls /home/$user/.config/dunst 2> /dev/null 1> /dev/null || mkdir -p /home/$user/.config/dunst

# Really copy dotfiles
echo "Copying dotfiles to respective locations"
cp -r $PWD/dotfiles/blocks/* /home/$user/.config/i3blocks
cp -r $PWD/dotfiles/i3blocks.conf /home/$user/.config/i3blocks/config
cp -r $PWD/dotfiles/config /home/$user/.config/i3
cp -r $PWD/misc/HK.jpg /home/$user/.config/i3
cp -r $PWD/dotfiles/config.rasi /home/$user/.config/rofi
cp -r $PWD/dotfiles/dunstrc /home/$user/.config/dunst

# Print instructions
echo "To edit configs, start editing with your favorite editor ~/.config/i3/config and /home/$user/.config/i3blocks files. Check containing folders also to know the structure and do more things... Happy Ricing"

# Deleting this cloned repo
#echo "NO"
echo "done, proceeding to delete script and related garbage."
rm -rf $PWD
