# ╭─────────────╥──────────────────╮
# │ Author:     ║ File:            │
# │ Andrey Orst ║ common.kak       │
# ╞═════════════╩══════════════════╡
# │ Common settings for Kakoune    │
# ╞════════════════════════════════╡
# │ Rest of .dotfiles:             │
# │ GitHub.com/andreyorst/dotfiles │
# ╰────────────────────────────────╯

# Common options
set-option global scrolloff 3,3
evaluate-commands %sh{
    [ ! -z $(command -v rg) ] && echo "set-option global grepcmd 'rg -L --with-filename --column'"
}
set-option global tabstop 4
set-option global indentwidth 4

# UI
colorscheme base16-guvbox-dark-soft
set-option global modelinefmt %sh{
    blue="rgb:83a598"
    black="rgb:32302f"
    purple="rgb:d3869b"
    echo "{$blue}{$black,$blue+b} %val{bufname}{{context_info}} {$blue,$black} {{mode_info}} {$blue+b} {$blue+b}%val{cursor_line}{default+b}:{$blue+b}{$blue+b}%val{cursor_char_column} {$blue}{$black,$blue+b} %opt{filetype} {$black,$blue}{default,default} {$purple,default}%val{client} {$blue}{$black,$blue+b} %val{session} "
}

# Highlighters
hook global KakBegin .* %{
    add-highlighter global/numbers number-lines -relative -hlcursor -separator '  '
    add-highlighter global/matching show-matching
    add-highlighter global/whitespace show-whitespaces -tab "▏" -lf " " -nbsp "⋅" -spc " "
    add-highlighter global/wrap wrap -word -indent -marker ↪
}

# Maps
map global normal ''     ': comment-line<ret>'               -docstring "<c-/> to comment/uncomment selection"
map global normal '<c-r>' 'U'                                 -docstring "vim-like redo"
map global goto   '<a-f>' '<esc><a-i><a-w>gf'                 -docstring "file non-recursive"
map global goto   'f'     '<esc>: smart-gf<ret>'              -docstring "file recursive"
map global goto   'b'     '<esc>:bn<ret>'                     -docstring "next buffer"
map global goto   'B'     '<esc>:bp<ret>'                     -docstring "previous buffer"
map global normal '<c-d>' ': select-or-add-cursor<ret>'       -docstring "add currsor on current word, and jump to the next match"
map global user   't'     ': leading-spaces-to-tabs<ret>'     -docstring "convert leading spaces to tabs"
map global user   'T'     ': leading-tabs-to-spaces<ret>'     -docstring "convert leading tabs to spaces"
map global user   'p'     ': toggle-statusline-position<ret>' -docstring "change statusline position to another side of the screen"

# Hooks
hook global InsertCompletionShow .* %{ map   window insert <tab> <c-n>; map   window insert <s-tab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }
hook global BufOpenFile .* editorconfig-load
hook global BufNewFile  .* editorconfig-load

# Aliases
alias global h doc
