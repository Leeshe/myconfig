# :book: Table of contents

- [Dotfiles](#open_file_folder-dotfiles)
	- [Ubuntu 16.04 & 18.04](#computer-ubuntu-1604--1804)
- [Installation](#wrench-installation)
	- [bash_script](#open_file_folder-bash_scriptinstallsh)
	- [coc](#open_file_folder-cocinstallsh)
	- [nvim](#open_file_folder-nviminstallsh)
	- [oh-my-zsh](#open_file_folder-oh-my-zshinstallsh)
	- [packages](#open_file_folder-packagesinstallsh)
	- [ranger](#open_file_folder-rangerinstallsh)
- [Screenshots](#art-screenshots)
	- [Neovim](#neovim)
	- [Gnome-Terminal (Oh-My-Zsh)](#gnome-terminal-oh-my-zsh)
	- [Ranger](#ranger)
- [Package Dependencies](#scroll-package-dependencies)
- [(Neo)Vim Plugins](#bookmark_tabs-neovim-plugins)
- [COC extensions](#bookmark_tabs-coc-extensions)
- [ZSH Plugins](#bookmark_tabs-zsh-plugins)
- [Ranger Plugins](#bookmark_tabs-ranger-plugins)
- [Firefox Plugins](#link-firefox-plugins)
- [GitHub](#link-github)
- [Reddit](#link-reddit)
- [Eclipse](#link-eclipse)
- [Fonts](#ab-fonts)

# :file_folder: Dotfiles

### :computer: Ubuntu 16.04 & 18.04
Development setup using **Oh-My-Zsh** and **Neovim**.  
I aim to have something in-between a light and not too heavy development setup.

## :wrench: Installation

Make [install.sh](install.sh) executable and run it:

```bash
sudo chmod +x install.sh
./install.sh
```

This script will iterate over these directories: [bash_script](bash_script), [coc](coc), [nvim](nvim), [packages](packages), [ranger](ranger) and [oh-my-zsh](oh-my-zsh);  
and execute below detailed scripts.
  
Note: [ls-icons](https://github.com/sebastiencs/ls-icons) and [Hack Regular Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)
are not installed by these scripts.

### :open_file_folder: bash_script/[install.sh](bash_script/install.sh)

```sh
# Create symlinks shell scripts in /usr/local/bin.
ln -s *.sh /usr/local/bin
```

### :open_file_folder: coc/[install.sh](coc/install.sh)

```sh
# Create nvim configuration directory
mkdir -p ~/.config/nvim

# Remove existing coc.settings.json in ~/.config/nvim
rm -f ~/.config/nvim/coc-settings.json

# Install coc extension
nvim -c 'CocInstall coc-extension'
```

### :open_file_folder: nvim/[install.sh](nvim/install.sh)

```sh
# Create nvim configuration directory
mkdir -p ~/.config/nvim

# Remove existing vim configuration files
rm -f ~/.config/nvim/{init, mapping, plugins, plugins_mappings, zsh}.vim

# Create symlinks to vim configuration files
ln -s *.vim ~/.config/nvim

# Download nvim.appimage
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage \
--output-document nvim.appimage

# Make nvim.appimage executable
chmod +x nvim.appimage

# Create symlink to nvim.appimage in '/usr/local/bin'
ln -s nvim.appimage /usr/local/bin

# Install vim-plug
url -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### :open_file_folder: oh-my-zsh/[install.sh](oh-my-zsh/install.sh)

```sh
# Install Oh My Zsh
sh -c "sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)""

# Remove existing .zshrc in ~
rm -f ~/.zshrc

# Create symlink to .zshrc in ~
ln -s .zshrc ~

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### :open_file_folder: packages/[install.sh](packages/install.sh)


```sh
# Update npm
npm install -g npm

# Install python3 for nvim
pip3 install neovim
```

### :open_file_folder: ranger/[install.sh](ranger/install.sh)

```sh
# Clone ranger in parent folder.
git clone --recursive https://github.com/ranger/ranger

# Create symlink to ../ranger/ranger.py in /usr/local/bin.
ln -s ranger/ranger.py /usr/local/bin/ranger

# Create ranger's configuration directory: ~/.config/ranger.
mkdir -p ~/.config/ranger

# Remove existing ranger's configuration files.
rm -f ~/.config/ranger/{rc.conf, rifle.conf, scope.sh}

# Create symlinks to ranger's configuration files.
ln -s {rc.conf, rifle.conf, scope.sh} ~/.config/ranger

# Install ranger_devicons plugin.
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

# Create symlink to autojump.py in ~/.config/ranger/plugins.
ln -s autojump.py ~/.config/ranger/plugins
```

## :art: Screenshots

### Neovim
![image](https://user-images.githubusercontent.com/16366403/63007733-80a70980-be81-11e9-946e-16126cecf8ad.png)

### Gnome-Terminal (Oh-My-Zsh)
![image](https://user-images.githubusercontent.com/16366403/63007993-fc08bb00-be81-11e9-9a30-26e0a07e8199.png)

### Ranger
![image](https://user-images.githubusercontent.com/16366403/63037316-288ef800-bebf-11e9-8253-b5b83e7799e1.png)

## :scroll: Package Dependencies

**autojump**

```sh
sudo apt install autojump
```

**git**
```sh
sudo apt install git
```

**python3**

```sh
sudo apt install python3
```

**pip3**

```sh
sudo apt install python3-pip
pip3 install neovim
```

**nodejs npm**

```sh
sudo apt install nodejs npm
npm install -g npm
```

## :bookmark_tabs: (Neo)Vim Plugins

| Category              | Plugin                                                                       | Description                                                                                                     |
| :-                    | :-                                                                           | :-                                                                                                              |
| Alignment             | [vim-easy-align](https://github.com/junegunn/vim-easy-align)                 | A simple, easy-to-use Vim alignment plugin.                                                                     |
| Buffers               | [vim-buffet](https://github.com/bagrat/vim-buffet)                           | Bring the IDE-like tabs                                                                                         |
| Colorscheme           | [vim-sublime-monokai](https://github.com/ErichDonGubler/vim-sublime-monokai) | vim-sublime-monokai is a refined Monokai color scheme for vim tries to look like Sublime's default color scheme |
| Completion            | [coc.nvim](https://github.com/neoclide/coc.nvim)                             | Coc is an intellisense engine                                                                                   |
| Fading Buffers        | [vimade](https://github.com/TaDaa/vimade)                                    | Fade your inactive buffers                                                                                      |
| Fuzzy finder          | [fzf.vim](https://github.com/junegunn/fzf.vim)                               | fzf is a general-purpose command-line fuzzy finder                                                              |
| Git                   | [fugitive.vim](https://github.com/tpope/vim-fugitive)                        | Git wrapper                                                                                                     |
| Integration           | [vim-test](https://github.com/janko/vim-test)                                | Run your tests at the speed of thought                                                                          |
| Interface             | [indentLine](https://github.com/Yggdroot/indentLine)                         | Display thin vertical lines at each indentation level                                                           |
| Moving                | [vim-easymotion](https://github.com/easymotion/vim-easymotion)               | Provide a much simpler way to use some motions                                                                  |
| Starting              | [vim-startify](https://github.com/mhinz/vim-startify)                        | Provide a start screen                                                                                          |
| Statusline            | [lightline.vim](https://github.com/itchyny/lightline.vim)                    | A light and configurable statusline/tabline                                                                     |
| Syntax                | [java-syntax](https://github.com/uiiaoo/java-syntax.vim)                     | Provides syntax highlighting for Java                                                                           |
| Variable Highlighting | [Semantic-Highlighting](https://github.com/jaxbot/semantic-highlight.vim)    | Where every variable is a different color, an idea popularized by Evan Brooks' blog post.                       |
| Viewer                | [vista.vim](https://github.com/liuchengxu/vista.vim)                         | View and search LSP symbols, tags                                                                               |

## :bookmark_tabs: COC extensions

| Extension                                                         | Description                                                                                                                           |
| :-                                                                | :-                                                                                                                                    |
| [coc-clock](https://github.com/iamcco/coc-clock)                  | coc extensions of clock.nvim                                                                                                          |
| [coc-git](https://github.com/neoclide/coc-git)                    | Git integration of coc.nvim.                                                                                                          |
| [coc-highlight](https://github.com/neoclide/coc-highlight)        | Provide default highlight for coc.nvim, including document highlight (highlight of current document symbol) and colors highlight.     |
| [coc-java](https://github.com/neoclide/coc-java)                  | Fork of vscode-java to works with coc.nvim.                                                                                           |
| [coc-json](https://github.com/neoclide/coc-json)                  | Json language server extension for coc.nvim.                                                                                          |
| [coc-lists](https://github.com/neoclide/coc-lists)                | Some basic list sources for coc.nvim                                                                                                  |
| [coc-marketplace](https://github.com/fannheyward/coc-marketplace) | coc.nvim extensions marketplace.                                                                                                      |
| [coc-pairs](https://github.com/neoclide/coc-pairs)                | Auto pair extension for coc.nvim.                                                                                                     |
| [coc-snippets](https://github.com/neoclide/coc-snippets)          | Snippets solution for coc.nvim                                                                                                        |
| [coc-xml](https://github.com/fannheyward/coc-xml)                 | fork of vscode-xml, provides support for creating and editing XML documents, based on the LSP4XML Language Server, running with Java. |

## :bookmark_tabs: ZSH Plugins

| Plugin                                                                          | Description                                                    |
| :-                                                                              | :-                                                             |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)         | Suggest commands as you type based on history and completions. |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Provide syntax highlighting for the shell zsh.                 |

## :bookmark_tabs: Ranger Plugins

| Plugin                                                                   | Description                                                         |
| :-                                                                       | :-                                                                  |
| [ranger-autojump](https://github.com/fdw/ranger-autojump)                | Add complete support for autojump to ranger.                        |
| [ranger_devicons](https://github.com/alexanderjeurissen/ranger_devicons) | Introduce a new linemode that prefixes file names with a file icon. |

## :link: Firefox Plugins

| Plugin                                                                              | Description                                                                                        |
| :-                                                                                  | :-                                                                                                 |
| [Flagfox](https://addons.mozilla.org/en-US/firefox/addon/flagfox)                   | Display a flag icon indicating the current webserver's physical location.                          |
| [Ghostery](https://addons.mozilla.org/en-US/firefox/addon/ghostery)                 | Block ads, stop trackers and speed up websites.                                                    |
| [Grammarly](https://addons.mozilla.org/en-US/firefox/addon/grammarly-1)             | Make sure your messages, documents, and social media posts are clear, mistake-free, and impactful. |
| [HTTPS Everywhere](https://addons.mozilla.org/en-US/firefox/addon/https-everywhere) | Protect your communications by enabling HTTPS encryption.                                          |
| [New Tab Tools](https://addons.mozilla.org/en-US/firefox/addon/new-tab-tools)       | Customizes the new tab page.                                                                       |
| [Tree Style Tabs](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab)    | Show tabs like a tree.                                                                             |
| [UBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin)       | An efficient blocker: easy on memory and CPU footprint.                                            |

## :link: GitHub

| Project                                                | Description                                                                                  |
| :-                                                     | :-                                                                                           |
| [ls-icons](https://github.com/sebastiencs/ls-icons)    | ls command with files icons.                                                                 |
| [Neovim](https://github.com/neovim/neovim)             | Vim-fork focused on extensibility and usability.                                             |
| [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh) | Oh My Zsh is an open source, community-driven framework for managing your zsh configuration. |
| [Ranger](https://github.com/ranger/ranger)             | ranger is a console file manager with VI key bindings.                                       |

## :link: Reddit

| Reddit                                    | Description                                       |
| :-                                        | :-                                                |
| [Vim](https://www.reddit.com/r/vim/)      | For Vim enthusiasts and anyone interested in Vim. |
| [Neovim](https://www.reddit.com/r/neovim) | vim out of the box — http://neovim.org/           |

## :link: Eclipse
[Rainbow Theme](http://www.eclipsecolorthemes.org/?view=theme&id=24587)

## :ab: Fonts

[Hack Regular Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)
