# nf-convert

A CLI that patches [Nerd Font](https://www.nerdfonts.com/) symbol glyphs
(icons, devicons, etc.) into any TTF/OTF font you point it at — no manual
FontForge scripting required.

## Install

```sh
brew tap amodhakal/tap
brew install nf-convert
```

Requires [FontForge](https://fontforge.org/), which is pulled in
automatically as a dependency.

## Usage

No arguments. Run it from a directory containing the font(s) you want to
patch:

```sh
cd ~/Fonts/MyTypeface
nf-convert
```

It scans the current directory for every `.ttf`/`.otf` file, patches Nerd
Font symbols into each one, and writes the result alongside the original as
`<name>Nerd.<ext>`. For example:

```
MyTypeface-Regular.ttf   ->   MyTypeface-RegularNerd.ttf
```

Files already ending in `Nerd.ttf` / `Nerd.otf` are skipped, so it's safe to
re-run in a directory you've already patched.

## How it works

Under the hood, `nf-convert` runs a FontForge script (`libexec/patch_font.py`)
that:

1. Opens your font and a bundled copy of the Nerd Fonts "Symbols Only" set.
2. Copies every glyph from the symbols font and pastes it into your font.
3. Renames the merged font so it doesn't collide with the original in your
   font picker.
4. Writes out the patched file.

The symbols font is bundled by the Homebrew formula (fetched from the
official [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
releases) — you don't need to download anything yourself.

## Why this exists

Manually patching fonts with FontForge means hand-writing an inline Python
script every time, hardcoding filenames, and hoping FontForge's working
directory happens to match your shell's. `nf-convert` fixes that: it resolves
paths absolutely, discovers fonts automatically, and packages the whole thing
as a normal CLI tool.

## Repo layout

```
bin/nf-convert          # bash CLI entrypoint
libexec/patch_font.py   # FontForge script that does the actual merge
```

## Local development

```sh
git clone https://github.com/amodhakal/nf-convert.git
cd nf-convert
chmod +x bin/nf-convert
./bin/nf-convert --help
```

Note: running directly out of the repo like this won't find the bundled
symbols font (that's only staged in by the Homebrew formula). For local
testing against a real symbols font, place
`SymbolsNerdFontMono-Regular.ttf` in a `libexec/` next to `bin/`, or install
via Homebrew instead.

## License

MIT — see [LICENSE](./LICENSE).
