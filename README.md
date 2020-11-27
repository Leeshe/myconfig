# :book: Table of contents

- [Dotfiles](#open_file_folder-dotfiles)
	- [Ubuntu 18.04](#computer-ubuntu-1804)
- [Installation](#wrench-installation)
- [Screenshots](#art-screenshots)
	- [Neovim](#neovim)
- [(Neo)Vim Plugins](#bookmark_tabs-neovim-plugins)
- [Other plugins](#bookmark_tabs-other-interesting-plugins)
- [ZSH Plugins](#bookmark_tabs-zsh-plugins)
- [Firefox Plugins](#link-firefox-plugins)
- [GitHub](#link-github)
- [Reddit](#link-reddit)
- [Fonts](#ab-fonts)

# :file_folder: Dotfiles

### :computer: Ubuntu 18.04
Development setup using **Oh-My-Zsh** and **Neovim**.  
I aim to have something in-between a light and not too heavy development setup.

## :wrench: Installation

Make [install.sh](install.sh) executable and run it:

```bash
sudo chmod +x install.sh
./install.sh
```

Note: [colorls](https://github.com/athityakumar/colorls) and [FiraCode](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
are not installed by this script.

## :art: Screenshots

### Neovim
![image](https://user-images.githubusercontent.com/16366403/100484720-d72f6a00-30fd-11eb-8b32-61e9a66e9ff3.png)

## :bookmark_tabs: (Neo)Vim Plugins

| Category    | Plugin                                                                       | Description                                                                                                     |
| :-          | :-                                                                           | :-                                                                                                              |
| Colorscheme | [vim-sublime-monokai](https://github.com/ErichDonGubler/vim-sublime-monokai) | vim-sublime-monokai is a refined Monokai color scheme for vim tries to look like Sublime's default color scheme |
| Completion  | [completion-nvim](https://github.com/nvim-lua/completion-nvim)               | Completion-nvim is an auto completion framework.                                                                |
| Completion  | [completion-buffers](https://github.com/steelsojka/completion-buffers)       | A buffer completion source for completion-nvim                                                                  |
| Completion  | [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)                            | VSCode(LSP)'s snippet feature in vim.                                                                           |
| Completion  | [vim-vsnip-integ](https://github.com/hrsh7th/vim-vsnip-integ)                | Snippet completion/expansion.                                                                                   |
| Completion  | [auto-pairs](https://github.com/jiangmiao/auto-pairs)                        | Insert or delete brackets, parens, quotes in pair.                                                              |
| Finder      | [LeaderF](https://github.com/Yggdroot/LeaderF)                               | An efficient fuzzy finder that helps to locate files, buffers, mrus, gtags, etc. on the fly.                    |
| Finder      | [popup.nvim](https://github.com/nvim-lua/popup.nvim)                         | An implementation of the Popup API from vim in Neovim..                                                         |
| Finder      | [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)                     | Lua functions.                                                                                                  |
| Finder      | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)           | Telescope.nvim is a next generation library for creating floating pickers with advanced features..              |
| Formatting  | [vim-easy-align](https://github.com/junegunn/vim-easy-align)                 | A simple, easy-to-use Vim alignment plugin.                                                                     |
| Git         | [fugitive.vim](https://github.com/tpope/vim-fugitive)                        | Git wrapper                                                                                                     |
| Git         | [vim-gitgutter](https://github.com/airblade/vim-gitgutter)                   | A Vim plugin which shows a git diff in the sign column.                                                         |
| LSP         | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                   | Collection of common configurations for the Nvim LSP client.                                                    |
| LSP         | [lsp-status.nvim](https://github.com/nvim-lua/lsp-status.nvim)               | Neovim plugin/library for generating statusline components from the built-in LSP client.                        |
| Parser      | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)        | Treesitter configurations and abstraction layer for Neovim.                                                     |
| Statusline  | [statusline.vim](nvim/status-line.vim)                                       | Custom statusline, see screenshot                                                                               |
| Tabs        | [barbar.nvim](https://github.com/romgrk/barbar.nvim)                         | Tabs, as understood by any other editor.                                                                        |

## :bookmark_tabs: Other interesting plugins

| Category       | Plugin                                                                          | Description                                           |
| :-             | :-                                                                              | :-                                                    |
| Fading Buffers | [vimade](https://github.com/TaDaa/vimade)                                       | Fade your inactive buffers                            |
| Interface      | [indentLine](https://github.com/Yggdroot/indentLine)                            | Display thin vertical lines at each indentation level |
| Interface      | [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides on blank lines for Neovim               |
| Integration    | [vim-test](https://github.com/janko/vim-test)                                   | Run your tests at the speed of thought                |
| Interface      | [scrollbar.nvim](https://github.com/Xuyuanp/scrollbar.nvim)                     | scrollbar for neovim(nightly)                         |

## :bookmark_tabs: ZSH Plugins

| Plugin                                                                          | Description                                                    |
| :-                                                                              | :-                                                             |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)         | Suggest commands as you type based on history and completions. |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Provide syntax highlighting for the shell zsh.                 |

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
| [colorls](https://github.com/athityakumar/colorls)     | A Ruby script that colorizes the `ls` output with color and icons..                          |
| [Neovim](https://github.com/neovim/neovim)             | Vim-fork focused on extensibility and usability.                                             |
| [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh) | Oh My Zsh is an open source, community-driven framework for managing your zsh configuration. |

## :link: Reddit

| Reddit                                    | Description                                       |
| :-                                        | :-                                                |
| [Vim](https://www.reddit.com/r/vim/)      | For Vim enthusiasts and anyone interested in Vim. |
| [Neovim](https://www.reddit.com/r/neovim) | vim out of the box — http://neovim.org/           |

## :ab: Fonts

[FiraCode](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
