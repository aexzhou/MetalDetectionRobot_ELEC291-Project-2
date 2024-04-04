SHELL=cmd
CC=c51

PORT1 = COM20
PORT2 = COM21

# 1 - Controller
# 2 - Device
PROG1 = Controller
SRC1 = Controller.c
#HEADERS1 = device1.h ...
PROG2 = Device
SRC2 = Device.c
#HEADERS2 = device2.h ...
OBJ1 = Controller.obj
OBJ2 = Device.obj



Controller.hex: $(OBJ1)
	$(CC) $(OBJ1)
	@echo hex file made for: $(SRC1)

Device.hex: $(OBJ2)
	$(CC) $(OBJ2)
	@echo hex file made for: $(SRC2)

Controller.obj: $(SRC1) ControllerCore.h ControllerUI.h
	$(CC) -c $(SRC1)

Device.obj: $(SRC2) #$(HEADERS2)
	$(CC) -c $(SRC2)

clean:
	@del $(OBJ1) $(OBJ2) *.asm *.lkr *.lst *.map *.hex *.map 2> nul

Compile_All: Controller.hex Device.hex 

LoadFlash:
	@Taskkill /IM putty.exe /F 2>NUL | wait 500 
	EFM8_prog.exe -ft230 -r -d0 $(PROG1).hex
# move COMPORT.inc COMPORT1.inc
	EFM8_prog.exe -ft230 -r -d1 $(PROG2).hex
	cmd /c start putty -serial $(PORT1) -sercfg 115200,8,n,1,N
	cmd /c start putty -serial $(PORT2) -sercfg 115200,8,n,1,N

putty:
	@Taskkill /IM putty.exe /F 2>NUL | wait 500
	cmd /c start putty -serial $(PORT1) -sercfg 115200,8,n,1,N
	cmd /c start putty -serial $(PORT2) -sercfg 115200,8,n,1,N

Dummy: $(PROG1).hex $(PROG1).Map  $(PROG2).hex $(PROG2).Map
	@echo Nothing to see here!
	
explorer:
	cmd /c start explorer .
		