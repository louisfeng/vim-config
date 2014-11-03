
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs setting for non-gui vim
"if has('gui')
"  set guioptions-=e
"endif

if !has("gui_running")
  if exists("+showtabline")
    function MyTabLine()
      let s = ''
      let t = tabpagenr()
      let i = 1
      while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= '%' . i . 'T'
        let s .= (i == t ? '%1*' : '%2*')
        let s .= ' '
        let s .= i . ':'
        let s .= winnr . '/' . tabpagewinnr(i,'$')
        let s .= ' %*'
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
        let bufnr = buflist[winnr - 1]
        let file = bufname(bufnr)
        let buftype = getbufvar(bufnr, 'buftype')
        if buftype == 'nofile'
          if file =~ '\/.'
            let file = substitute(file, '.*\/\ze.', '', '')
          endif
        else
          let file = fnamemodify(file, ':p:t')
        endif
        if file == ''
          let file = '[No Name]'
        endif
        let s .= file
        let i = i + 1
      endwhile
      let s .= '%T%#TabLineFill#%='
      let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
      return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    map    <C-Tab>    :tabnext<CR>
    imap	 <C-Tab>    <C-O>:tabnext<CR>
    map    <C-S-Tab>  :tabprev<CR>
    imap   <C-S-Tab>  <C-O>:tabprev<CR>
  endif
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showtabline=2 " always show tabs in gvim, but not vim

" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor

  " Append the tab number
  let label .= v:lnum.': '

  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name

  " Append the number of windows in the tab page
  "let wincount = tabpagewinnr(v:lnum, '$')
  "return label . '  [' . wincount . ']'
  return label
endfunction

set guitablabel=%{GuiTabLabel()}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  for bufnr in bufnrlist
    " separate buffer entries
    if tip!=''
      let tip .= " \n "
    endif

    " Add name of buffer
    let name=bufname(bufnr)
    if name == ''
      " give a name to no name documents
      if getbufvar(bufnr,'&buftype')=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    endif
    let tip.=name

    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor

  return tip
endfunction

set guitabtooltip=%{GuiTabToolTip()}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set ruler 
" test if more than 2 color is avaliable 
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif   
if has("gui_running")
    set spell spelllang=en_us
    if has("win32")
        set guifont=Consolas:h10:cANSI
    endif  
endif 
colorscheme macvim
set mousem=popup
set backspace=indent,eol,start
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartindent
set autoindent
set formatoptions=tcqro
set showcmd
set nowrap
set incsearch
set number
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set complete=.,w,k
set formatoptions=1
set lbr
set showtabline=2
imap <f5>   <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
imap <f6>   Created by: Louis Feng<CR>Date: <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
au FileType make setlocal noexpandtab
set printoptions=paper:letter,left:5pc,duplex:on,number:y

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set pastetoggle=<F2>
set t_kb=
set t_kD=[3~
set background=light
