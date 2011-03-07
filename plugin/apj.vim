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

" Section: Functions {{{1
" ============================================================
" TODO
" Check for existance of g:apjJournalHome and g:apjGpgKey

" SECTION: Check to see if today's file exists
" ============================================================
" Example file name: 110101.txt.gpg
" FIXME strftime is not portable - does this work on Windows?
" FIXME use os-specific path separator

" Function: OpenApjFile() {{{2
"
" Opens today's GPG-encrypted journal entry and creates it if necessary
"
function! OpenApjFile()

    " Which file separator?
    let s:filePathSeparator = "/"
    let	s:MSWIN = has("win16") || has("win32") || has("win64") || has("win95")
    if s:MSWIN
        s:filePathSeparator = "\\"
    end

    let s:apjTodaysFile = g:apjJournalHome . s:filePathSeparator . strftime("%y%m%d") . '.txt.gpg'
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

" vim600: set foldmethod=marker:
