# Homebrew formula template for the mailypoppins tap (ticket #0013).
#
# Rendered by scripts/update-homebrew-formula.sh, which fills the version
# and sha256 placeholders from a tagged GitHub release; the result is
# pushed to the tap repository (sylvainHellin/homebrew-mailypoppins) by the
# `homebrew-tap` job in .github/workflows/release.yml.
#
# The formula installs prebuilt release binaries instead of building from
# source, so the (eventually signed, see ticket #0012) macOS artifact keeps
# its signature. Linux uses the static musl build (no runtime deps).
class Mailypoppins < Formula
  desc "Manage email as Markdown files with YAML frontmatter (CLI + TUI)"
  homepage "https://mailypoppins.dev"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/sylvainHellin/mailypoppins/releases/download/v#{version}/mailypoppins-aarch64-apple-darwin.tar.gz"
      sha256 "6edad9ebdc23f283654cd9808ff99cddcf0fde3809a11c8b0fe74d513e58191b"
    end
    on_intel do
      url "https://github.com/sylvainHellin/mailypoppins/releases/download/v#{version}/mailypoppins-x86_64-apple-darwin.tar.gz"
      sha256 "422472ab7eed8c5028c5189f322b5d9f0691fa3e8fa5b6911b2a44554b4fa254"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/sylvainHellin/mailypoppins/releases/download/v#{version}/mailypoppins-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4dfb290504d9eddfb6ab70e92835afd9a55f93d4084f78ebe7479cd842469be2"
    end
  end

  def install
    bin.install "mp"
  end

  test do
    assert_match "mailypoppins", shell_output("#{bin}/mp --version")
  end
end
