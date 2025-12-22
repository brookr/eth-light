# A light in the darkness...

An interactive canvas artwork that visualizes Ethereum's network burn rate and 6529 voting activity as a dynamic star, overlaid with flowing calligraphic text capturing the sentiment of light persisting through darkness.

## Concept

This piece translates blockchain activity into a contemplative visual metaphor: a multi-pointed star whose brightness responds to Ethereum's real-time burn data (base fee + blob burn), while its complexity reflects community engagement through 6529 TDH voting activity.

The star begins with 4 points and grows based on the number of submissions that received votes in the last hour, making it a living representation of collective creative participation. Each submission that gains votes adds one point to the star. 

The viewer can interact with the piece through touch or mouse, controlling both brightness (vertical axis) and size (horizontal axis), or simply observe as it responds to on-chain activity.

## Features

### Data Visualization

- **Live Ethereum data**: Polls public RPC endpoints every 12 seconds for latest block burn metrics
- **TDH vote tracking**: Monitors top 50 submissions (by rank) on 6529 Main Stage, tracking vote changes
- **Logarithmic brightness mapping**: Calibrated to Solstice 2025 baseline (~0.0012 ETH midpoint)
- **Dynamic star complexity**: Point count = 4 + number of submissions with votes in last hour
- **Logarithmic size scaling**: Star size grows with total TDH vote inflow (10K baseline, up to 2M+ max)

### Interaction

- **Vertical movement**: Controls star brightness
- **Horizontal movement**: Controls star size
- **Click/tap**: Manually increment star points (up to 42), resets after 6.9 seconds or on mouse leave
- **Alternating arms**: Every other star point is shorter (70% length) for visual depth

### Technical

- **Organic animation**: Flame-like flicker using layered sine waves and seeded randomness
- **Zero dependencies**: Self-contained HTML with embedded Tangerine font (base64 WOFF2)
- **Deterministic rendering**: Seeded RNG for consistent star field and animations
- **Memory safe**: Bounded data structures prevent memory leaks in long-running sessions
- **Informative logging**: Check behind the scenes: One console log per Ethereum block, silent TDH tracking unless activity detected

## Technical Details

- **Aspect ratio**: 5:7 portrait, scales to viewport
- **Font**: Tangerine (calligraphic script, SIL OFL licensed)
- **Text**: "a light shines in the darkness, and the darkness has not overcome it." (John 1:5)
- **Canvas rendering**: 2D context with radial gradients, glow effects, and arc-based text layout
- **Polling intervals**: Ethereum blocks (12s), TDH votes (12s)
- **Vote window**: Rolling 1-hour window for activity aggregation (starts empty on load, accumulates over first hour)
- **RNG seeding**: Starfield randomness is initialized once per load from the first Ethereum block fetched, so each session is deterministic yet changes with time.
- **RPC decentralization**: A pool of 10 public RPC endpoints is tried in random order with caching, and the chosen endpoint is logged to the console for auditability.

## Development

### Local Development

```bash
# Open index.html in a browser
open index.html
```

### Building for On-Chain Deployment

```bash
# Run the build script
./build.sh

# Outputs:
# - build.html  (readable, 52KB)
# - light.html  (production, 52KB)
```

The build process:

1. Extracts base64 font data from `tangerine.css`
2. Inlines all CSS and font data into a single HTML file
3. Creates a self-contained artifact ready for IPFS, Arweave, or on-chain storage

- Requires Node.js/npm so `npx html-minifier-terser` can run during the build step.

### Files

- `index.html` - Main development file
- `tangerine.css` - Embedded font (base64 WOFF2)
- `build.sh` - Build script for single-file output
- `light.html` - Production build (generated)

## License

CC0 1.0 Universal - Public Domain Dedication

This work has been dedicated to the public domain. You can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission.
