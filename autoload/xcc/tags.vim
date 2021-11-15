" noremap <F3> :AsyncRun -cwd=<root> ctags -R --sort=foldcase --extra=+fq --fields=+iaS --exclude=build<CR>

fun! xcc#tags#alt_file() abort
  execute 'tjump' '/^'.expand('%:t:r') .. '\.\(' .. join(get(
        \ {
        \ 'c':   ['h'],
        \ 'cpp': ['h','hpp'],
        \ 'h':   ['c','cpp'],
        \ 'hpp': ['cpp'],
        \ 'vim': ['vim']
        \ },
        \  expand('%:e'), ['UNKNOWN EXTENSION']), '\\|')  ..  '\)$'
endf
