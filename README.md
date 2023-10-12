# Miniature Image Uploader Client

## Brief
This small shell script handles uploading files to [MIU](https://i.komachi.sh), either via direct invocation from command line or by XDG .desktop file. In both cases arguments expected are paths to files to upload.

## Requirements
1. curl
2. jq for parsing response JSON
3. xclip for x11 clipboard support
4. wl-clipboard for Wayland clipboard support

## Installation
1. Clone the repository
2. Run make
3. Make sure your `$HOME/.local/bin` is in your `$PATH`
4. Add your remote token to `$HOME/.miukey`

## Usage

Either via `miupload` invocation or by drag and drop (or targeted invocation of .desktop file)

```
miupload myfile.png
```

