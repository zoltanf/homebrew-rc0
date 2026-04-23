# Homebrew formula template for rc0.
# The release workflow (release.yml) fills in the version and sha256 values
# and pushes this to the homebrew-rc0 tap repo.
#
# Live tap: https://github.com/zoltanf/homebrew-rc0
# Install:  brew install zoltanf/rc0/rc0

class Rc0 < Formula
  desc "Command line for RcodeZero DNS"
  homepage "https://github.com/zoltanf/rc0-cli"
  version "1.0.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-macos-arm64.tar.gz"
      sha256 "875d97de9f321897be629e160da4c5b5827cbddfe7333f330a139cea1d7c586b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-linux-arm64.tar.gz"
      sha256 "c6b196fea403fc94ecfefa5a8c26f911817bb52de80d3aa25be6b5679ed01e55"
    end
    on_intel do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-linux-x86_64.tar.gz"
      sha256 "bd7b03fd49a1ee555494ee3943552ca46242395585b73e63c9873d46907b8a9b"
    end
  end

  def install
    # rc0/ dir contains the launcher binary and _internal/ (bundled Python libs).
    # Install the directory tree to libexec and symlink the launcher into bin so
    # the binary can locate _internal/ via its real path at runtime.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"rc0"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rc0 --version")
  end
end
