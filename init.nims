import system
import std/os
import std/strformat
import std/tables

proc echo_exec(cmd: string) =
  echo &"exec: {cmd}"
  exec cmd

proc main() =
  cd projectDir()

  let
    user_name = gorgeEx("whoami").output
    home = &"/home/{user_name}"

  # symlinks[src_path] = dst_path
  # src_path: relative path from projectDir()
  # dst_path: absolute path
  var symlinks = initTable[string, string]()
  symlinks["sshconfig"] = joinPath(home, ".ssh/config")
  symlinks[".gitconfig"] = joinPath(home, ".gitconfig")

  for src, dst in symlinks.pairs:
    if dirExists(parentDir dst):
      echo_exec &"ln -sf {projectDir()}/{src} {dst}"

main()
