# Homebrew formula template for the mailypoppins tap (ticket #0013).
#
# Rendered by scripts/update-homebrew-formula.sh, which fills the version
# and sha256 placeholders from a tagged GitHub release; the result is
# pushed to the tap repository (sylvainHellin/homebrew-mailypoppins) by the
# `homebrew-tap` job in .github/workflows/release.yml.
#
# The formula installs prebuilt release binaries instead of building from
# source, so the (eventually signed, see ticket #0012) macOS artifact keeps
# its signature. macOS is Apple silicon only (no Intel release build).
# Linux uses the static musl build (no runtime deps).
class Mailypoppins < Formula
  desc "Manage email as Markdown files with YAML frontmatter (CLI + TUI)"
  homepage "https://mailypoppins.dev"
  version "0.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/sylvainHellin/mailypoppins/releases/download/v#{version}/mailypoppins-aarch64-apple-darwin.tar.gz"
      sha256 "6b49915de4aabcc6b50c112da01160bc6822190e973e0c630aaf6507134743a6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/sylvainHellin/mailypoppins/releases/download/v#{version}/mailypoppins-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7c82df675ba757e2f64daa0336199cf00b9d67f6120cea9d16a2eff3ec4462ee"
    end
  end

  def install
    bin.install "mp"
  end

  test do
    assert_match "mailypoppins", shell_output("#{bin}/mp --version")
  end
end
