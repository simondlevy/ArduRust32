# Makfile for ArduRust32 example
#
# Copyright (c) 2023 Simon D. Levy
#
# MIT License


#####################################################
# Choose one of the following triples for your board:
GEN = F4
PNUM = GENERIC_F411CEUX
VARIANT = STM32F4xx/F411C\(C-E\)\(U-Y\)

#GEN = F4
#PNUM = GENERIC_F405RGTX
#VARIANT = STM32F4xx/F405RGT_F415RGT

#GEN = F7
#PNUM = GENERIC_F722RETX
#VARIANT = STM32F7xx/F722R\(C-E\)T_F730R8T_F732RET
#####################################################
	

PROJECT = ArduRust32

RUSTLIB = ./target/thumbv7em-none-eabihf/release/libmath.a

PORT = /dev/ttyACM0

OBJDIR = ./obj

DFU = $(OBJDIR)/$(PROJECT).ino.dfu 

HEX = $(OBJDIR)/$(PROJECT).ino.hex 

ELF = $(OBJDIR)/$(PROJECT).ino.elf

all: $(DFU)

$(DFU): $(HEX)
	./dfuse-pack.py -i $< $@

$(HEX): $(ELF)
	objcopy -O ihex --set-start 0x8000000 $< $@

$(RUSTLIB): src/lib.rs
	cargo build --release

$(ELF): $(PROJECT).ino $(RUSTLIB)
	rm -rf /tmp/arduino-core-cache/
	- arduino-cli compile --fqbn STMicroelectronics:stm32:Gen$(GEN):pnum=$(PNUM),usb=CDCgen --build-path $(OBJDIR)
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
	-Wl,--default-script=$(HOME)/.arduino15/packages/STMicroelectronics/hardware/stm32/2.3.0/variants/$(VARIANT)/ldscript.ld \
	-Wl,--script=$(HOME)/.arduino15/packages/STMicroelectronics/hardware/stm32/2.3.0/system/ldscript.ld \
	-Wl,-Map,./obj/$(PROJECT).ino.map \
	-L$(HOME)/.arduino15/packages/STMicroelectronics/tools/CMSIS/5.7.0/CMSIS/DSP/Lib/GCC/ \
	-larm_cortexM4lf_math \
	-o ./obj/$(PROJECT).ino.elf -L./obj \
	-Wl,--start-group \
	./obj/sketch/*.o \
	./obj/libraries/SrcWrapper/*.o \
	./obj/libraries/SrcWrapper/HAL/*.o \
	./obj/libraries/SrcWrapper/LL/*.o \
	./obj/libraries/SrcWrapper/stm32/*.o \
	./obj/core/*.o \
	$(RUSTLIB) \
	./obj/core.a \
	-lc -Wl,--end-group -lm -lgcc -lstdc++

upload: $(DFU)
	dfu-util -a 0 -D $(DFU) -s :leave	

clean:
	cargo clean
	rm -rf target obj

edit:
	vim $(PROJECT).ino

listen:
	miniterm $(PORT) 115200
