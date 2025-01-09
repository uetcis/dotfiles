-- https://mbays.freeshell.org/lojban.vim
vim.cmd [[
" vim: set sts=4 foldmethod=marker:
" lojban plugin - various mappings
" Language:	Lojban
" Maintainer:	Martin Bays <mbays@sdf.lonestar.org>
" URL:		http://mbays.freeshell.org/lojban.vim
" Last Change:	Sun Dec 14 07:12:45 GMT 2003
"
" Notes:
"   Maps K, usually used for opening a man page, to perform word lookup with
"   full definitions. I've found it incredibly useful, myself.
"
"   Also makes mappings to run shell commands on text highlighted in visual
"   mode -
"   	\jf for jbofihe (show parse)
"	\jfx for jbofihe -x (parse and gloss)
"	\jc for jvocuhadju (to help lujvoise tanru)
"	\jcs to replace highlighted tanru with jvocuhadju's suggested lujvo	
"   (these assume your Leader is \ - it might not be)
"
"   Requires:
"	Robin Lee Powell's ll
"	    (http://www.digitalkingdom.org/~rlpowell/hobbies/software/ll)
"	jbofihe, which includes vlatai and jvocuhadju
"	    (http://www.rc0.org.uk/jbofihe/)
"	jvofendi (http://mbays.freeshell.org/jvofendi.tgz)
"	A UNIX-like shell (only tested on bash in Linux, but should all be
"	    POSIX-compatible)
"
"   Installation:
"	Just put this script in e.g. ~/.vim/ftplugin/ then use ':set
"	ft=lojban' to activate.
"
"   Handy Tip:
"	Set 'thesaurus' to include files translating from keywords to the
"	lojban - then if you can remember the keyword but not the jbovla, just
"	type the keyword and use ^X^T to translate. Suitable thesaurus files
"	are available from -
"	http://mbays.freeshell.org/gismu_thesaurus, and
"	http://mbays.freeshell.org/cmavo_thesaurus
"	then edit and uncomment the relevant lines below.	
"
"	You can try setting 'dictionary' to a wordlist, too.	
"
"	Also, if you combine this script with vimsh
"	    (http://vim.sourceforge.net/scripts/script.php?script_id=165),
"	then you can get multicoloured lojban with easy word-lookup on IRC.
"	Be warned though - it keeps on crashing for me.

let cpo_save = &cpo
set cpo-=C

nmap K :call LL(expand("<cWORD>"))<cr>
map <Leader>jc :call Jvocuhadju()<cr>
map <Leader>jcs :call JvocuhadjuSub()<cr>
map <Leader>jf :call Jbofihe("")<cr>
map <Leader>jfx :call Jbofihe("-x")<cr>

" Thesaurus handling -
set thesaurus+=~/lojban/gismu_thesaurus
set thesaurus+=~/lojban/cmavo_thesaurus
"set iskeyword+=_

"function! SynName(line, column) "{{{
"    return synIDattr(synID(a:line,a:column,0),"name")
"endfunction
"}}}

function! LL(vy) "{{{
    let vy = substitute(a:vy, "[^a-zA-Z']", '', 'g')
    echo system('case `vlatai "' . vy . '" | cut -d: -f2` in '
		\ . '*gismu*) ll -gn "' . vy . '";;'
		\ . '*cmavo*) '
		\ . 'terspu="`ll -c "' . vy . '"`";'
		\ . 'if [ "$terspu" ]; then '
		\ . 'echo "$terspu";'
		\ . 'else '
		\ . 'for terfendi in `vlatai "' . vy . '"|cut -d: -f3`;do '
		\ . 'll -c "$terfendi";'
		\ . 'done;'
		\ . 'fi;;'
		\ . '*lujvo*) '
		\ . 'for terfendi in `jvofendi "' . vy . '"`;do '
		\ . 'if [ `echo "$terfendi"|wc -c` -ge 5 ]; then '
		\ . 'll -ng "$terfendi"; '
		\ . 'else ll -gh "$terfendi";'
		\ . 'fi;'
		\ . 'done;;'
		\ . 'esac 2>/dev/null')
endfunction
"}}}

function! Jvocuhadju() range "{{{
    " yank current/last visual selection
    let old_l = @l
    :exe "normal! `<ebv`>bel\"ly"
    let vy = @l
    let @l = old_l

    let vy = substitute(vy, "\n", "", "g")
    let vy = substitute(vy, "'", "\\\\'", "g")

    let vy = substitute(vy, "[^a-zA-Z' .\\]", "", "g")

    echo vy
    echo system('jvocuhadju ' . vy)
endfunction
"}}}

function! JvocuhadjuSub() range "{{{
    " yank current/last visual selection
    let old_l = @l
    :exe "normal! `<ebv`>bel\"ly"
    let vy = @l
    let @l = old_l


    let vy = substitute(vy, "\n", "", "g")
    let vy = substitute(vy, "'", "\\\\'", "g")
    let vy = substitute(vy, "[^a-zA-Z' .\\]", "", "g")

    let ly = system('jvocuhadju ' . vy . " 2>/dev/null | "
		\ . "(while read line; do "
		\ . "if [ $thingies ] && [ $thingies -eq 2 ];"
		\ . "then echo \"`echo \"$line\" |"
		\ . "perl -ne 'if (/([a-z'\"'\"']+)/) {print $1}'`\";"
		\ . "exit 0;"
		\ . "fi;"
		\ . "if echo \"$line\" | grep -- \"---\">&/dev/null;"
		\ . "then let thingies++;"
		\ . "fi;"
		\ . "done;)")

    if ly != ""
	let ly = substitute(ly, "\n", "", "g")
	exe "normal! `<ebv`>bes" . ly . "\<esc>"
    endif
endfunction
"}}}

function! Jbofihe(flags) range "{{{
    " yank current/last visual selection
    let old_l = @l
    "normal! `<"ly`>
    :exe "normal! `<ebv`>bel\"ly"
    let vy = @l
    let @l = old_l

    let vy = substitute(vy, "\n", " ", "g")
    let vy = substitute(vy, "[^a-zA-Z0-9' .]", '', 'g')

    echo system('jbofihe ' . a:flags . ' <<< "' . vy . '"')
endfunction
"}}}

let &cpo = cpo_save

]]
