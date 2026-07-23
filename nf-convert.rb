class NfConvert < Formula
  desc "Patch Nerd Font glyphs into any TTF/OTF font"
  homepage "https://github.com/amodhakal/nf-convert"
  url "https://github.com/amodhakal/nf-convert/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "85aad01ae029c7fdeff904f509c6a4f6bf5d93e65a2dd3a0657b6ab1cf7741e3"
  license "MIT"

  depends_on "fontforge"

  resource "symbols-font" do
    url "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip"
    sha256 "8e617904b980fe3648a4b116808788fe50c99d2d495376cb7c0badbd8a564c47"
  end

  def install
    bin.install "bin/nf-convert"
    libexec.install "libexec/patch_font.py"

    resource("symbols-font").stage do
      libexec.install "SymbolsNerdFontMono-Regular.ttf"
    end
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/nf-convert --help")
  end
end
