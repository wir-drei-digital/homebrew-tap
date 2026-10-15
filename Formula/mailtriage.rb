# Rendered from packaging/homebrew/mailtriage.rb.in by mailtriage's release
# workflow (wir-drei-digital/mailtriage); edit the template there.
class Mailtriage < Formula
  desc "Local email classification and attention queries for humans and agents"
  homepage "https://github.com/wir-drei-digital/mailtriage"
  # The macOS arm64 archive. `on_linux` replaces it, and Intel Macs stop at
  # `depends_on arch: :arm64`: `brew style` allows no `url` directly in
  # `on_macos`, and `brew tap` loads the formula for every system.
  url "https://github.com/wir-drei-digital/mailtriage/releases/download/v0.1.0/mailtriage-v0.1.0-macos-arm64.tar.gz"
  version "0.1.0"
  sha256 "3baca0da10efab4d14afb7f88ee9a87ce5d116eaa61d41694a00273574414e03"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    resource "tray" do
      url "https://github.com/wir-drei-digital/mailtriage/releases/download/v0.1.0/mailtriage-tray-v0.1.0-macos-arm64.tar.gz"
      sha256 "22090cfc244cafc3651666af6828e618609c7eb456d550d4b385d907c21fa643"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/wir-drei-digital/mailtriage/releases/download/v0.1.0/mailtriage-v0.1.0-linux-amd64.tar.gz"
      sha256 "eb1a60c53d0a9b5a0b924cee7fde67d6c997eb572d8e3714998526fa93734a0c"
    end
    on_arm do
      url "https://github.com/wir-drei-digital/mailtriage/releases/download/v0.1.0/mailtriage-v0.1.0-linux-arm64.tar.gz"
      sha256 "2f825f496b36f7817802fc8dbe7bb82fbbf21e32856149561fef27188ed37e9b"
    end
  end

  def install
    bin.install "mailtriage"
    resource("tray").stage { bin.install "mailtriage-tray" } if OS.mac?
  end

  def caveats
    <<~EOS
      Run `mailtriage setup`: it uses a tested Himalaya on your PATH or installs
      a private one for mailtriage.
      Updates come with `brew upgrade mailtriage`.
      On macOS, `mailtriage-tray autostart enable` starts the tray at login.
    EOS
  end

  test do
    assert_match "mailtriage #{version}", shell_output("#{bin}/mailtriage --version")
  end
end
