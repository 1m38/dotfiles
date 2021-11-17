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

proc make_symlinks() =
  # symlinks[src_path] = dst_path
  # src_path: relative path from projectDir()
  # dst_path: absolute path
  var symlinks = initOrderedTable[string, string]()
  symlinks["sshconfig"] = joinPath(home(), ".ssh/config")
  symlinks.add_simple_link(".gitconfig")
  symlinks.add_simple_link(".zshrc")

  # make symlinks
  for src, dst in symlinks.pairs:
    if dirExists(parentDir dst):
      exec &"ln -sf {projectDir()}/{src} {dst}"

proc install_zplug() =
  let zplug_home = joinPath(home(), ".zplug")
  if not dirExists(zplug_home):
    exec &"git clone https://github.com/zplug/zplug {zplug_home}"
  else:
    echo "zplug seems already installed"

proc install_fzf() =
  let fzf_home = joinPath(home(), ".fzf")
  if not dirExists(fzf_home):
    exec &"git clone --depth 1 https://github.com/junegunn/fzf.git {fzf_home}"
    let install_cmd = joinPath(fzf_home, "install")
    exec install_cmd
  else:
    echo "fzf seems already installed"

proc main() =
  make_symlinks()
  install_zplug()
  install_fzf()

main()
