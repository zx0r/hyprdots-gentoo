# Rust Commands Abbreviations

# Cargo Basic Commands
abbr -a cr 'cargo run'
abbr -a cb 'cargo build'
abbr -a ct 'cargo test'

abbr -a carc 'cargo clean'
abbr -a caru 'cargo update'
abbr -a carch 'cargo check'
abbr -a carcl 'cargo clippy'
abbr -a card 'cargo doc'

abbr -a carbr 'cargo build --release'
abbr -a carrr 'cargo run --release'
abbr -a carws 'cargo workspace'
abbr -a carwsl 'cargo workspace list'
abbr -a carad 'cargo add'
abbr -a carrm 'cargo rm'
abbr -a carp 'cargo publish'
abbr -a carau 'cargo audit'
abbr -a cargen 'cargo generate --git'
abbr -a carfmt 'cargo fmt'

# Rustup Commands
abbr -a ru-update 'rustup update'
abbr -a ru-default 'rustup default'

# Helper function to create a new Rust project
function new_rust_project
    cargo new $argv[1] --bin && cd $argv[1]
end

# Helper function to search crates.io
function search_crates
    open "https://crates.io/search?q=$argv"
end

# Alias for opening Rust documentation
abbr -a rustdoc 'open https://doc.rust-lang.org'

# Alias for opening The Rust Programming Language book
abbr -a rustbook 'open https://doc.rust-lang.org/book/'

# Helper to update Rust toolchain and all installed components
function update_rust
    rustup update
    rustup self update
    cargo install-update -a
end

# Alias for running Rust programs with Valgrind (if installed)
abbr -a rvalgrind 'valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes'

# Helper to clean up target directory in all workspaces
function clean_rust_workspace
    find . -name target -type d -exec rm -rf {} +
    echo "Cleaned target directories in Rust workspace"
end
