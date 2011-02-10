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

" SECTION: Failure Modes
" ============================================================
" FM01 - The user has not installed the gnupg vim plugin
" FM02 - The specified gpg key doesn't exist
" FM02 - The journal home is not writable

" SECTION: Sanity check
" ============================================================
" TODO

" SECTION: Check to see if today's file exists
" ============================================================
" Example file name: 110101.txt.gpg
" FIXME strftime is not portable - does this work on Windows?
" FIXME use os-specific path separator

function! OpenApjFile()
    let s:apjTodaysFile = g:apjJournalHome . '/' . strftime("%y%m%d") . '.txt.gpg'
    "echo s:apjTodaysFile

    " If the file doesn't exist, create an empty encrypted version
    if filereadable(s:apjTodaysFile) == 0
        echo 'creating file...'
        let s:apjGpgCmd = 'echo foo | gpg -e -r "' . g:apjGpgKey . '" > ' . s:apjTodaysFile
        "echo s:apjGpgCmd
        exec "!" . s:apjGpgCmd
    endif

    " Open the file
    let s:apjOpenFileCmd = 'edit ' . s:apjTodaysFile
    exec s:apjOpenFileCmd
endfunction
