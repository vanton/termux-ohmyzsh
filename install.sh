#!/data/data/com.termux/files/usr/bin/bash
termux-setup-storage

apt update
apt install -y git zsh
git clone https://github.com/vanton/termux-ohmyzsh.git "$HOME/termux-ohmyzsh" --depth 1

# mv "$HOME/.termux" "$HOME/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)"
cd "$HOME" || exit
mkdir termux_bak

# NOTE 维持原设置，不删除
# \cp -rf "$HOME/.termux" "$HOME/termux_bak/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)"
\cp -rf "$HOME/termux-ohmyzsh/.termux" "$HOME/.termux"

git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1
# mv "$HOME/.zshrc" "$HOME/termux_bak/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)"
cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"

# ?? 删除以 ZSH_THEME 开头的行
sed -i '/^ZSH_THEME/d' "$HOME/.zshrc"
# ?? 第一行插入 ZSH_THEME="tjkirch"
sed -i '1iZSH_THEME="tjkirch"' "$HOME/.zshrc"

# echo "alias chcolor='$HOME/.termux/colors.sh'" >>"$HOME/.zshrc"
# echo "alias chfont='$HOME/.termux/fonts.sh'" >>"$HOME/.zshrc"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>"$HOME/.zshrc"

chsh -s zsh

# echo 无法解析 \n
# echo -e "oh-my-zsh install complete!\\nChoose your color scheme now~"
# "$HOME/.termux/colors.sh"

# echo "Choose your font now~"
# "$HOME/.termux/fonts.sh"

echo "Please restart Termux app..."

exit
