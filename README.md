## System Requirements

### arm-gcc-embedded
* Grab it from [here](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads)

### srec_cat
* `apt install srecord`

### JLink tools
* Grab the debian package from [here](https://www.segger.com/downloads/jlink/#J-LinkSoftwareAndDocumentationPack) [direct-download](https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb)


## Compiling
* Make sure you have the nrf sdk downloaded and put in `lib`. See [this readme](./lib/readme.md).
* `make -j4`

You end up with 2 .hex files, one with and one without softdevice.

The .elf file can be used for debugging. Make sure a softdevice is present in your target though.


## Debugging with vscode
* Install the `Cortex-debug` extension
* Create a new Debug config (example):
```
{
    "name": "Cortex Debug",
    "request": "launch",
    "type": "cortex-debug",

    "cwd": "${workspaceRoot}",
    "executable": "build/nrf52-blinky.elf",

    "servertype": "jlink",
    "device": "nRF52840_XXAA",
}
```
