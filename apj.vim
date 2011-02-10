" ============================================================================
" File:        pdiary.vim
" Description: Plugin that makes is simple to keep an encrypted diary/journal
" Maintainer:  Tom Purl <tom@tompurl.com>
" Last Change: 2/9/11
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. 
" ============================================================================

" TODO We will need to know where the journal entries will be store.  Mabye
" s:tpDiaryHome?
" FIXME Put this in ~/.vimrc and look for it, die if it doesn't exist.
let s:tpDiaryHome = '/home/tom/gtd/diary/entries'

" SECTION: Check to see if today's file exists
" "============================================================
" Example file name: 110101.txt.gpg
" FIXME strftime is not portable - does this work on Windows?
" FIXME use os-specific path separator
let s:tpTodaysFile = s:tpDiaryHome . '/' . strftime("%y%m%d") . '.txt.gpg'
echo s:tpTodaysFile

" TODO If the file doesn't exist, create an empty encrypted version
if !exists(s:tpTodaysFile)

" TODO Open the file

" TODO Close the file and clear the screen (if necessary)
