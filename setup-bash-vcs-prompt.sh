
_parse_git_branch() {
  git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)#(git::\1)#'
}
_parse_svn_branch() {
  _parse_svn_url | sed -e 's#^'"$(_parse_svn_repository_root)"'##g' | awk '{print "(svn::"$1")" }'
}
_parse_svn_url() {
  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
_parse_svn_repository_root() {
  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}
_get_vcs_branch() {
  _parse_git_branch
  _parse_svn_branch
}

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

export PS1="\[$BPurple\]\u\[$Purple\]@\[$BPurple\]\h:\[$BBlue\]\$(_get_vcs_branch) \[$BGreen\]\w\[$Color_Off\] > "
