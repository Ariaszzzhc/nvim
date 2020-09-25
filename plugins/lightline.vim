let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste', 'coc_errors', 'coc_warnings', 'coc_ok' ],
  \             [ 'cocstatus', 'branch', 'diagnostic', 'readonly', 'filename', 'modified', 'method' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'method': 'NearestMethodOrFunction',
  \   'branch': 'gitbranch#name',
  \   'filetype': 'FiletypeWithIcon',
  \   'fileformat': 'FileformatWithIcon',
  \   'diagnostic': 'CocDiagnostic'
  \ },
  \ }


function! FiletypeWithIcon()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! FileformatWithIcon()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

let g:lightline#coc#indicator_warnings = ''
let g:lightline#coc#indicator_errors = ''
let g:lightline#coc#indicator_ok = '﫟'

call lightline#coc#register()
