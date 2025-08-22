source ~/.zoxide.nu

def git-housekeeping [] {
  git fetch
  git branch --merged 
    | lines 
    | where ($it != "* master" and $it != "* main") 
    | each {|br| git branch -D ($br | str trim) } 
    | str trim
  git remote prune origin
  git branch -vv 
    | detect columns --no-headers
    | rename branch _ remote
    | select branch remote
    | where ($it.branch != "master" and $it.branch != "main") 
    | update remote { split column ": " | default null column2 | get column2 } 
    | flatten 
    | where remote != null
    | each {|row| git branch -D ($row.branch | str trim) } 
    | str trim

}
