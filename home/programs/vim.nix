{ ... }:

{
  programs.vim = {
    enable = true;
    settings = {
      background = "dark";
      mouse = "a";
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      smartcase = true;
      ignorecase = true;
      tabstop = 2;
    };
    extraConfig = ''
    	let g:netrw_liststyle = 3

	set nocompatible

	filetype on

	filetype plugin on

	filetype indent on

	syntax on

	set number
	set relativenumber
	set shiftwidth=2

	set tabstop=2

	set expandtab

	set nobackup

	set scrolloff=10

	set nowrap

	set incsearch

	set ignorecase

	set smartcase

	set showcmd

	set showmode

	set showmatch

	set hlsearch

	set history=1000

	set wildmenu

	set wildmode=list:longest

	set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

	set statusline=

	set statusline+=\ %F\ %M\ %Y\ %R

	set statusline+=%=

	set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

	set laststatus=2
    '';
  };
}
