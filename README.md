# :book: Table of contents

- [Dotfiles](#open_file_folder-dotfiles)
	- [Ubuntu 16.04 & 18.04](#computer-ubuntu-1604--1804)
- [Installation](#wrench-installation)
- [Screenshots](#art-screenshots)
	- [Neovim](#neovim)
	- [Gnome-Terminal (Oh-My-Zsh)](#gnome-terminal-oh-my-zsh)
    - [Ranger](#ranger)
- [Package Dependencies](#scroll-package-dependencies)
- [(Neo)Vim Plugins](#bookmark_tabs-neovim-plugins)
- [COC extensions](#bookmark_tabs-coc-extensions)
- [ZSH Plugins](#bookmark_tabs-zsh-plugins)
- [Fonts](#ab-fonts)
- [Firefox Plugins](#link-firefox-plugins)
- [GitHub](#link-github)
- [Reddit](#link-reddit)
- [Eclipse](#link-eclipse)


# :open_file_folder: Dotfiles

### :computer: Ubuntu 16.04 & 18.04
Development setup using **Oh-My-Zsh** and **Neovim**.  
I aim to have something in-between a light and not too heavy development setup.

## :wrench: Installation

Make `install.sh` executable and run it:

```bash
sudo chmod +x install.sh
./install.sh
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

| Category  	| Plugins  	| Description |
|:-:	|:-	| :- |
| Statusline  	| <ul><li>[lightline.vim](https://github.com/itchyny/lightline.vim)</ul></li>  	| <ul><li>A light and configurable statusline/tabline</ul></li> |
| Buffers  	| <ul><li>[vimade](https://github.com/TaDaa/vimade)</li><li>[vim-buffet](https://github.com/bagrat/vim-buffet)</li></ul>  | <ul><li>Fade your inactive buffers</li><li>Bring the IDE-like tabs</li></ul>
| Completion  	| <ul><li>[Coc.nvim](https://github.com/neoclide/coc.nvim)  	| <ul><li>Coc is an intellisense engine
| Colorscheme  	| <ul><li>[vim-sublime-monokai](https://github.com/ErichDonGubler/vim-sublime-monokai)</ul></li>  	| <ul><li>vim-sublime-monokai is a refined Monokai color scheme for vim tries to look like Sublime's default color scheme</ul></li>
| Syntax        | <ul><li>[java-syntax](https://github.com/uiiaoo/java-syntax.vim)</li></ul>   | <ul><li>Provides syntax highlighting for Java</li></ul>
| Lists 	| <ul><li>[fzf.vim](https://github.com/junegunn/fzf.vim)</li><li>[vista.vim](https://github.com/liuchengxu/vista.vim)</li><li>[vim-startify](https://github.com/mhinz/vim-startify)</li></ul>	| <ul><li>fzf is a general-purpose command-line fuzzy finder</li><li>View and search LSP symbols, tags</li><li>Provide a start screen</li></ul>
| Moving  	| <ul><li>[vim-easymotion](https://github.com/easymotion/vim-easymotion)</ul></li>  	| <ul><li>Provide a much simpler way to use some motions</ul></li>
| Interface  	| <ul><li>[indentLine](https://github.com/Yggdroot/indentLine)</li></ul>  	| <ul><li>Display thin vertical lines at each indentation level</li></ul>
| Integrations   | <ul><li>[fugitive.vim](https://github.com/tpope/vim-fugitive)</li><li>[vim-test](https://github.com/janko/vim-test)</ul>   | <ul><li>Git wrapper</li><li>Run your tests at the speed of thought</li></ul>

## :bookmark_tabs: COC extensions

|  Extension    |  Description  |
|  :-:   | :- |
|  [coc-clock](https://github.com/iamcco/coc-clock)     | coc extensions of clock.nvim  |
|  [coc-git](https://github.com/neoclide/coc-git)       | Git integration of coc.nvim.  |
|  [coc-highlight](https://github.com/neoclide/coc-highlight)   | Provide default highlight for coc.nvim, including document highlight (highlight of current document symbol) and colors highlight.  |
|  [coc-java](https://github.com/neoclide/coc-java)     | Fork of vscode-java to works with coc.nvim.  |
|  [coc-json](https://github.com/neoclide/coc-json)     | Json language server extension for coc.nvim.  |
|  [coc-lists](https://github.com/neoclide/coc-lists)   | Some basic list sources for coc.nvim  |
|  [coc-marketplace](https://github.com/fannheyward/coc-marketplace)    | coc.nvim extensions marketplace.  |
|  [coc-pairs](https://github.com/neoclide/coc-pairs)   | Auto pair extension for coc.nvim.  |
|  [coc-snippets](https://github.com/neoclide/coc-snippets) | Snippets solution for coc.nvim  |
|  [coc-xml](https://github.com/fannheyward/coc-xml)    | fork of vscode-xml, provides support for creating and editing XML documents, based on the LSP4XML Language Server, running with Java.  |

## :bookmark_tabs: ZSH Plugins

|  Plugin       |  Description  |
|  :-:          |  :-           |
|  [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)      |  It suggests commands as you type based on history and completions.  |
|  [zsh-sytax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)   |  This package provides syntax highlighting for the shell zsh.  |

## :link: Firefox Plugins
|  Plugin  |  Description  |
|  :-:  | :-  |
|  [Flagfox](https://addons.mozilla.org/en-US/firefox/addon/flagfox)  |  Display a flag icon indicating the current webserver's physical location.  |
|  [Ghostery](https://addons.mozilla.org/en-US/firefox/addon/ghostery)  |  Block ads, stop trackers and speed up websites.  |
|  [Grammarly](https://addons.mozilla.org/en-US/firefox/addon/grammarly-1)  |  Make sure your messages, documents, and social media posts are clear, mistake-free, and impactful.  |
|  [HTTPS Everywhere](https://addons.mozilla.org/en-US/firefox/addon/https-everywhere)  |  Protect your communications by enabling HTTPS encryption.  |
|  [New Tab Tools](https://addons.mozilla.org/en-US/firefox/addon/new-tab-tools)  |  Customizes the new tab page.  |
|  [Tree Style Tabs](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab)  |  Show tabs like a tree.  |
|  [UBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin)  |  An efficient blocker: easy on memory and CPU footprint.  |

## :link: GitHub
[ls-icons](https://github.com/sebastiencs/ls-icons)  
[Neovim](https://github.com/neovim/neovim)  
[Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)  
[Ranger](https://github.com/ranger/ranger)

## :link: Reddit
[Vim](https://www.reddit.com/r/vim/)  
[Neovim](https://www.reddit.com/r/neovim)

## :ab: Fonts

[Hack Regular Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)

## :link: Eclipse
[Rainbow Theme](http://www.eclipsecolorthemes.org/?view=theme&id=24587)
