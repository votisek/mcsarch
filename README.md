# MCSaRch

MCSaRch is a custom Arch Linux ISO focused on Minecraft speedrunning.
It provides a fast, preconfigured setup with the core tools already included.

> [!WARNING]
> This project is in early alpha.
> Some parts are still experimental and may change.

## Features

- Preconfigured desktop/window environment setup
- Waywall with a basic starting configuration
- Prism Launcher preinstalled for instance and mod management
- MCSR Ranked instance included

## Quick Start

### Pre-built package

Beginner users should use prebuilt images from Releases.

1. Open GitHub Releases and download the latest `.iso`
2. Flash it to a USB drive
3. Boot from the USB and start installation

### Build from source

This method is limited to Linux and MacOS:

```bash
make build
```

The built ISO is written to the `out/` directory.

## Flashing the ISO

- Windows: Rufus (`https://rufus.ie/`)
- Linux/macOS: Balena Etcher (`https://etcher.balena.io/`)

Follow the official guide for your tool and select the downloaded `.iso` file.
