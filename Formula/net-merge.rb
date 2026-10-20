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
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.3/net-merge-0.3.3-macos-universal.tar.gz"
      sha256 "542194640ce6baeb75141e47e1af1bfe2e6f591518105ea524c27a8ca75ed019"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.3/net-merge-0.3.3-macos-universal.tar.gz"
      sha256 "542194640ce6baeb75141e47e1af1bfe2e6f591518105ea524c27a8ca75ed019"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.3/net-merge-0.3.3-linux-aarch64.tar.gz"
      sha256 "3a839cc538b23a6e4575c158d05d9fd1fb90724d3f69e86da6d5dd2c884f41ca"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.3/net-merge-0.3.3-linux-x86_64.tar.gz"
      sha256 "f9092de729478c0e51f9972397ffbc80d3470017fb24315ed4fa045a84b8cff5"
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
