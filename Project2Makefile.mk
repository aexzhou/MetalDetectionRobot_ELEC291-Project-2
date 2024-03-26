SHELL=cmd
EFM8cc=c51

STMcc=arm-none-eabi-gcc
STMas=arm-none-eabi-as
STMld=arm-none-eabi-ld
STMccFLAGS=-mcpu=cortex-m0 -mthumb -g
STMasFLAGS=-mcpu=cortex-m0 -mthumb -g

PORT1 = COM20
PORT2 = COM21

# 1 - controller
# 2 - robot
PROG1 = controller
SRC1 = controller.c
#HEADERS1 = robot1.h ...
PROG2 = robot
SRC2 = robot.c
#HEADERS2 = robot2.h ...
controllerOBJS = controller.o
robotOBJS = robot.o startup.o

controller.hex: $(controllerOBJS)
	$(EFM8cc) $(controllerOBJS)
	@echo hex file made for: $(SRC1)

robot.elf: $(robotOBJS)
	$(STMld) $(robotOBJS) -T ../Common/LDscripts/stm32l051xx_simple.ld --cref -Map robot.map -o robot.elf
	arm-non-eabi-objcopy -O ihex robot.elf robot.hex
	@echo robot Compilation Success!

robot.o: robot.c
	$(STMcc) -c $(STMccFLAGS) robot.c -o robot.o

startup.o: ../Common/Source/startup.c 
	$(STMcc) -c $(STMccFLAGS) ../Common/Source/startup.c -o startup.o 
	
robot.hex: $(robotOBJS)
	$(EFM8cc) $(robotOBJS)
	@echo hex file made for: $(SRC2)

controller.o: controller.c  #$(HEADERS1)
	$(EFM8cc) -c $(SRC1)

robot.o: robot.c #$(HEADERS2)
	$(EFM8cc) -c $(SRC2)

clean:
	@del $(controllerOBJS) *.asm *.lkr *.lst *.map *.hex *.map 2> nul
	@del $(robotOBJS) *.lst 2>NUL 
	@del robot.elf robot.hex robot.map 2>NUL 

LoadFlash:
	@Taskkill /IM putty.exe /F 2>NUL | wait 500 
	EFM8_prog.exe -ft230 -r -d0 controller.hex
	cmd /c start putty -serial $(PORT1) -sercfg 115200,8,n,1,N

	@echo ..\stm32flash\stm32flash -w robot.hex -v -g 0x0 ^^>loadf.bat
	@..\stm32flash\BO230\BO230 -b >>loadf.bat
	@loadf

putty:
	@Taskkill /IM putty.exe /F 2>NUL | wait 500
	cmd /c start putty -serial $(PORT1) -sercfg 115200,8,n,1,N
	cmd /c start putty -serial $(PORT2) -sercfg 115200,8,n,1,N

Dummy: $(PROG1).hex $(PROG1).Map  $(PROG2).hex $(PROG2).Map
	@echo Nothing to see here!
	
explorer:
	cmd /c start explorer .
		