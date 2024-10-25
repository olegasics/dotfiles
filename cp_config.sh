#!/bin/bash

### Copy Config Files ###
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "$CNT - Copying config files..."

    cp -R HyprV ~/.config

    echo -e "$CNT - Attempring to set mesuring unit..."
    if locale -a | grep -q ^en_US; then
        echo -e "$COK - Setting mesuring system to imperial..."
        ln -sf ~/.config/HyprV/waybar/conf/mesu-imp.jsonc ~/.config/HyprV/waybar/conf/mesu.jsonc
        sed -i 's/SET_MESU=""/SET_MESU="I"/' ~/.config/HyprV/hyprv.conf
    else
        echo -e "$COK - Setting mesuring system to metric..."
        sed -i 's/SET_MESU=""/SET_MESU="M"/' ~/.config/HyprV/hyprv.conf
        ln -sf ~/.config/HyprV/waybar/conf/mesu-met.jsonc ~/.config/HyprV/waybar/conf/mesu.jsonc
    fi

    # Setup each appliaction
    # check for existing config folders and backup 
    for DIR in hypr kitty mako swaylock waybar wlogout wofi 
    do 
        DIRPATH=~/.config/$DIR
        if [ -d "$DIRPATH" ]; then 
            echo -e "$CAT - Config for $DIR located, backing up."
            mv $DIRPATH $DIRPATH-back &>> $INSTLOG
            echo -e "$COK - Backed up $DIR to $DIRPATH-back."
        fi

        # make new empty folders
        mkdir -p $DIRPATH &>> $INSTLOG
    done

    # link up the config files
    echo -e "$CNT - Setting up the new config..." 
    cp ~/.config/HyprV/hypr/* ~/.config/hypr/
    ln -sf ~/.config/HyprV/kitty/kitty.conf ~/.config/kitty/kitty.conf
    ln -sf ~/.config/HyprV/mako/conf/config-dark ~/.config/mako/config
    ln -sf ~/.config/HyprV/swaylock/config ~/.config/swaylock/config
    ln -sf ~/.config/HyprV/waybar/conf/v4-config.jsonc ~/.config/waybar/config.jsonc
    ln -sf ~/.config/HyprV/waybar/style/v4-style-dark.css ~/.config/waybar/style.css
    ln -sf ~/.config/HyprV/wlogout/layout ~/.config/wlogout/layout
    ln -sf ~/.config/HyprV/wofi/config ~/.config/wofi/config
    ln -sf ~/.config/HyprV/wofi/style/v4-style-dark.css ~/.config/wofi/style.css


    # add the Nvidia env file to the config (if needed)
    if [[ "$ISNVIDIA" == true ]]; then
        echo -e "\nsource = ~/.config/hypr/env_var_nvidia.conf" >> ~/.config/hypr/hyprland.conf
    fi

    # Copy the SDDM theme
    echo -e "$CNT - Setting up the login screen."
    sudo cp -R HyprV/Extras/sdt /usr/share/sddm/themes/
    sudo chown -R $USER:$USER /usr/share/sddm/themes/sdt
    sudo mkdir /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sdt" | sudo tee -a /etc/sddm.conf.d/10-theme.conf &>> $INSTLOG
    WLDIR=/usr/share/wayland-sessions
    if [ -d "$WLDIR" ]; then
        echo -e "$COK - $WLDIR found"
    else
        echo -e "$CWR - $WLDIR NOT found, creating..."
        sudo mkdir $WLDIR
    fi 
    
    # stage the .desktop file
    sudo cp HyprV/Extras/hyprland.desktop /usr/share/wayland-sessions/

    # setup the first look and feel as dark
    xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita-dark"
    xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
    cp -f ~/.config/HyprV/backgrounds/v4-background-dark.jpg /usr/share/sddm/themes/sdt/wallpaper.jpg
fi

echo -e "$CNT - All done!"
