" ============================================================================
" File:         apj.vim
" Description:  Plugin that makes is simple to keep an encrypted diary/journal
" Maintainer:   Tom Purl <tom@tompurl.com>
" Last Change:  2/9/11
" Dependencies: GnuPG
"               The GnuPG Vim Plugin
" Revision:     1
" License:      This program is free software. It comes without any warranty,
"               to the extent permitted by applicable law. 
" ============================================================================

" Section: Documentation {{{1
" Description:
"   
"   This script is a small wrapper for the GnuPG Vim plugin that makes it easy
"   to keep daily, GPG-encrypted journal or diary. Simply type the following
"   in Vim after sourcing the apj.vim file:
"
"   :call OpenApjFile
"
"   This function will open today's gpg-encrypted diary entry. If the file
"   does not exist yet, then the function will create it. You can then edit
"   your entry using the wonderful GnuPG Vim plugin.
"
" Installation: 
"
"   This script requires that you install the following:
"
"   * GnuPG
"   * The GnuPG plugin for Vim
"
"   :source /some/path/apj.vim
"   Refer to ':help add-plugin', ':help add-global-plugin' and ':help
"   runtimepath' for more details about Vim plugins.
"
" Commands:
"
"   :call OpenApjFile
"     Opens today's GPG-encrypted journal entry and creates it if necessary.
"
" Variables:
"
"   g:apjGpgKey
"     The name of your GnuPG key
"   g: apjJournalHome
"     The folder where you will stor all of your journal entries.
"

" Section: Failure Modes {{{1
" ============================================================
" FM01 - The user has not installed the gnupg vim plugin
" FM02 - The specified gpg key doesn't exist
" FM02 - The journal home is not writable
 
" Section: Possible Enhancements {{{1
" ============================================================
" * Do a :bdelete when the user navigates away from the gpg-encrypted buffer?
" * Collect stats on the current page (or any arbitrary number of entries)
" * Clear the screen when you close a file
" * Be able to open a diary file that wasn't created today. For example,
"   :call OpenApjFile yesterday or :call OpenApjFile 2-5-11
" * Reporting!!!

" Section: Functions {{{1
" ============================================================
 
" Function: s:sanityCheck() {{{2
"
" Make sure that all of the necessary global variables have values
"
function! s:sanityCheck()
    " TODO Store the var names in an array and loop over them 
    if !exists("g:apjGpgKey")
      echohl WarningMsg | echo 'You need to set the g:apjGpgKey variable'| echohl None
    endif
    if !exists("g:apjJournalHome")
      echohl WarningMsg | echo 'You need to set the g:apjJournalHome variable'| echohl None
    endif
endfunction
 
" Function: OpenApjFile() {{{2
"
" Opens today's GPG-encrypted journal entry and creates it if necessary
"
function! OpenApjFile()

    call s:sanityCheck()

    " TODO strftime is not portable - does this work on Windows?
    let s:apjTodaysFile = g:apjJournalHome . s:filePathSeparator . strftime("%y%m%d") . '.txt.gpg'

    " If the file doesn't exist, create an empty encrypted version
    if filereadable(s:apjTodaysFile) == 0
        echo 'creating file...'
        let s:apjGpgCmd = 'echo foo | gpg -e -r "' . g:apjGpgKey . '" > ' . s:apjTodaysFile
        exec "!" . s:apjGpgCmd
    endif

    " Open the file
    let s:apjOpenFileCmd = 'edit ' . s:apjTodaysFile
    exec s:apjOpenFileCmd
endfunction

" Section: Init values and code {{{1
" ============================================================

call s:sanityCheck()

""" Set the file path separator
" TODO Test this on Windows
let s:filePathSeparator = "/"
let s:MSWIN = has("win16") || has("win32") || has("win64") || has("win95")
if s:MSWIN
    s:filePathSeparator = "\\"
end

" Section: Keymappings {{{1
" ============================================================

" Keymap for opening today's file
nmap <silent> <Leader>jj :call OpenApjFile()<CR>
imap <silent> <Leader>jj <ESC>:call OpenApjFile()<CR>
 
" vim600: set foldmethod=marker:
