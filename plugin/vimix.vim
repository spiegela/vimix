if exists("g:loaded_vimix") || &cp
  finish
endif
let g:loaded_vimix = 1

if !exists('g:vimix_map_keys')
  let g:vimix_map_keys = 0
endif

function! s:VimixFindMixRoot(dir)
  let dir = a:dir
  while ! filereadable(dir.'/mix.exs')
    if dir == '/'
      return 0
      call s:error("mix.exs file not found in project")
    else
      let dir = simplify(resolve(dir).'/..')
    endif
  endwhile
  return dir
endfunction

if !exists('g:vimix_mix_root')
  let g:vimix_mix_root = s:VimixFindMixRoot(expand('%:p:h'))
endif

if g:vimix_map_keys
  nnoremap <Leader>mT :call VimixTestAll()<CR>
  nnoremap <Leader>mt :call VimixTestCurrentFile()<CR>
  nnoremap <Leader>mc :call VimixCompile()<CR>
  nnoremap <Leader>mC :call VimixClean()<CR>
  nnoremap <Leader>mdc :call VimixDepsCompile()<CR>
  nnoremap <Leader>mdg :call VimixDepsGet()<CR>
  nnoremap <Leader>mds :call VimixDepsStatus()<CR>
  nnoremap <Leader>mdU :call VimixDepsUpdate()<CR>
  nnoremap <Leader>mL :call VimixLocal()<CR>
  nnoremap <Leader>mr :call VimixlocalCommand()<CR>
endif

function VimixTestAll()
  call s:VimixRunCommand("test")
endfunction

function VimixTestCurrentFile()
  let test_file = s:TestFor(expand('%:p'))
  echo test_file
  call s:VimixRunCommand("test ".test_file)
endfunction

function VimixClean()
  call s:VimixRunCommand("clean")
endfunction

function VimixCompile()
  call s:VimixRunCommand("compile")
endfunction

function VimixDepsStatus()
  call s:VimixRunCommand("deps")
endfunction

function VimixDepsClean()
  call s:VimixRunCommand("deps.clean")
endfunction

function VimixDepsCompile()
  call s:VimixRunCommand("deps.compile")
endfunction

function VimixDepsGet()
  call s:VimixRunCommand("deps.get")
endfunction

function VimixDepsUpdate()
  call s:VimixRunCommand("deps.update --all")
endfunction

function VimixLocal()
  call s:VimixRunCommand("local")
endfunction

function VimixPromptCommand()
  let l:command = input(_VimuxOption("g:VimixPromptString", "Mix Command? "))
  call s:VimixRunCommand(l:command)
endfunction

function s:TestFor(file)
  if a:file =~# '_test.exs$'
    "We're already in a test
    return a:file
  elseif a:file =~# g:vimix_mix_root.'/lib/'
    "Let's see if there's a test for this file
    let l:file = substitute(a:file, g:vimix_mix_root.'/lib/', g:vimix_mix_root.'/test/', "")
    let l:file = fnamemodify(l:file, ':r')."_test.exs"
    return l:file
  else
    call s:error("can't find a test for ".a:file)
  endif
endfunction

function s:VimixRunCommand(command)
  "Make sure that we're in the mix root
  if !exists('g:vimix_in_mix_root')
    call VimuxRunCommand("cd ". g:vimix_mix_root)
    let g:vimix_in_mix_root = 1
  endif
  call VimuxRunCommand("mix " . a:command)
endfunction

function! s:error(str)
  echohl ErrorMsg
  echomsg a:str
  echohl None
  let v:errmsg = a:str
endfunction
