# ti84-forthos - a Forth-based OS for the TI-84+ calculator
**ti84-forthos** is an operating system that is designed from the
ground up to revolve around the *Forth* programming language.  See the
documentation at `docs/` for more information.  It is based on
**hiti**, the minimal core.

## Current Status
Nothing implemented yet.

## Dependencies
The build process depends on the following tools:

| Tool        | Link to Repository                      |
| :---:       | :---:                                   |
| kcc         | https://github.com/KnightOS/kcc         |
| scas        | https://github.com/KnightOS/scas        |
| mkrom       | https://github.com/KnightOS/mkrom       |
| mktiupgrade | https://github.com/KnightOS/mktiupgrade |

[z80e](https://github.com/KnightOS/z80e) is optional but having it
will allow you run it emulated.

## Compiling
Clone this repository and run `make`.

## Debugging
Use the `make z80e` target to run your OS in the z80e debugger.  You
should see a prompt waiting for you to enter debugger commands - use
"run" to start running the CPU.  You can pause execution again by
hitting Ctrl+C in the debugger console.  Use "?" for a list of
debugger commands.
