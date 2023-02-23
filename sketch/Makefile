SKETCH = sketch

FQBN = STMicroelectronics:stm32:GenF4:pnum=GENERIC_F411CEUX,usb=CDCgen

PORT = /dev/ttyACM0

OBJ = $(PWD)/obj
LIB = ../src
DFU = $(OBJ)/$(SKETCH).dfu 
HEX = $(OBJ)/$(SKETCH).ino.hex

all: $(DFU)
all: $(HEX)

$(DFU): $(HEX)
	./dfuse-pack.py -i $(HEX) $(DFU)

$(HEX): $(SKETCH).ino $(LIB)/*.h
	arduino-cli compile --fqbn $(FQBN) --libraries $(LIB) --build-path $(OBJ)
	rm -f *.bin *.elf

unbrick: $(DFU)
	dfu-util -a 0 -D $(DFU) -s :leave	

flash: $(DFU)
	echo -n 'R' > $(PORT)
	sleep 1
	dfu-util -a 0 -D $(DFU) -s :leave

clean:
	rm -rf obj

edit:
	vim $(SKETCH).ino

listen:
	miniterm $(PORT) 115200

