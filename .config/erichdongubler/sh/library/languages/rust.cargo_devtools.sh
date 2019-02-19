#! /bin/sh

if command -v rustup; then
	echo "\`rustup\` already installed, skipping installation"
else
	case "$(uname)" in
		MSYS_*)
			echo "Beginning interactive Rust environment installation wizard..."
			curl https://sh.rustup.rs -sSf | sh
			;;
		*)
			package_manager="$(detect-package-manager)"
			if [ -z "$package_manager" ]; then
				echo "No package management solution found for \`rustup\` -- exiting"
			fi
			echo "Using built-in package manager for \`rustup\`"
			$package_manager rustup
			rustup toolchain add stable
			;;
	esac
	rustup toolchain add nightly
fi

if command -v rustup; then
	echo "\`cargo-install-update\` already present, skipping installation"
else
	echo "Installing \`cargo-install-update\`..."
	cargo install cargo-update
fi

echo "Installing/updating Rust dev tools via \`cargo install-update\`..."
cargo install-update -i \
	cargo-clone \
	cargo-edit \
	cargo-release \
	cargo-script \
	cargo-tree \
	cargo-update \
	;
# cargo +nightly install-update -i \
# 	cargo-modules \
# 	;

# FIXME: This should be something more like
echo "Installing/updating \`cargo\`-powered dev tools via \`cargo install-update\`..."
cargo install-update -i \
	bat \
	hexyl \
	treeify \
	tokei \
	watchexec \
	;
# Packages to fix up:
	# Needs Windows support ()
	# sd \
