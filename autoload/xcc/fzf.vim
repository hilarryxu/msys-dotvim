function! s:open_file(...) abort
  let root = getcwd()

  if has('nvim')
  else
    call term_wait(b:term_buf, 200)
  endif

  let full_path = root . '/' . getline(1)
  silent close

  if filereadable(full_path)
    while &buftype !=# ''
      execute 'wincmd w'
    endwhile
    execute 'edit ' . full_path
  endif
endfunction

function! xcc#fzf#files() abort
  keepalt bo 9 new

  let root = xcc#util#findroot#get()
  if root !=# '.'
    execute 'lcd ' . root
  endif

  " let cmd = 'rg --files --path-separator / | fzf'
  let cmd = 'rg --files | fzf'
  if has('nvim')
    let b:term_buf = termopen([&shell, &shellcmdflag, cmd], {
          \ 'on_exit': function('s:open_file')
          \ })
  else
    let b:term_buf = term_start([&shell, &shellcmdflag, cmd], {
          \ 'term_name': 'FILES',
          \ 'curwin': 1,
          \ 'exit_cb': function('s:open_file')
          \ })
  endif
endfunction
