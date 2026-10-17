class NetMerge < Formula
  desc "Use all your network adapters at once (Wi-Fi, Ethernet, phone tethers)"
  homepage "https://github.com/rohit267/net-merge"
  version "0.2.0"
  license "MIT"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    url "https://github.com/rohit267/net-merge/releases/download/v0.2.0/net-merge-0.2.0-macos-universal.tar.gz"
    sha256 "26c059b8b0f90fd7ac8ea378c922d57685520df69586bab27957dfa99f19f29b"
  end

  on_linux do
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.2.0/net-merge-0.2.0-linux-x86_64.tar.gz"
      sha256 "8bf95cce52eff0fab54d17ceb988f1712f0cb1055359ac81153330c201d801c0"
    end
    on_arm do
      url "https://github.com/rohit267/net-merge/releases/download/v0.2.0/net-merge-0.2.0-linux-aarch64.tar.gz"
      sha256 "adb21f403cc8304eaec37a8b7a38051c54d3177a870ab3cb0f57fd6119dde7a4"
    end
  end

  def install
    bin.install "net-merge"
  end

  def caveats
    if OS.mac?
      <<~EOS
        net-merge needs root to create its virtual adapter. Run this once, and again after each
        `brew upgrade net-merge`, so the tray can start without a password:
          sudo #{opt_bin}/net-merge install
        Then start it with `net-merge tray`. Android phones need the TetherKit app:
          https://github.com/rohit267/net-merge#add-a-second-connection
      EOS
    else
      <<~EOS
        net-merge needs network rights. Give them once, and again after each `brew upgrade net-merge`:
          sudo setcap cap_net_admin,cap_net_raw+ep "$(readlink -f #{opt_bin}/net-merge)"
        Then start it with `net-merge tray`.
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/net-merge version")
  end
end
