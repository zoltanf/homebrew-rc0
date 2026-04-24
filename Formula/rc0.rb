# Homebrew formula template for rc0.
# The release workflow (release.yml) fills in the version and sha256 values
# and pushes this to the homebrew-rc0 tap repo.
#
# Live tap: https://github.com/zoltanf/homebrew-rc0
# Install:  brew install zoltanf/rc0/rc0

class Rc0 < Formula
  desc "Command line for RcodeZero DNS"
  homepage "https://github.com/zoltanf/rc0-cli"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-macos-arm64.tar.gz"
      sha256 "e6cae927cbb5ebcbbed7849039494384ecfe43cd1d62c0025b43dc56d25a7c60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-linux-arm64.tar.gz"
      sha256 "6a730ee2aa601b716f9946d748a6c910b4cfc4daf71f5e621b3db0a668a5d833"
    end
    on_intel do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-linux-x86_64.tar.gz"
      sha256 "dcbe8cf6ced8464adc294f36b48074c2b5b4bf2fff19a75bc8d90435fe4dc178"
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
