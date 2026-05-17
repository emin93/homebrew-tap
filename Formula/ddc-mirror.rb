# typed: strict
# frozen_string_literal: true

# Formula for ddc-mirror.
class DdcMirror < Formula
  desc "Smartly sync built-in MacBook brightness to external displays"
  homepage "https://ddc-mirror.emin.ch"
  url "https://github.com/emin93/ddc-mirror/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "25425c013ac20cb540fd439be71484f24c5c9160215773f5b3174af8e7471747"
  license "MIT"
  head "https://github.com/emin93/ddc-mirror.git", branch: "main"

  depends_on :macos

  def install
    system "make"
    bin.install "ddc-mirror"
  end

  service do
    run [opt_bin/"ddc-mirror"]
    keep_alive true
    log_path var/"log/ddc-mirror.log"
    error_log_path var/"log/ddc-mirror.log"
  end

  def caveats
    <<~EOS
      ✨  ddc-mirror is installed.

      Start syncing now (and on every login):
        brew services start ddc-mirror

      Or run it once in the foreground:
        ddc-mirror

      Optional external display calibration:
        defaults write ch.emin.ddc-mirror externalBrightnessOffset -float 0.10
        brew services restart ddc-mirror

      That's it. There is no step two.
    EOS
  end

  test do
    assert_match "Usage: ddc-mirror", shell_output("#{bin}/ddc-mirror --help")
  end
end
