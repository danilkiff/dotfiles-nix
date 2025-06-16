set background=dark
set number
colorscheme habamax

set showbreak=↪\ 
set list listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨


" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Always ensure newline at end of file
set fixendofline
