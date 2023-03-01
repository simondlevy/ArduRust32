SKETCH = sketch

FQBN = STMicroelectronics:stm32:GenF4:pnum=GENERIC_F411CEUX,usb=CDCgen

PORT = /dev/ttyACM0

OBJDIR = $(PWD)/obj

DFU = $(OBJDIR)/$(SKETCH).ino.dfu 

HEX = $(OBJDIR)/$(SKETCH).ino.hex 

ELF = $(OBJDIR)/$(SKETCH).ino.elf

all: $(DFU)

$(DFU): $(HEX)
	./dfuse-pack.py -i $< $@

$(HEX): $(ELF)
	objcopy -O ihex --set-start 0x8000000 $< $@

$(ELF): $(SKETCH).ino
	rm -rf /tmp/arduino-core-cache/
	arduino-cli compile --fqbn $(FQBN) --build-path $(OBJDIR)
	mv /tmp/arduino-core-cache/*.a obj/core.a
	$(HOME)/.arduino15/packages/STMicroelectronics/tools/xpack-arm-none-eabi-gcc/10.3.1-2.3/bin/arm-none-eabi-gcc \
	-mcpu=cortex-m4 \
	-mfpu=fpv4-sp-d16 \
	-mfloat-abi=hard \
	-mthumb \
	-Os \
	-DNDEBUG \
	--specs=nano.specs \
	-Wl,--defsym=LD_FLASH_OFFSET=0 \
	-Wl,--defsym=LD_MAX_SIZE=524288 \
	-Wl,--defsym=LD_MAX_DATA_SIZE=131072 \
	-Wl,--cref \
	-Wl,--check-sections \
	-Wl,--gc-sections \
	-Wl,--entry=Reset_Handler \
	-Wl,--unresolved-symbols=report-all \
	-Wl,--warn-common \
	-Wl,--default-script=$(HOME)/.arduino15/packages/STMicroelectronics/hardware/stm32/2.3.0/variants/STM32F4xx/F411C\(C-E\)\(U-Y\)/ldscript.ld \
	-Wl,--script=$(HOME)/.arduino15/packages/STMicroelectronics/hardware/stm32/2.3.0/system/ldscript.ld \
	-Wl,-Map,./obj/sketch.ino.map -L$(HOME)/.arduino15/packages/STMicroelectronics/tools/CMSIS/5.7.0/CMSIS/DSP/Lib/GCC/ -larm_cortexM4lf_math -o ./obj/sketch.ino.elf -L./obj \
	-Wl,--start-group \
	./obj/sketch/*.o \
	./obj/libraries/SrcWrapper/*.o \
	./obj/libraries/SrcWrapper/HAL/*.o \
	./obj/libraries/SrcWrapper/LL/*.o \
	./obj/libraries/SrcWrapper/stm32/*.o \
	./obj/core/*.o \
	./libmath.a \
	./obj/core.a \
	-lc -Wl,--end-group -lm -lgcc -lstdc++

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

