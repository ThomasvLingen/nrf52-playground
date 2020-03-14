SILENT = @

# Compiler
CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc
LD = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SREC_CAT = srec_cat

# Path for the resulting file
BUILD_PATH = build/
PROGRAM_NAME = nrf52-blinky

# Compiler flags
INCLUDE_PATHS = -Isrc/
COMPILER_FLAGS = -Wall -Werror -O0 -g3 $(INCLUDE_PATHS)

# Linker flags
LIBS =
LINKER_FLAGS = -T generic_gcc_nrf52.ld


OUT_ELF = $(BUILD_PATH)$(PROGRAM_NAME).elf
OUT_HEX = $(OUT_ELF:.elf=.hex)

# Files to compile
SRC_PATH = src/

SRC_FILES += $(shell find $(SRC_PATH) -name '*.c')
AS_FILES +=
OBJ_FILES = $(SRC_FILES:.c=.o) $(AS_FILES:.S=.o)

# Get nrf sdk dependant stuff
include nrf_sdk.mk


# Compile stuff
%.o : %.c
	@echo CC $<
	$(SILENT) $(CC) -c $< $(COMPILER_FLAGS) -o $@

%.o : %.S
	@echo AS $<
	$(SILENT) $(AS) -c $< $(COMPILER_FLAGS) -o $@

all : $(OUT_ELF) $(OUT_HEX) $(OUT_COMBINED_HEX)

$(OUT_ELF) : $(OBJ_FILES)
	@echo
	mkdir -p $(BUILD_PATH)
	@echo LD $@
	$(SILENT) $(LD) $(OBJ_FILES) $(LINKER_FLAGS) $(LIBS) -o $(OUT_ELF)

$(OUT_HEX) : $(OUT_ELF)
	@echo HX $@
	$(SILENT) $(OBJCOPY) -O ihex $(OUT_ELF) $(OUT_HEX)

.PHONY: clean
clean:
	@echo "Cleaning build"
	rm -rf $(OBJ_FILES)
	rm -rf $(BUILD_PATH)*

