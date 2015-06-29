# setup-bash-vcs-prompt
Customize and colorize your bash prompt to include any version control info along with other common info.

Resulting prompt format is: "`<user>@<host>:(<vcs-info>) <working-directory> > `"

**Note:** "`(<vcs-info>)`" is only included when the `<working-directory>` is connected to a VCS.

Example prompts:
```
  # non vcs directory
  fpedroza@myMachine: ~/depot > 

  # git connected directory
  fpedroza@myMachine:(git::master) ~/depot/setup-bash-vcs-prompt > 

  # svn connected directory
  fpedroza@myMachine:(svn::/jig) ~/depot/jig > 
```

Thanks to http://hocuspokus.net/2009/07/add-git-and-svn-branch-to-bash-prompt for the jump start

# Installation Instructions
Simply soure the file `setup-bash-vcs-prompt.sh` in your bash setup.  For example, in my `.profile` file I have the following:
```
  source ~/depot/setup-bash-vcs-prompt/setup-bash-vcs-prompt.sh
```
