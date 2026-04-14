# First steps

## Getting the ISO

### From releases

The easiest way to get the installation media is to download the latest release from the releases page

### Building from source

To build from source, you must be on Arch Linux, or have a docker container set up with Arch Linux, as you need the `mkarchiso` tool to build the ISO.

You can install the `archiso` package to get it using the following command:

```bash
sudo pacman -Sy archiso
```

Then, you can clone the repository, and run the premade build script in the cloned directory:

```bash
git clone https://github.com/votisek/mcsarch
cd mcsarch
sudo make build
```

## Flashing the ISO

You will need a USB drive with at least 4GB of storage.

### On Windows

The most reliable tool to use on Windows is [Rufus](https://rufus.ie/).

1. Download and open Rufus.
2. Select your USB drive under the **Device** dropdown.
3. Click the **SELECT** button and choose the downloaded ISO file.
4. Click **START**. (If prompted about ISOHybrid, selecting "Write in DD Image mode").

### On Linux & macOS

For a graphical (GUI) tool, [balenaEtcher](https://etcher.balena.io/) is highly recommended. The process is exactly the same as on Windows: Select the `.iso` file, pick your USB drive, and click Flash.

Alternatively, you can use `dd` from the command line (for advanced users):

1. Identify your USB drive
    - On linux, run `lsblk` and find the device using the size as a reference. Then save the device path (e.g. `/dev/sda`)
    - On macOS, run `diskutil list` and find the device using the size as a reference. Then save the device path (e.g. `/dev/sda`)

2. Use `dd` to flash the installation media.

```bash
# Replace /dev/sdX with your USB drive path
# Replace /path/to/mcsarch.iso with the path to the downloaded ISO file
sudo dd bs=4M if=/path/to/mcsarch.iso of=/path/to/usb status=progress
```

## Booting from the USB

To boot into the MCSaRch installation media, you will need to restart your pc and enter the boot menu. This is usually done by pressing a specific key during the initial startup screen (usually delete, F2, F11 or F12). To make it easier, you can spam those keys right after you turn on your computer.

Once you are in the boot menu, select the USB drive.

## Connecting to the internet

If you are using a wired connection, you should be automatically connected to the internet. If not, you will need to connect to WiFi. You can do that by running `nmtui` in the terminal, selecting "Activate a connection", and then selecting your WiFi network and entering the password.

## Installation

Once you are connected to the internet, you can start the installation process by running `install`.

The installer will ask you for your area from which it will download packages.

Then you will get prompted to choose your DM. In short, this is how your desktop will look and feel like. For beginners, the recommended option is Plasma, as it's windows-like nature makes this a great starting point. You can learn more about the different options [here](https://github.com/votisek/mcsarch/blob/main/doc/config_prevs.md)

The next step is the actual installation. In here everything is automatically done for you, except for these options:

- **Disk configuration** - Using the arrow keys, locate the Disk configuration option and press enter. Then select the default option (the one that is preselected) 2 times, then using arrows and spacebar select the disk you want to install MCSaRch on, and then press enter (Warning: This will erase all data on the selected disk). Now again select the default option 3 times and go back.
- **Username and password** - Locate the Authentication option and press enter. First, enter a root password, that is a password to the administrator account. Then, lets add your user account. Press the User account option, and select Add a user. Then enter your username, and password. Make this user a superuser. If you want to make multiple user accounts, repeat the process. If not, click on Confirm and exit -> Back.

The only thing remaining is to install it by selecting Install and confirming it. The installation process will take 5-20 minutes depending on your internet speed.

Once the installation is done, do not reboot. Instead, we need to do some post-installation config handled by the install script. So, select "Continue without rebooting" and press enter.

Now, you are gonna select the themes for a few programs. You can preview those [here](https://github.com/votisek/mcsarch/blob/main/doc/config_prevs.md)

The first selector is for SDDM, the login screen.

The second selector is for waybar, but that only shows if you selected Jay or Niri as your DM.

Congratulations, you have successfully installed MCSaRch! You can now wait for the automatic reboot and log in with the username and password you set during the installation process.
