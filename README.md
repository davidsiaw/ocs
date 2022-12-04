# OSS CAD Suite

This is a compilation of useful tools for working with the TinyTapeout project. If you have docker installed, this is a quick way of getting all the tools you need without having to install them on your PC.

## Docker Image

`docker pull davidsiaw/ocs`

Please see below if you wish to build this yourself on your own PC

## Example Usage

### Easy way

You can simply add for example

```bash
alias yosys="docker run --rm -ti --platform linux/arm64 -v $(PWD):/src --workdir /src -e PDK_ROOT=/opt/pdk davidsiaw/ocs yosys"
```

to your profile to have the `yosys` command

### Long way

If you don't want to add aliases or an executable bash script in your path you can just do it the long way:

`docker run --rm -ti --platform linux/arm64 -v $(PWD):/src --workdir /src -e PDK_ROOT=/opt/pdk davidsiaw/ocs yosys  -p "read_verilog mystuff.v; write_json"`


## What it contains

- The [Skywater 130nm PDK](https://github.com/google/skywater-pdk)
- The [Caravel user project for MPW-7](https://github.com/efabless/caravel_user_project)
- The [Yosys OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build)

## File explanations

- `build.sh` - the script you run to build the image (only runs on M1 macs. it builds a multi-plaform image that contains both arm and x64 manifests)
- `Dockerfile` - the description of the docker image
- `install.sh` - used by the Dockerfile to install everything
