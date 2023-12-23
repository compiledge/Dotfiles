# ⚙️  Dotfiles

A personal collection of config files to some tools like neovim, awesomewm and others.
Besides the files, this repository show the main tools used and how to install
these configurations.

P.S. I have used many sources and snippets for this collection, so this collection
is not an original project. Thanks to the FOSS comunity!

<!-- ## 🕶️ Showcase -->
## 📦 Installation

The installation of the configurations is based on syslinks, i.e.,
the original project files are mirrored by links to each config directory.
To do this, this project uses the GNU Stow tool (therefore, this is the
only dependence in the installation process).

To install the files (syslinks) in the config directories, try:

```bash
make install
```

To remove all the configurations installed:

```bash
make uninstall
```

To reinstall the syslinks:

```bash
make reinstall
```
