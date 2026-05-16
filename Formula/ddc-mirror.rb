# typed: strict
# frozen_string_literal: true

# Formula for ddc-mirror.
class DdcMirror < Formula
  desc "Mirror built-in display brightness to external DDC/CI monitors"
  homepage "https://github.com/emin93/ddc-mirror"
  url "https://github.com/emin93/ddc-mirror/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "25014dec4954242e96401962e3ed3ef4112c761cbb27bcae62099ad8ec13b7bb"
  license "MIT"
  head "https://github.com/emin93/ddc-mirror.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/ddc-mirror"
  end

  service do
    run [opt_bin/"ddc-mirror"]
    keep_alive true
    log_path var/"log/ddc-mirror.log"
    error_log_path var/"log/ddc-mirror.log"
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  end

  test do
    assert_match "Usage: ddc-mirror", shell_output("#{bin}/ddc-mirror --help")
  end
end
