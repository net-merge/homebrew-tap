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
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.0/net-merge-0.3.0-macos-universal.tar.gz"
      sha256 "52d69c6644b1bb3a6cfbc112dcf7425d97ec41768e22ac456a2b5556da326aa5"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.0/net-merge-0.3.0-macos-universal.tar.gz"
      sha256 "52d69c6644b1bb3a6cfbc112dcf7425d97ec41768e22ac456a2b5556da326aa5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.0/net-merge-0.3.0-linux-aarch64.tar.gz"
      sha256 "d31bb587ea73f75b9f31d6eef8fb5fd7bd255ef1071f6c4fbd7acaeebbe665f9"
    end
    on_intel do
      url "https://github.com/rohit267/net-merge/releases/download/v0.3.0/net-merge-0.3.0-linux-x86_64.tar.gz"
      sha256 "fdfdb7477f803ba39898427432f968649bcf0b59c9ec0be797a50173dc53405d"
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
