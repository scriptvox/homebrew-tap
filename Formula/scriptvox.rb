class Scriptvox < Formula
  desc "Command-line tool that makes a narrated, captioned video from a script"
  homepage "https://github.com/scriptvox/scriptvox"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/scriptvox/scriptvox/releases/download/v0.1.0/scriptvox-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "cf52c7856279a634db53354fdaea1f04d87716cc6c6c5c52d926fcbb0b1e80d1"
    end
    on_intel do
      url "https://github.com/scriptvox/scriptvox/releases/download/v0.1.0/scriptvox-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "1157366357c275ee1313b10a04ec1ac10deccd4fc89b4c61984865b8c45882ac"
    end
    depends_on "ffmpeg-full"
    depends_on "uv"
  end

  on_linux do
    on_intel do
      url "https://github.com/scriptvox/scriptvox/releases/download/v0.1.0/scriptvox-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "865a4b35af5106e8e01591ebbc49c3a2053fb06a1e88900f6fa8c7db008d9f53"
    end
  end

  def install
    doc.install "README.md", "CREDITS.md", "THIRD_PARTY.md", "OFL-1.1.txt"
    if OS.mac?
      libexec.install "scriptvox"
      (bin/"scriptvox").write_env_script libexec/"scriptvox",
        SCRIPTVOX_FFMPEG: Formula["ffmpeg-full"].opt_bin/"ffmpeg",
        SCRIPTVOX_UV:     Formula["uv"].opt_bin/"uv"
    else
      bin.install "scriptvox"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scriptvox --version")
  end
end
