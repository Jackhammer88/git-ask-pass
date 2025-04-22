# git-ask-pass (Go + Fyne)

| A custom GIT_ASKPASS GUI tool that doesn't hide your username — because you're not typing a password there.

## 🧠 Why?
Most default askpass implementations hide both the username and password behind asterisks. That's silly.

This tool:
- shows the username field in plain text (as it should be),
- hides only the password,
- and presents a clean, native-looking UI using the Fyne toolkit.
  
Ideal for developers who are tired of entering long usernames or tokens blindly.

## 📦 Installation
```bash
cd pkg
cp [path to the binary] ./
./install.sh
source ~/.bashrc  # or restart your shell
```

If you're using zsh or another shell, make sure to export GIT_ASKPASS manually in your shell config:
```bash
export GIT_ASKPASS="$HOME/.local/bin/git-ask-pass"
```

## 🔧 Uninstallation
```bash
cd pkg
uninstall.sh
```

## 🛠 Requirements

### If you want to compile it yourself
- Go 1.24.1+ to build
- make
- git
- [Fyne framework](https://docs.fyne.io/started/) dependencies
- upx for binary compression (Optional)

```bash
make
upx --best --lzma ./build/git-ask-pass
```
  
### If you want to use precompiled binary
Install manually:
- Download the binary
- Place it anywhere (e.g., ~/.local/bin/)
- Export the GIT_ASKPASS variable:
  ```bash
  export GIT_ASKPASS="$HOME/.local/bin/git-ask-pass"
  ```
That's it — you're ready to go.

## System requirements
- Any modern GNU/Linux distro
- Git installed
- The following shared libraries (These are commonly pre-installed on most desktop Linux systems.):
  - libGL.so.1 (part of libgl1/mesa | mesa)
  - libGLdispatch.so.0 (part of libgl1/mesa | mesa)
  - libGLX.so.0 (part of libgl1/mesa | mesa)
  - libX11.so.6
  - libxcb.so.1
  - libXau.so.6
  - libXdmcp.so.6
  - libbsd.so.0
  - libmd.so.0
  - libm.so.6, libc.so.6, ld-linux-x86-64.so.2 (part of libc6 | glibc)
 
## 📄 License
MIT — free to use, modify, share, complain about, and ignore responsibly.
