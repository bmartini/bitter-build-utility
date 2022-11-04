# Bitter Build Utility

Bitter experience has taught me how difficult it is to create a productive and
scriptable work flow with Xilinx tools. This utility is an attempt to make it
easier to quickly get a Xilinx project setup and building.

## Perquisites

The following Python packages and programs need to be installed for bitter to work.

### Python Packages

Besides the default python install the following package need to be installed.

```bash
python3 -m pip install click
```

### Xilinx Tools

Instructions on how to install Xilinx in a docker volume are detailed within a
[README](docker/README.md) in the docker directory.

## Usage

Simple usage example. Clone the current repository and install the perquisites
on the target system, currently only Ubuntu has been tested on. Once the Xilinx
tools have been installed into its docker volume, move the 'bitter' utility
into your RTL projects git repository.

### Create Project TCL Script

Generate a template TCL script used to create a Xilinx project by running the
following command.

```bash
./bitter --template
```

The resulting TCL script can be customized for the current project. This
usually involves creating a list of SystemVerilog files to add to the IP-XACT
for inclusion within the project.

### Create Block Design

I usually create a Block Design (BD) as the top level of my project and
instantiate all IP needed to connect to the outside world with the Xilinx GUI
and wizards. I then create a 'core' logic block containing my RTL IP and
instantiate that within the BD. The BD is thus acting as an 'IO ring' that
surrounds the RTL IP.

Create the project workspace by running the following command.

```bash
./bitter --create --project <name of create TCL script>.tcl
```

Once the project workspace has been created, enter the interactive mode of the
'bitter' docker development environment.

```bash
./bitter --interactive
```

Then within the docker environment open the project using Vivado. In the Vivado
GUI create the Block Design and once everything has been added, export the
design as a TCL script from the "File->Export->Export Block Design..." menu
item. For the created BD script to be picked up by the 'bitter' utility it must
be named `<name of create TCL script>_bd.tcl` and be saved alongside the
create script.

It must be noted that the projects RTL Core IP should be available within the
Block Designs "Add IP" menu.

### Create Bitstream

Once the Block Design script has been created and a suitable constants (XDC)
file has been added to the project, those sections in the create TCL script can
un-commented out. Then, running the 'bitter' command will generate a bitstream
file.

```bash
./bitter
```
