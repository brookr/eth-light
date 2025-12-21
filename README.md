# A light in the darkness...

An interactive canvas artwork that visualizes Ethereum's network burn rate as a flickering star, overlaid with text capturing the international sentiment of the Winter solstice in the northern hemisphere.

## Concept

This piece translates blockchain activity into a contemplative visual metaphor: a five-pointed star whose brightness responds to Ethereum's real-time burn data (base fee + blob burn). When no user interaction is present, the star's intensity reflects the network's current state—brighter during high activity, dimmer during quiet periods.

The viewer can override this by moving their pointer or touch vertically across the canvas, manually controlling the light's brightness—an act of tending the flame.

## Features

- **Live Ethereum data**: Polls public RPC endpoints every 3 seconds for latest block burn metrics
- **Logarithmic brightness mapping**: Calibrated to Solstice 2025 baseline (~0.0012 ETH midpoint)
- **Organic animation**: Flame-like flicker using layered sine waves and seeded randomness
- **Responsive interaction**: Mouse hover or touch overrides burn-driven brightness
- **Zero dependencies**: Self-contained HTML with embedded EB Garamond font (base64 WOFF2)
- **Deterministic rendering**: Seeded RNG for consistent star field and animations

## Technical Details

- **Aspect ratio**: 5:7 portrait, scales to viewport
- **Font**: EB Garamond (embedded, SIL OFL licensed)
- **Text**: "a light shines in the darkness, and the darkness has not overcome it." (John 1:5, WEB)
- **Canvas rendering**: 2D context with radial gradients, glow effects, and arc-based text layout

## Usage

Open `index.html` in a modern browser. No build step or server required.

For on-chain deployment, the entire project can be embedded as a single HTML file by inlining `eb-garamond.css`.

## License

CC0 1.0 Universal - Public Domain Dedication

This work has been dedicated to the public domain. You can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission.
