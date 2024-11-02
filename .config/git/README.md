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

# Git and Related Tools

## Core Version Control

### [dev-vcs/git](https://wiki.gentoo.org/wiki/Git)
The industry-standard distributed version control system that efficiently handles projects of all sizes with speed and data integrity.

### [dev-vcs/git-lfs](https://wiki.gentoo.org/wiki/Git-lfs)
Git Large File Storage (LFS) replaces large files with text pointers while storing the file contents on a remote server, optimizing repository size and performance.

## GitHub Integration

### [dev-vcs/hub](https://github.com/github/hub)
A command-line wrapper that extends Git with GitHub-specific features, making it easier to work with GitHub repositories.

### [dev-util/github-cli](https://cli.github.com)
GitHub's official command-line tool that brings pull requests, issues, and other GitHub concepts to the terminal.

## Terminal Interfaces

### [dev-vcs/lazygit](https://github.com/jesseduffield/lazygit)
A simple terminal UI for Git commands, featuring intuitive keyboard shortcuts and real-time updates.

### [dev-vcs/tig](https://github.com/jonas/tig)
Text-mode interface for Git that serves as a repository browser, offering a more visual way to explore Git history.

### [extrawurst/gitui](https://github.com/extrawurst/gitui)
Fast and efficient terminal interface written in Rust, providing a modern UI for common Git operations.

## Workflow Tools

### [dev-vcs/git-flow](https://github.com/nvie/gitflow)
A collection of Git extensions implementing Vincent Driessen's branching model for structured release management.

### [dev-vcs/git-crypt](https://www.agwa.name/projects/git-crypt)
Transparent file encryption in Git, allowing secure storage of sensitive files within a public repository.

## Enhancement Tools

### [dev-util/git-delta](https://github.com/dandavison/delta)
A syntax-highlighting pager for Git, offering improved diff output with features like side-by-side view and line numbering.

### [git-cliff](https://github.com/orhun/git-cliff)
A highly customizable changelog generator that creates structured release notes from Git history.

## Graphical Interfaces

### [dev-vcs/git-cola](https://git-cola.github.io)
A sleek and powerful Git GUI client built with Qt, offering comprehensive repository management features.

### [dev-vcs/gitg](https://wiki.gnome.org/Apps/Gitg)
A GNOME-native Git repository viewer with clean visualization of branches and commit history.

### [dev-vcs/qgit](https://github.com/tibirna/qgit)
A Qt-based Git GUI viewer focused on simplicity and efficiency for quick repository interactions.

## Integration and Management

### [ghq](https://github.com/x-motemen/ghq)
A repository management tool that provides a consistent way to organize multiple repositories across different version control platforms.

### [app-vim/fugitive](https://github.com/tpope/vim-fugitive)
A powerful Git wrapper for Vim that enables seamless Git operations without leaving the editor.






