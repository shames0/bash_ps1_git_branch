# color vars
red=$'\e[31m'
green=$'\e[32m'
gold=$'\e[33m'
blue=$'\e[34m'
res=$'\e(B\e[m'

get_branch () {
    [ -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]          && return 1;
    cur_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    [ -z "${cur_branch}" ]                                         && return 1;
    git diff --quiet          2>&1 1>/dev/null || { br_color=$red  && return 0; }
    git diff --quiet --staged 2>&1 1>/dev/null || { br_color=$gold && return 0; }
                                                    br_color=$green
    return 0
}

PS1='\h:\W \u$( get_branch && printf "\[%s\](%s)\[$res\]" $br_color "$cur_branch" )\$ '
