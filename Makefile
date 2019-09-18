STOW_FLAGS = --verbose=1

.PHONY: install
install: bin gpg zsh git vim terminator kitty fonts i3 profile

.PHONY: dirs
dirs:
	@mkdir -v -p ~/.config

.PHONY: bin
bin:
	@mkdir -v -p ~/.local/bin
	stow bin $(STOW_FLAGS)

.PHONY: x
x:
	stow x $(STOW_FLAGS)

.PHONY: dunst
dunst:
	stow dunst $(STOW_FLAGS)

.PHONY: rofi
rofi:
	stow rofi $(STOW_FLAGS)

.PHONY: polybar
polybar:
	stow polybar $(STOW_FLAGS)

.PHONY: i3
i3: dirs bin x dunst rofi polybar
	stow i3 $(STOW_FLAGS)

.PHONY: git
git:
	stow git $(STOW_FLAGS)
	touch ~/.gitconfig.local

.PHONY: fzf
fzf:
	-[ ! -d ~/.fzf ] && git clone https://github.com/junegunn/fzf.git ~/.fzf --depth 1
	~/.fzf/install --no-update-rc --completion --key-bindings --no-bash --64

.PHONY: vim
vim: fzf
	stow vim $(STOW_FLAGS)
	vim +PlugInstall +qall

.PHONY: terminator
terminator:
	stow terminator $(STOW_FLAGS)

.PHONY: kitty
kitty:
	stow kitty $(STOW_FLAGS)

.PHONY: fonts
fonts:
	mkdir -v -p ~/.local/share/fonts
	stow fonts $(STOW_FLAGS)
	fc-cache -f

.PHONY: zplug
zplug:
	-[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug.git ~/.zplug

.PHONY: zsh
zsh: zplug fzf
	stow zsh $(STOW_FLAGS)
	chsh -s /usr/bin/zsh

.PHONY: gpg
gpg:
	mkdir -v -p -m 700 ~/.gnupg
	stow gnupg $(STOW_FLAGS)

.PHONY: gtk
gtk:
	stow gtk $(STOW_FLAGS)

.PHONY: profile
profile:
	stow profile $(STOW_FLAGS)
	@touch ~/.profile
	if ! grep -q '.profile.local' ~/.profile; then echo '. ~/.profile.local' >> ~/.profile; fi
