" Vim color file
" Name: darkblossom256
" Maintainer: Gerard Flanagan
" Last Change: 2015-12-10
"
" This color file is a modification of the "summerfruit256" color scheme by
" Martin Baeuml, itself a 256 color version of Armin Ronacher's original
" "summerfruit" scheme. The colors are translated using Henry So's programmatic
" approximation of gui colors from his "desert256" color scheme.
"
" The summerfruit256 scheme can be found on github:
"
"     https://github.com/baeuml/summerfruit256.vim
"

set background=light
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="darkblossom256"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
    " functions {{{
    " returns an approximate grey index for the given grey level
    fun <SID>grey_number(x)
        if &t_Co == 88
            if a:x < 23
                return 0
            elseif a:x < 69
                return 1
            elseif a:x < 103
                return 2
            elseif a:x < 127
                return 3
            elseif a:x < 150
                return 4
            elseif a:x < 173
                return 5
            elseif a:x < 196
                return 6
            elseif a:x < 219
                return 7
            elseif a:x < 243
                return 8
            else
                return 9
            endif
        else
            if a:x < 14
                return 0
            else
                let l:n = (a:x - 8) / 10
                let l:m = (a:x - 8) % 10
                if l:m < 5
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual grey level represented by the grey index
    fun <SID>grey_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 46
            elseif a:n == 2
                return 92
            elseif a:n == 3
                return 115
            elseif a:n == 4
                return 139
            elseif a:n == 5
                return 162
            elseif a:n == 6
                return 185
            elseif a:n == 7
                return 208
            elseif a:n == 8
                return 231
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 8 + (a:n * 10)
            endif
        endif
    endfun

    " returns the palette index for the given grey index
    fun <SID>grey_color(n)
        if &t_Co == 88
            if a:n == 0
                return 16
            elseif a:n == 9
                return 79
            else
                return 79 + a:n
            endif
        else
            if a:n == 0
                return 16
            elseif a:n == 25
                return 231
            else
                return 231 + a:n
            endif
        endif
    endfun

    " returns an approximate color index for the given color level
    fun <SID>rgb_number(x)
        if &t_Co == 88
            if a:x < 69
                return 0
            elseif a:x < 172
                return 1
            elseif a:x < 230
                return 2
            else
                return 3
            endif
        else
            if a:x < 75
                return 0
            else
                let l:n = (a:x - 55) / 40
                let l:m = (a:x - 55) % 40
                if l:m < 20
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual color level for the given color index
    fun <SID>rgb_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 139
            elseif a:n == 2
                return 205
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 55 + (a:n * 40)
            endif
        endif
    endfun

    " returns the palette index for the given R/G/B color indices
    fun <SID>rgb_color(x, y, z)
        if &t_Co == 88
            return 16 + (a:x * 16) + (a:y * 4) + a:z
        else
            return 16 + (a:x * 36) + (a:y * 6) + a:z
        endif
    endfun

    " returns the palette index to approximate the given R/G/B color levels
    fun <SID>color(r, g, b)
        " get the closest grey
        let l:gx = <SID>grey_number(a:r)
        let l:gy = <SID>grey_number(a:g)
        let l:gz = <SID>grey_number(a:b)

        " get the closest color
        let l:x = <SID>rgb_number(a:r)
        let l:y = <SID>rgb_number(a:g)
        let l:z = <SID>rgb_number(a:b)

        if l:gx == l:gy && l:gy == l:gz
            " there are two possibilities
            let l:dgr = <SID>grey_level(l:gx) - a:r
            let l:dgg = <SID>grey_level(l:gy) - a:g
            let l:dgb = <SID>grey_level(l:gz) - a:b
            let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
            let l:dr = <SID>rgb_level(l:gx) - a:r
            let l:dg = <SID>rgb_level(l:gy) - a:g
            let l:db = <SID>rgb_level(l:gz) - a:b
            let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
            if l:dgrey < l:drgb
                " use the grey
                return <SID>grey_color(l:gx)
            else
                " use the color
                return <SID>rgb_color(l:x, l:y, l:z)
            endif
        else
            " only one possibility
            return <SID>rgb_color(l:x, l:y, l:z)
        endif
    endfun

    " returns the palette index to approximate the 'rrggbb' hex string
    fun <SID>rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return <SID>color(l:r, l:g, l:b)
    endfun

    " sets the highlighting for the given group
    fun <SID>X(group, fg, bg, attr)
        if a:fg != ""
            exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
        endif
        if a:bg != ""
            exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
        endif
        if a:attr != ""
            exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
        endif
    endfun
    " }}}

    " Global
    call <SID>X("Normal", "eeeeee", "000000", "")
    call <SID>X("NonText", "438ec3", "000000", "")

    " Search
    call <SID>X("Search", "800000", "ffae00", "")
    call <SID>X("IncSearch", "800000", "ffae00", "")

    " Interface Elements
    call <SID>X("StatusLine", "ffffff", "43c464", "bold")
    call <SID>X("StatusLineNC", "9bd4a9", "51b069", "")
    call <SID>X("VertSplit", "3687a2", "3687a2", "")
    call <SID>X("Folded", "3c78a2", "000000", "")
    call <SID>X("IncSearch", "708090", "f0e68c", "")
    call <SID>X("Pmenu", "ffffff", "cb2f27", "")
    call <SID>X("SignColumn", "", "000000", "")
    call <SID>X("CursorLine", "", "c0d9eb", "")
    call <SID>X("LineNr", "9c9c9c", "000000", "")
    call <SID>X("MatchParen", "000000", "dddd33", "")

    " Specials
    call <SID>X("Todo", "e50808", "dbf3cd", "bold")
    call <SID>X("Title", "22bb22", "", "")
    call <SID>X("Special", "fd8900", "", "")

    " Syntax Elements
    call <SID>X("String", "0086d2", "", "")
    call <SID>X("Constant", "0086d2", "", "")
    call <SID>X("Number", "0086f7", "", "")
    call <SID>X("Statement", "cb6d8c", "", "bold")
    call <SID>X("Function", "00bb00", "", "bold")
    call <SID>X("PreProc", "ff0007", "", "")
    call <SID>X("Comment", "ff3300", "000000", "")
    call <SID>X("Type", "70796b", "", "")
    call <SID>X("Error", "ffffff", "d40000", "")
    call <SID>X("Identifier", "ff0086", "", "")
    call <SID>X("Label", "ff0086", "", "")

    " Python Highlighting
    call <SID>X("pythonCoding", "ff0086", "", "")
    call <SID>X("pythonRun", "ff0086", "", "")
    call <SID>X("pythonBuiltinObj", "2b6ba2", "", "")
    call <SID>X("pythonBuiltinFunc", "009900", "", "")
    call <SID>X("pythonException", "cb6d8c", "", "bold")
    call <SID>X("pythonExClass", "ff0086", "", "")
    call <SID>X("pythonSpaceError", "", "", "")
    call <SID>X("pythonDocTest", "2f9f49", "", "")
    call <SID>X("pythonDocTest2", "3b916a", "", "")
    "call <SID>X("pythonFunction", "000000", "b1fb7f", "bold")
    "call <SID>X("pythonFunction", "7e314b", "b0da9a", "bold")
    "call <SID>X("pythonFunction", "314b7e", "d4e9c7", "bold")
    "call <SID>X("pythonFunction", "000000", "f3e5ec", "bold")
    "call <SID>X("pythonFunction", "000000", "cbeebe", "bold")
    call <SID>X("pythonFunction", "ffffff", "009900", "bold")
    call <SID>X("pythonClass", "ff0086", "", "")
    call <SID>X("pythonDecorator", "ff0000", "", "")
    call <SID>X("pythonDottedName", "ff0000", "", "")
    call <SID>X("pythonComment", "ff3300", "000000", "")

    " HTML Highlighting
    call <SID>X("htmlTag", "00bdec", "", "")
    call <SID>X("htmlEndTag", "00bdec", "", "")
    call <SID>X("htmlSpecialTagName", "4aa04a", "", "")
    call <SID>X("htmlTagName", "4aa04a", "", "")
    call <SID>X("htmlTagN", "4aa04a", "", "")

    " Jinja Highlighting
    call <SID>X("jinjaTagBlock", "ff0007", "fbf4c7", "bold")
    call <SID>X("jinjaVarBlock", "ff0007", "fbf4c7", "")
    call <SID>X("jinjaString", "0086d2", "fbf4c7", "")
    call <SID>X("jinjaNumber", "bf0945", "fbf4c7", "bold")
    call <SID>X("jinjaStatement", "fb660a", "fbf4c7", "bold")
    call <SID>X("jinjaComment", "008800", "002300", "italic")
    call <SID>X("jinjaFilter", "ff0086", "fbf4c7", "")
    call <SID>X("jinjaRaw", "aaaaaa", "fbf4c7", "")
    call <SID>X("jinjaOperator", "ffffff", "fbf4c7", "")
    call <SID>X("jinjaVariable", "92cd35", "fbf4c7", "")
    call <SID>X("jinjaAttribute", "dd7700", "fbf4c7", "")
    call <SID>X("jinjaSpecial", "008ffd", "fbf4c7", "")

    " delete functions {{{
    delf <SID>X
    delf <SID>rgb
    delf <SID>color
    delf <SID>rgb_color
    delf <SID>rgb_level
    delf <SID>rgb_number
    delf <SID>grey_color
    delf <SID>grey_level
    delf <SID>grey_number
    " }}}
endif

" vim: set fdl=0 fdm=marker:

