# dotfiles

Repository for my personal dotfiles.

## Codespaces support

GitHub Codespaces automatically runs `install.sh` from this repository when configured as your dotfiles repo.

The script currently:
- links top-level dotfiles from this repo into `$HOME`
- skips repository/control files (like `.git`, `.github`, and installer entrypoints)
- backs up pre-existing files before creating symlinks

## Local usage

Run manually with:

```bash
./install.sh
```
