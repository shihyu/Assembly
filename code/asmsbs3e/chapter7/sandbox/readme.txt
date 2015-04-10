SANDBOX.ASM

Note that this is a sandbox program: It is not a complete, runnable application, and can only be usefully run inside a debugger like the Insight front end to gdb. If you attempt to run it from the Linux console, nothing permanently bad will happen, but the program will be terminated with a segmentation fault. To run Sandbox, load it into Insight, set a breakpoint on the first instruction after the initial NOP, and then single-step the program with the Registers and Memory views open.

The sandbox.asm source code file contains two example instructions. For an empty sandbox, begin with newsandbox.asm, write it out to disk as sandbox.asm, and then add your own instructions between the two NOPs. Run make from the sandbox directory to build the sandbox.asm program, and then run insight sandbox from the console to bring the sandbox up inside the debugger for single-stepping.

This is covered in the book in Chapter 7 on page 201.