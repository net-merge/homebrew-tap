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
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.4/net-merge-0.3.4-macos-universal.tar.gz"
      sha256 "408de99a99188d40e6362d5a4838574c227f5abd672cd27228e35e23d8446622"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.4/net-merge-0.3.4-macos-universal.tar.gz"
      sha256 "408de99a99188d40e6362d5a4838574c227f5abd672cd27228e35e23d8446622"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.4/net-merge-0.3.4-linux-aarch64.tar.gz"
      sha256 "95b024e1f33ee90e3ebe014bbb5f0c88d4043739c490510dcd504345dd5b59e0"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.4/net-merge-0.3.4-linux-x86_64.tar.gz"
      sha256 "fd1720ed275a839be3b31996778ba5cc74ad8cac81bfebeef65c02761023fc18"
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
