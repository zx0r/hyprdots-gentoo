## Git for Gentoo Linux with Fish Shell

- [Gentoo Git Guide](https://wiki.gentoo.org/wiki/Git)
- [GitHub Hub](https://hub.github.com/)
- [Lazygit](https://github.com/jesseduffield/lazygit)

## installation

```fish
# Git USE Flags Reference
echo 'dev-vcs/git blksha1 curl gpg iconv nls pcre perl safe-directory webdav doc highlight keyring selinux test tk' >> /etc/portage/package.use/git

# Install git
root $ emerge --sync
root $ emerge --ask dev-vcs/git dev-vcs/hub github-cli
```

```fish
#The guru overlay is a community-driven overlay with a variety of packages contributed by Gentoo users
root $ emerge --ask app-eselect/eselect-repository
root $ eselect repository enable guru
root $ emaint sync -r guru
root $ emerge --sync

# Install packages
root $ emerge --ask dev-vcs/tig
root $ emerge --ask dev-vcs/lazygit
root $ emerge --ask dev-vcs/gitui
root $ emerge --ask dev-vcs/git-flow
root $ emerge --ask dev-vcs/git-lfs
root $ emerge --ask dev-vcs/git-crypt
root $ emerge --ask dev-util/git-delta
user $ go install github.com/x-motemen/ghq@latest
user $ cargo install --git https://github.com/orhun/git-cliff
user $ git lfs install --skip-repo
```

## Fish Shell Integration

```fish
# *** Only Fish shell Direct completion installation ***
user $ curl -sL https://raw.githubusercontent.com/fish-shell/fish-shell/3.7.1/share/completions/git.fish > ~/.config/fish/completions/git.fish
user $ fish_update_completions

# (Optional): Git aliases plugin for the Fish shell (similar to oh-my-zsh git)
user $ curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
user $ fisher install jhillyerd/plugin-git
```

## Configuration

```fish
# Set your identity
user $ git config --global user.name "Larry the cow"
user $ git config --global user.email "larry@gentoo.org"

# Privacy option - blank email
user $ git config --global user.email "<>"

# Create GitHub repository --remote=https (GitHub CLI)
user $ gh repo create "my-project" --confirm --public --remote=https --description "🕊 Hello World"
user $ git remote add origin https://github.com/zx0r/my-project.git
user $ git remote -v

# Create GitHub repository --remote=ssh (GitHub CLI)
user $ gh repo create "my-project" --confirm --public --remote=ssh --description "🕊 Hello World"
user $ git remote add origin git@github.com:zx0r/my-project.git
user $ git remote -v

# Create project directory
user $ cd $HOME
user $ mkdir my-project && cd my-project

# Create initial content
user $ touch README.md
user $ echo "Hello, world!" >> README.md

# Initialize and commit
user $ git init
user $ git add $HOME/my-project/README.md # ... add other files
user $ git commit -m "Initial commit: Added README.md"
user $ git push -u origin main
```

## Command Line Tools
Each tool enhances your Git workflow in unique ways, from GUI interfaces to specialized management tools. The linked documentation provides detailed usage instructions and best practices.

**[dev-vcs/hub](https://github.com/github/hub)**:
  - GitHub wrapper
  - Extended GitHub integration

**[dev-util/github-cli](https://cli.github.com)**:
  - Official GitHub CLI 
  - Modern GitHub workflow

**[dev-vcs/lazygit](https://github.com/jesseduffield/lazygit)**:
  - Terminal UI
  - Interactive Git operations

**[dev-vcs/tig](https://github.com/jonas/tig)**:
  - Text interface
  - Repository browsing

**[dev-vcs/git-lfs](https://wiki.gentoo.org/wiki/Git-lfs)**:
  - Large file support
  - Manage large files in Git

**[dev-vcs/git-flow](https://github.com/nvie/gitflow)**:
  - Branching model
  - Simplified Git workflows

**[dev-vcs/git-crypt](https://www.agwa.name/projects/git-crypt)**:
  - Git encryption
  - Transparent encryption of files in a Git repository

## Enhancement Tools

**[dev-util/git-delta](https://github.com/dandavison/delta)**:
  - Syntax highlighting pager
  - Beautiful diffs for improved readability

**[git-cliff](https://github.com/orhun/git-cliff)**:
  - Changelog generator
  - Automated release notes generation based on commit messages

## Visual Tools

**[dev-vcs/git-cola](https://git-cola.github.io)**:
  - Modern Git GUI
  - Qt-based interface for easy Git operations

**[dev-vcs/gitg](https://wiki.gnome.org/Apps/Gitg)**:
  - GNOME Git viewer
  - GTK integration for a native look and feel

**[dev-vcs/qgit](https://github.com/tibirna/qgit)**:
  - Qt Git interface
  - Lightweight operations for quick Git tasks

## Integration Tools

**[ghq](https://github.com/x-motemen/ghq)**:
  - Repo management
  - Multi-platform tool for organized repositories

**[app-vim/fugitive](https://github.com/tpope/vim-fugitive)**:
  - Vim Git wrapper
  - Seamless integration with Vim for Git operations

**[extrawurst/gitui](https://github.com/extrawurst/gitui)**:
  - Blazing 💥 fast terminal-ui for git written in rust 🦀







