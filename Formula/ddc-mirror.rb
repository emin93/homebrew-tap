# typed: strict
# frozen_string_literal: true

# Formula for ddc-mirror.
class DdcMirror < Formula
  desc "Sync built-in MacBook brightness to all external displays"
  homepage "https://ddc-mirror.emin.ch"
  url "https://github.com/emin93/ddc-mirror/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "85145a793a1c7c857c96c6e8662f9a5b8af8b9bf10f7423f657e73707339f634"
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

      That's it. There is no step two.
    EOS
  end

  test do
    assert_match "Usage: ddc-mirror", shell_output("#{bin}/ddc-mirror --help")
  end
end
