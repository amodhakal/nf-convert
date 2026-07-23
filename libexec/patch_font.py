#!/usr/bin/env fontforge -lang=py
import sys
import os
import fontforge


def die(msg):
    sys.stderr.write(f"error: {msg}\n")
    sys.exit(1)


def main():
    if len(sys.argv) != 4:
        die(f"expected 3 args (base, symbols, output), got {len(sys.argv) - 1}")

    base_path, symbols_path, output_path = sys.argv[1:4]

    for p in (base_path, symbols_path):
        if not os.path.isfile(p):
            die(f"file does not exist: {p}")

    base = fontforge.open(base_path)
    symbols = fontforge.open(symbols_path)

    symbols.selection.all()
    symbols.copy()
    base.selection.all()
    base.paste()

    family = os.path.splitext(os.path.basename(output_path))[0]
    base.familyname = family
    base.fontname = family.replace(" ", "")
    base.fullname = family

    base.generate(output_path)
    print(f"wrote {output_path}")


if __name__ == "__main__":
    main()
