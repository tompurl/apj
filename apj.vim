" ============================================================================
" File:         apj.vim
" Description:  Plugin that makes is simple to keep an encrypted diary/journal
" Maintainer:   Tom Purl <tom@tompurl.com>
" Last Change:  2/9/11
" Dependencies: GnuPG
"               The GnuPG Vim Plugin
" License:      This program is free software. It comes without any warranty,
"               to the extent permitted by applicable law. 
" ============================================================================

" TODO We will need to know where the journal entries will be store.  Mabye
" s:apjJournalHome?
" FIXME Put this in ~/.vimrc and look for it, die if it doesn't exist.
let s:apjJournalHome = '/home/tom/gtd/diary/entries'
let s:apjGpgKey = 'Tom Purl (Secret Key) <tom@tompurl.com>'

" SECTION: Check to see if today's file exists
" "============================================================
" Example file name: 110101.txt.gpg
" FIXME strftime is not portable - does this work on Windows?
" FIXME use os-specific path separator

function! OpenApjFile()
    let s:apjTodaysFile = s:apjJournalHome . '/' . strftime("%y%m%d") . '.txt.gpg'
    echo s:apjTodaysFile

    " TODO If the file doesn't exist, create an empty encrypted version
    if filereadable(s:apjTodaysFile) != 0
        !gpg -e -r "s:apjGpgKey"  > s:apjTodaysFile
    endif

    " TODO Open the file
    e s:apjTodaysFile
endfunction
