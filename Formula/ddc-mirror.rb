# typed: strict
# frozen_string_literal: true

# Formula for ddc-mirror.
class DdcMirror < Formula
  desc "Mirror built-in display brightness to external DDC/CI monitors"
  homepage "https://github.com/emin93/ddc-mirror"
  url "https://github.com/emin93/ddc-mirror/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f2b5d36124d17f30be806a102fa6510d7c2143d779b4e2cd49e6675c287b9375"
  license "MIT"
  head "https://github.com/emin93/ddc-mirror.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on "m1ddc"
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
