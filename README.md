I use [lxappearance](https://github.com/lxde/lxappearance) to change the theme for the menu bar and thunar.

Using  [picom](https://github.com/yshui/picom) https://www.youtube.com/watch?v=t6Klg7CvUxA


# Install my installation

```bash
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/pbentes/dotfiles/main/install.sh | sh
```

## Installs

```bash
git clone https://aur.archlinux.org/yay.git
cd yay-git
makepkg -si
yay -S picom-ftlabs-git
yay -S portmaster-stub-bin
```
[Portmaster Firewall](https://safing.io/)

