# dotfiles

For install my configuration:

1. Clone repo
2. Create links from your configuration files to my:

   `ln -s ~/.zshrc` ~/dotfiles/.zshrc



For install theme:

I'm using [plymouth-git](https://github.com/adi1090x/plymouth-themes)

[Video instrictions](https://www.youtube.com/watch?v=3aO9HDQj9do)

1. `yay -S plymouth-git`
2. `yay -S plymouth-theme-optimus-git`
3. `sudo vim /etc/mkinitcpio.conf` and add `plymouth-git` to HOOKS
4. `sudo vim /etc/default/grub` and add `quiet splash` end of LINUX_DEFAULT line
5. `plymouth-set-default-theme -l` show themes list
6. `plymouth-set-default-theme optimus` - install optimus theme. You can choice your options instead of `optimus`
7. `sudo mkinitcpio -p linux`
8. `sudo grub-mkconfig -o /boot/grub/grub.cfg`

