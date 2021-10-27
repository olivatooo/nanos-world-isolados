let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd /hd/Clones/isolados_Refactor/Packages/isolados
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 term:///hd/Clones/isolados_Refactor//2957:/usr/bin/fish
badd +1 Client/Index.lua
badd +97 Client/UI/index.html
badd +0 term:///hd/Clones/isolados_Refactor/Packages/isolados//3192:/usr/bin/fish
badd +10 Client/UI/weapon_comparison.js
badd +2 Client/UI/player_hp.js
argglobal
%argdel
$argadd .
set stal=2
tabnew
tabnew
tabrewind
argglobal
if bufexists("term:///hd/Clones/isolados_Refactor//2957:/usr/bin/fish") | buffer term:///hd/Clones/isolados_Refactor//2957:/usr/bin/fish | else | edit term:///hd/Clones/isolados_Refactor//2957:/usr/bin/fish | endif
if &buftype ==# 'terminal'
  silent file term:///hd/Clones/isolados_Refactor//2957:/usr/bin/fish
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 4 - ((3 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 4
normal! 03|
lcd /hd/Clones/isolados_Refactor
tabnext
argglobal
if bufexists("term:///hd/Clones/isolados_Refactor/Packages/isolados//3192:/usr/bin/fish") | buffer term:///hd/Clones/isolados_Refactor/Packages/isolados//3192:/usr/bin/fish | else | edit term:///hd/Clones/isolados_Refactor/Packages/isolados//3192:/usr/bin/fish | endif
if &buftype ==# 'terminal'
  silent file term:///hd/Clones/isolados_Refactor/Packages/isolados//3192:/usr/bin/fish
endif
balt term:///hd/Clones/isolados_Refactor/Packages/isolados//3192:/usr/bin/fish
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 9 - ((8 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 9
normal! 017|
tabnext
edit /hd/Clones/isolados_Refactor/Packages/isolados/Client/UI/index.html
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 106 + 106) / 213)
exe 'vert 2resize ' . ((&columns * 106 + 106) / 213)
argglobal
balt /hd/Clones/isolados_Refactor/Packages/isolados/Client/Index.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 117 - ((29 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 117
normal! 076|
wincmd w
argglobal
if bufexists("/hd/Clones/isolados_Refactor/Packages/isolados/Client/UI/weapon_comparison.js") | buffer /hd/Clones/isolados_Refactor/Packages/isolados/Client/UI/weapon_comparison.js | else | edit /hd/Clones/isolados_Refactor/Packages/isolados/Client/UI/weapon_comparison.js | endif
if &buftype ==# 'terminal'
  silent file /hd/Clones/isolados_Refactor/Packages/isolados/Client/UI/weapon_comparison.js
endif
balt /hd/Clones/isolados_Refactor/Packages/isolados/Client/UI/index.html
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 24 - ((23 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 24
normal! 0
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 106 + 106) / 213)
exe 'vert 2resize ' . ((&columns * 106 + 106) / 213)
tabnext 3
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFIc
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
