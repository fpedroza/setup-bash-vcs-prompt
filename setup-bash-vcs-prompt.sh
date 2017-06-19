
_parse_git_branch() {
	# look into using /usr/local/etc/bash_completion.d/git-prompt.sh
  #git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)#(git::\1)#'

  branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  [ ! -z $branch ] && echo "(git::$branch)"
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
  #_parse_git_branch || _parse_svn_branch
  _parse_git_branch || _svn_prompt
}

# from https://gist.github.com/brettstimmerman/382508
# Returns (svn:<revision>:<branch|tag>[*]) if applicable
_svn_prompt() {
    if [ -d ".svn" ]; then
        local branch dirty rev info=$(svn info 2>/dev/null)
        
        branch=$(_svn_parse_branch "$info")
        
        # Uncomment if you want to display the current revision.
        #rev=$(echo "$info" | awk '/^Revision: [0-9]+/{print $2}')
        
        # Uncomment if you want to display whether the repo is 'dirty.' In some
        # cases (on large repos) this may take a few seconds, which can
        # noticeably delay your prompt after a command executes.
        #[ "$(svn status)" ] && dirty='*'
        
        if [ "$branch" != "" ] ; then
           echo "(svn::$rev:$branch$dirty)"
        fi
    fi
}

# from https://gist.github.com/brettstimmerman/382508
# Returns the current branch or tag name from the given `svn info` output
_svn_parse_branch() {
    local chunk url=$(echo "$1" | awk '/^URL: .*/{print $2}')
    
    echo $url | grep -q "/trunk\b"
    if [ $? -eq 0 ] ; then
        echo trunk
        return
    else
        chunk=$(echo $url | grep -o "/releases.*")
        if [ "$chunk" == "" ] ; then
            chunk=$(echo $url | grep -o "/branches.*")
            if [ "$chunk" == "" ] ; then
                chunk=$(echo $url | grep -o "/tags.*")
            fi
        fi
    fi
    
    echo $chunk | awk -F/ '{print $3}'
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

# user@host:(git_branch) workingDir >
export PS1="\[$BPurple\]\u\[$Purple\]@\[$BPurple\]\h:\[$BBlue\]\$(_get_vcs_branch) \[$BGreen\]\w\[$Color_Off\] > "
