# Homebrew formula template for rc0.
# The release workflow (release.yml) fills in the version and sha256 values
# and pushes this to the homebrew-rc0 tap repo.
#
# Live tap: https://github.com/zoltanf/homebrew-rc0
# Install:  brew install zoltanf/rc0/rc0

class Rc0 < Formula
  desc "Command line for RcodeZero DNS"
  homepage "https://github.com/zoltanf/rc0-cli"
  version "1.0.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-macos-arm64.tar.gz"
      sha256 "71e6b5a35a51030f178dd1476a5e473e43a4a5b8621200a8cb7bf7be01d784d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-linux-arm64.tar.gz"
      sha256 "978011caec8d5733d34fdb22da04d90401452c66608e0e2324b34779ecaef819"
    end
    on_intel do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-linux-x86_64.tar.gz"
      sha256 "2e5cc9f8c3b21badb8345449d802ac361db2d92a0fbb29666412c64a00e66196"
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
