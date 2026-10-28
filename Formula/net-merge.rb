class NetMerge < Formula
  desc "Use all your network adapters at once (Wi-Fi, Ethernet, phone tethers)"
  homepage "https://github.com/net-merge/net-merge"
  license "MIT"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  # One universal macOS build serves both Apple Silicon and Intel.
  on_macos do
    on_arm do
      url "https://github.com/net-merge/net-merge/releases/download/v0.3.6/net-merge-0.3.6-macos-universal.tar.gz"
      sha256 "59d06c044c2085e7533c842149471447a5048e98b310054c96a62debd75ed4eb"
    end
    on_intel do
      url "https://github.com/net-merge/net-merge/releases/download/v0.3.6/net-merge-0.3.6-macos-universal.tar.gz"
      sha256 "59d06c044c2085e7533c842149471447a5048e98b310054c96a62debd75ed4eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/net-merge/net-merge/releases/download/v0.3.6/net-merge-0.3.6-linux-aarch64.tar.gz"
      sha256 "da6591c37adc2c9e6548cb40e8b3aa3376d84f3c2d2caf926a91a03ecf0c175f"
    end
    on_intel do
      url "https://github.com/net-merge/net-merge/releases/download/v0.3.6/net-merge-0.3.6-linux-x86_64.tar.gz"
      sha256 "6cd0f248a7c78b423e19e9df2b4c44244a74fd0b55554c24e2f536d1927e5d78"
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
          https://github.com/net-merge/net-merge#add-a-second-connection
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
