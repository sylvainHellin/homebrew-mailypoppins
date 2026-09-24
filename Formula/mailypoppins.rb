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
  version "0.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/sylvainHellin/mailypoppins/releases/download/v#{version}/mailypoppins-aarch64-apple-darwin.tar.gz"
      sha256 "747cb95e4bf70d9a56524faf9d86bd5451b3df86da10c7bec262bd3c201cc644"
    end
    on_intel do
      url "https://github.com/sylvainHellin/mailypoppins/releases/download/v#{version}/mailypoppins-x86_64-apple-darwin.tar.gz"
      sha256 "ee62d6ccfb9f78886b1d4376ac91bb04114e3b9af35adb32421cc7866ca324a2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/sylvainHellin/mailypoppins/releases/download/v#{version}/mailypoppins-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0e702dc4f7bb67e1402b1999b54534a75f5157f796a504802cf27e87389ca561"
    end
  end

  def install
    bin.install "mp"
  end

  test do
    assert_match "mailypoppins", shell_output("#{bin}/mp --version")
  end
end
