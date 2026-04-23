# Homebrew formula template for rc0.
# The release workflow (release.yml) fills in the version and sha256 values
# and pushes this to the homebrew-rc0 tap repo.
#
# Live tap: https://github.com/zoltanf/homebrew-rc0
# Install:  brew install zoltanf/rc0/rc0

class Rc0 < Formula
  desc "Command line for RcodeZero DNS"
  homepage "https://github.com/zoltanf/rc0-cli"
  version "1.0.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-macos-arm64.tar.gz"
      sha256 "da868d0d677d83cf1c310b8ba43708f5f0f014113a5677e0800d9f07e6905c0c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-linux-arm64.tar.gz"
      sha256 "bb253514e64f3d9ea250da56a9bda5b69ae7c4a97b48c126b55629ff3ea5bd6e"
    end
    on_intel do
      url "https://github.com/zoltanf/rc0-cli/releases/download/v#{version}/rc0-#{version}-linux-x86_64.tar.gz"
      sha256 "6408b3524de1d8690d6aa624b5f83d514066c95c8fdfd87b558072dd322ad2e5"
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
