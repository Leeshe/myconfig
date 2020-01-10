# :book: Table of contents

- [Dotfiles](#open_file_folder-dotfiles)
	- [Ubuntu 16.04 & 18.04](#computer-ubuntu-1604--1804)
- [Installation](#wrench-installation)
- [Screenshots](#art-screenshots)
	- [Neovim](#neovim)
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

Note: [ls-icons](https://github.com/sebastiencs/ls-icons) and [Hack Regular Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)
are not installed by this script.

## :art: Screenshots

### Neovim
![image](https://user-images.githubusercontent.com/16366403/69057064-7e6cc200-0a11-11ea-8d71-ef6fd71ea841.png)

## :bookmark_tabs: (Neo)Vim Plugins

| Category              | Plugin                                                                       | Description                                                                                                     |
| :-                    | :-                                                                           | :-                                                                                                              |
| Alignment             | [vim-easy-align](https://github.com/junegunn/vim-easy-align)                 | A simple, easy-to-use Vim alignment plugin.                                                                     |
| Buffers               | [vim-buffet](https://github.com/bagrat/vim-buffet)                           | Bring the IDE-like tabs                                                                                         |
| Colorscheme           | [vim-sublime-monokai](https://github.com/ErichDonGubler/vim-sublime-monokai) | vim-sublime-monokai is a refined Monokai color scheme for vim tries to look like Sublime's default color scheme |
| Completion            | [coc.nvim](https://github.com/neoclide/coc.nvim)                             | Coc is an intellisense engine                                                                                   |
| Fading Buffers        | [vimade](https://github.com/TaDaa/vimade)                                    | Fade your inactive buffers                                                                                      |
| Fuzzy finder          | [fzf.vim](https://github.com/junegunn/fzf.vim)                               | fzf is a general-purpose command-line fuzzy finder                                                              |
| Finder and Dispatcher | [vim-clap](https://github.com/liuchengxu/vim-clap)                           | Generic interactive finder and dispatcher                                                                       |
| Git                   | [fugitive.vim](https://github.com/tpope/vim-fugitive)                        | Git wrapper                                                                                                     |
| Integration           | [vim-test](https://github.com/janko/vim-test)                                | Run your tests at the speed of thought                                                                          |
| Interface             | [indentLine](https://github.com/Yggdroot/indentLine)                         | Display thin vertical lines at each indentation level                                                           |
| Moving                | [vim-easymotion](https://github.com/easymotion/vim-easymotion)               | Provide a much simpler way to use some motions                                                                  |
| Starting              | [vim-startify](https://github.com/mhinz/vim-startify)                        | Provide a start screen                                                                                          |
| Statusline            | [statusline.vim](nvim/statusline.vim)                                        | Custom statusline, see screenshot                                                                               |
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
