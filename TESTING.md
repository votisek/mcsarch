### Testing MCSaRch

1. Install dependencies

```bash
# Archlinux
sudo pacman -Sy edk2-ovmf archiso qemu-full
# Fedora 
sudo dnf install qemu edk2-ovmf
```  

2. Clone the repository

```bash
git clone https://github.com/votisek/mcsarch.git && cd mcsarch
```

3. Build the iso

This step works only on Arch because of the required package archiso, if you don't have arch, you can download the latest build from [here](https://github.com/votisek/mcsarch/actions/runs/24008000165/artifacts/6279189839).
To build the iso, run `sudo make build` in the root directory of the project
If you downloaded the iso, extract it from the zip file, then rename it to `mcsarch.iso` and place it into the root directory of the mcsarch folder.

4. Run the iso
To run the iso on a virtual drive, we first need to create the drive and then run it.

```bash
# Create the drive
make create-drive
# Start the virtual machine
make test
```

5. Starting all over again

If you want to delete the installed os and test different options, you can run the following command to format the drive.

```bash
make format-drive
```

If you encounter any bugs, you can dm me on discord (@votiseek) or create an issue on the Github page.
