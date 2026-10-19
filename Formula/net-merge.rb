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
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.2/net-merge-0.3.2-macos-universal.tar.gz"
      sha256 "d889185bc61782794bb4fa694011ef591b48b2b3d9b5d151ae13ee607a9f4ba0"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.2/net-merge-0.3.2-macos-universal.tar.gz"
      sha256 "d889185bc61782794bb4fa694011ef591b48b2b3d9b5d151ae13ee607a9f4ba0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.2/net-merge-0.3.2-linux-aarch64.tar.gz"
      sha256 "45330292a5084b7909049b464837044a7d78bda45e542265110a349eb8bb0e48"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.2/net-merge-0.3.2-linux-x86_64.tar.gz"
      sha256 "7eb1c41750830234e151fd07bd729b7b103492d81477369733a64c7000a99691"
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
