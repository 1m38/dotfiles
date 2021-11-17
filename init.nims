import system
import std/os
import std/strformat
import std/tables

mode = ScriptMode.Verbose

proc home(): string =
  ## returns user's home directory path
  let user_name = gorgeEx("whoami").output
  return &"/home/{user_name}"

proc add_simple_link(symlinks: var OrderedTable[string, string], path: string) =
  ## register to create a symlink from projectDir()/path to ~/path
  symlinks[path] = joinPath(home(), path)

proc main() =
  cd projectDir()

  # symlinks[src_path] = dst_path
  # src_path: relative path from projectDir()
  # dst_path: absolute path
  var symlinks = initOrderedTable[string, string]()
  symlinks["sshconfig"] = joinPath(home(), ".ssh/config")
  symlinks.add_simple_link(".gitconfig")
  symlinks.add_simple_link(".zshrc")

  for src, dst in symlinks.pairs:
    if dirExists(parentDir dst):
      exec &"ln -sf {projectDir()}/{src} {dst}"

main()
