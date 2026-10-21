#!/usr/bin/env python3
"""Generates the OneTick mark SVGs and every raster app icon from the brand geometry.

Geometry (64x64 viewBox) comes from the official "OneTick Logo" file (concept
"Anel e tick"). Run from the project root: python3 tool/generate_brand_assets.py
"""
import json
import math
from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parent.parent
NAVY = "#042449"
BLUE = "#0468D7"
MINT = "#0DFFC3"
WHITE = "#FFFFFF"

# Mark geometry in the 64x64 box.
CX, CY, R, STROKE = 32.0, 36.0, 22.0, 6.0
ARC_START_DEG, ARC_SWEEP_DEG = -70.0, 320.0  # clockwise from upper right
BAR = ((32.0, 5.0), (32.0, 21.0))
DOT_R = 4.0
# Visual bounding box of the mark (including stroke) for centering.
BBOX = (7.0, 2.0, 57.0, 61.0)


def svg(ring: str, accent: str, with_bg: str | None = None) -> str:
    bg = f'<rect width="64" height="64" fill="{with_bg}"/>' if with_bg else ""
    return (
        '<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64" fill="none">'
        f"{bg}"
        f'<path d="M39.52 15.33 A22 22 0 1 1 24.48 15.33" stroke="{ring}" stroke-width="6" stroke-linecap="round"/>'
        f'<path d="M32 5 L32 21" stroke="{accent}" stroke-width="6" stroke-linecap="round"/>'
        f'<circle cx="32" cy="36" r="4" fill="{ring}"/>'
        "</svg>\n"
    )


def render(size: int, bg: str | None, ring: str, accent: str, mark_scale: float, ss: int = 8) -> Image.Image:
    """Draw the mark centered in a size x size canvas; mark_scale = mark height / canvas."""
    big = size * ss
    img = Image.new("RGBA", (big, big), bg or (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    mark_h = BBOX[3] - BBOX[1]
    s = (big * mark_scale) / mark_h
    ox = big / 2 - (BBOX[0] + BBOX[2]) / 2 * s
    oy = big / 2 - (BBOX[1] + BBOX[3]) / 2 * s

    def p(x, y):
        return ox + x * s, oy + y * s

    def cap(x, y, color, rad):
        px, py = p(x, y)
        d.ellipse((px - rad * s, py - rad * s, px + rad * s, py + rad * s), fill=color)

    # Ring: polyline of dots along the arc keeps round caps and uniform stroke.
    steps = 720
    for i in range(steps + 1):
        a = math.radians(ARC_START_DEG + ARC_SWEEP_DEG * i / steps)
        cap(CX + R * math.cos(a), CY + R * math.sin(a), ring, STROKE / 2)
    # Accent bar.
    (x1, y1), (x2, y2) = BAR
    for i in range(0, 201):
        t = i / 200
        cap(x1 + (x2 - x1) * t, y1 + (y2 - y1) * t, accent, STROKE / 2)
    cap(CX, CY, ring, DOT_R)
    return img.resize((size, size), Image.LANCZOS)


def save(img: Image.Image, path: Path, opaque_bg: str | None = None) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if opaque_bg:
        flat = Image.new("RGB", img.size, opaque_bg)
        flat.paste(img, mask=img.split()[3])
        flat.save(path)
    else:
        img.save(path)


def main() -> None:
    images = ROOT / "assets" / "images"
    (images / "onetick_mark.svg").write_text(svg(NAVY, BLUE))
    (images / "onetick_mark_dark.svg").write_text(svg(WHITE, MINT))

    # App icon master: navy tile, white ring, mint bar.
    def icon(size: int, scale: float = 0.62, bg: str | None = NAVY) -> Image.Image:
        return render(size, bg, WHITE, MINT, scale)

    # --- Web ---
    web = ROOT / "web"
    save(icon(192, 0.56), web / "icons" / "Icon-192.png")
    save(icon(512, 0.56), web / "icons" / "Icon-512.png")
    save(icon(192, 0.5), web / "icons" / "Icon-maskable-192.png")
    save(icon(512, 0.5), web / "icons" / "Icon-maskable-512.png")
    save(icon(32, 0.7), web / "favicon.png")
    ico_master = icon(256, 0.72)
    ico_master.save(web / "favicon.ico", sizes=[(16, 16), (32, 32), (48, 48), (64, 64), (128, 128), (256, 256)])

    # --- Android legacy launcher icons (API < 26) ---
    res = ROOT / "android" / "app" / "src" / "main" / "res"
    for folder, px in {"mdpi": 48, "hdpi": 72, "xhdpi": 96, "xxhdpi": 144, "xxxhdpi": 192}.items():
        save(icon(px, 0.54), res / f"mipmap-{folder}" / "ic_launcher.png")

    # --- iOS ---
    appicon = ROOT / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
    contents = json.loads((appicon / "Contents.json").read_text())
    for entry in contents["images"]:
        base = float(entry["size"].split("x")[0])
        scale = int(entry["scale"].rstrip("x"))
        px = round(base * scale)
        save(icon(px, 0.56), appicon / entry["filename"], opaque_bg=NAVY)

    # --- Master preview for review / store listings ---
    save(icon(1024, 0.56), ROOT / "assets" / "brand" / "app_icon_1024.png", opaque_bg=NAVY)
    print("brand assets generated")


if __name__ == "__main__":
    main()
