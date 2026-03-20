# CONFIGURATION

This is a file containing instructions for potential future configuration of your desktop.

The files are split into sections, indicated by the `### SECTION ###` line and the beginning of other sections.

## Jay

Jay has a default and a basic configuration containing basic functionality. You can find the config file in `~/.config/jay/config.toml`. The first thing you should do, is change your monitor configuration, since the default is a single monitor layout with auto-detection.

### Monitor configuration

The monitor configuration is located in the output section of the file. There is already a default monitor for you to copy the configuration of, but if you use multiple monitors, you will have to add more monitor configurations.

Additional settings are needed for different resolutions and refresh rates. Here are additional settings to add to the montior configuration:

- `match.connector = "HDMI-A-1"` - 