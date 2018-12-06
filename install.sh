#!/data/data/com.termux/files/usr/bin/bash
termux-setup-storage

apt update
apt install -y git zsh
# 判断本地仓库是否存在
if [[ ! -d "$HOME/termux-ohmyzsh" ]]; then
	git clone https://github.com/vanton/termux-ohmyzsh.git "$HOME/termux-ohmyzsh" --depth 1
else
	cd "$HOME/termux-ohmyzsh" || exit
	git pull
fi

# mv "$HOME/.termux" "$HOME/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)"
# cd "$HOME" || exit
# mkdir termux_bak

# NOTE 维持原设置，不删除
# \cp -rf "$HOME/.termux" "$HOME/termux_bak/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)"
\cp -rf "$HOME/termux-ohmyzsh/.termux" "$HOME/.termux"

# 判断本地仓库是否存在
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
	git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1
else
	cd "$HOME/.oh-my-zsh" || exit
	git pull
fi
# mv "$HOME/.zshrc" "$HOME/termux_bak/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)"
cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"

# ?? 删除以 ZSH_THEME 开头的行
sed -i '/^ZSH_THEME/d' "$HOME/.zshrc"
# ?? 第一行插入 ZSH_THEME="tjkirch"
sed -i '1iZSH_THEME="tjkirch"' "$HOME/.zshrc"

# echo "alias chcolor='$HOME/.termux/colors.sh'" >>"$HOME/.zshrc"
# echo "alias chfont='$HOME/.termux/fonts.sh'" >>"$HOME/.zshrc"

# 判断本地仓库是否存在
if [[ ! -d "$HOME/.zsh-syntax-highlighting" ]]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
else
	cd "$HOME/.zsh-syntax-highlighting" || exit
	git pull
fi
# ?? 删除以 zsh-syntax-highlighting 行
sed -i '/zsh-syntax-highlighting/d' "$HOME/.zshrc"
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>"$HOME/.zshrc"

# NOTE 切换默认 shell 为 zsh
chsh -s zsh

# echo 无法解析 \n
# echo -e "oh-my-zsh install complete!\\nChoose your color scheme now~"
# "$HOME/.termux/colors.sh"

# echo "Choose your font now~"
# "$HOME/.termux/fonts.sh"

echo "Please restart Termux app..."

exit
