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
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.1/net-merge-0.3.1-macos-universal.tar.gz"
      sha256 "f3fdae558fa6eb93b787d76575376f5e12c73c59a4de28685e59e30888a4eb1c"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.1/net-merge-0.3.1-macos-universal.tar.gz"
      sha256 "f3fdae558fa6eb93b787d76575376f5e12c73c59a4de28685e59e30888a4eb1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.1/net-merge-0.3.1-linux-aarch64.tar.gz"
      sha256 "c47f63db6eee2810774884418f53d3a4bafde3ca2c06e978849c413bd0fab937"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.1/net-merge-0.3.1-linux-x86_64.tar.gz"
      sha256 "2c1550bc1b7ce350e99af7e06fefc93c22a73b33581be385404efd6390b7bc5b"
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
