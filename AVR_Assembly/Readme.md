# This is the AVR Assembly documentation for NNFSiX

## Explanation of the files
1. attinyXX.asm - This is the file where registers are mapped to the memory location. That way, in the code, we can put readable register names and this file will link them to the correct address. Similar files can be found online but I made these myself so there might be errors (I hope not...). I used the official datasheet for each microcontroller to create these files. I also added some explanations to some registers.
2. pXXX-___.asm - These are the main code files for each video. It will take a while to complete all...
3. tasks.json - This file includes the tasks for assembling and flashing and is readable in Visual Studio Code. You can also use it to get the commands to flash via command line
4. template.asm - Is a relatively clean template for assembler programms, made by me

## Requirements
The code is written for an Attiny44. Being assembly code it is specialized for this particular microcontroller. It might be possible to get it to run on similar hardware. For example:
- Attiny24/44/84 are the same except for available memory
- Attiny85 and similar should be able to run with the right register map

## Assemble and flash
### Software
For assembling i use avra:

    sudo apt install avra

And for flashing avrdude:

    sudo apt install avrdude

Similar tools can be found for Windows but they are more difficult to configure.

### Hardware
I build my own programmer following this guide:

https://www.fischl.de/usbasp/

### Compile
Either run the task or:
1. Navigate to the directory with the .asm file(s)
2. Run:

       avra filename.asm

3. Pray for no errors
4. Next to some other files a .hex file will be created. This is the code in hex format. That's the file you need to flash to the microcontroller

### Flash
Either run the task or:
1. Navigate to the directory with the .asm file(s)
2. Run:
    
       avrdude -c Usbasp -p t44 -U flash:w:filename.hex

3. Wait for flashing and validation to finish
4. Done

### Problems that I faced
- When flashing a completly new microcontroller, the fuses have to be set. This can be done with avrdude. You may want to google the fuse calculator and use it for your values since wrong fuses can destroy the microcontroller permanently (maybe recoverable with special tools...). This website will also create the right command for avrdude: http://www.engbedded.com/fusecalc/

## Configuring code and commands for your microcontroller
I have no idea what kind of microcontroller you want to use but here are the basics:
1. In the pXXX-___.asm there is a line at the beginning where I include the register map (attiny44.asm). Change that to include your file
2. In the line right next to that, change the device so the compiler can check for memory space violation etc.
3. In the flash command for avrdude, change the -p option to specify your device instead.

That should be all necessary changes. At least I can't remember any other things at the moment.