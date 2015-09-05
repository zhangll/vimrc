function! Foo()
python << EOF

def _format():
    import json
    import vim
    print 'hh'
    vim.current.buffer = 'this is a test'

EOF
endfunction

command -nargs=0 Format :python _format()

