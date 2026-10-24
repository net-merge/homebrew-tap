class NetMerge < Formula
  desc "Use all your network adapters at once (Wi-Fi, Ethernet, phone tethers)"
  homepage "https://github.com/rohit267/net-merge"
  license "MIT"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  # One universal macOS build serves both Apple Silicon and Intel.
  on_macos do
    on_arm do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.5/net-merge-0.3.5-macos-universal.tar.gz"
      sha256 "d2803f64d925ed4c7ae5541aa94c014fa0a84e6638607373ede9877c8ca2ee26"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.5/net-merge-0.3.5-macos-universal.tar.gz"
      sha256 "d2803f64d925ed4c7ae5541aa94c014fa0a84e6638607373ede9877c8ca2ee26"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.5/net-merge-0.3.5-linux-aarch64.tar.gz"
      sha256 "46d83805dd54bced78f27715795f3122935725cecd5ddb7c8d57f000aee2d162"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.5/net-merge-0.3.5-linux-x86_64.tar.gz"
      sha256 "fe9b0b3d4b7c2fe4c8f969fc13481699ee32718de972cc10f44a7c494841e17e"
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
