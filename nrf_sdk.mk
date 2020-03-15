NRF = lib/nRF5SDK160098a08e2
NRF_LIB = $(NRF)/components/libraries
NRF_X = $(NRF)/modules/nrfx
NRF_EXTERNAL = $(NRF)/external


INCLUDE_PATHS += \
	-I $(NRF)/components/boards \
	-I $(NRF)/components/toolchain/cmsis/include \
	-I $(NRF)/components/drivers_nrf/nrf_soc_nosd \
	-I $(NRF_X) \
	-I $(NRF_X)/mdk \
	-I $(NRF_X)/hal \
	-I $(NRF)/integration/nrfx \
	-I $(NRF_LIB)/delay \
	-I $(NRF_LIB)/util \
	-I $(NRF_EXTERNAL)/segger_rtt \


SRC_PATH += \
	$(NRF_EXTERNAL)/segger_rtt \

SRC_FILES += \
	$(NRF_X)/mdk/system_nrf52840.c \
	$(NRF)/components/boards/boards.c \
	$(NRF_LIB)/util/app_util_platform.c \

AS_FILES += \
	$(NRF_X)/mdk/gcc_startup_nrf52840.S

COMPILER_FLAGS += \
	-D USE_APP_CONFIG \
	-D BOARD_PCA10056 \
	-D BSP_DEFINES_ONLY \
	-D CONFIG_GPIO_AS_PINRESET \
	-D FLOAT_ABI_HARD \
	-D NRF52840_XXAA \
	-mcpu=cortex-m4 \
	-mthumb -mabi=aapcs \
	-mfloat-abi=hard -mfpu=fpv4-sp-d16 \
	-ffunction-sections -fdata-sections -fno-strict-aliasing \
	-fno-builtin -fshort-enums \


LINKER_FLAGS += \
	-mfloat-abi=hard \
	-mfpu=fpv4-sp-d16 \
	-mthumb -mabi=aapcs \
	-mcpu=cortex-m4 \
	-mfloat-abi=hard -mfpu=fpv4-sp-d16 \
	-l m -l c -l gcc -l nosys \


OUT_COMBINED_HEX = $(OUT_HEX:.hex=-combined.hex)
SOFTDEVICE_HEX = $(NRF)/components/softdevice/s140/hex/s140_nrf52_7.0.1_softdevice.hex

$(OUT_COMBINED_HEX) : $(OUT_HEX)
	@echo SD $@
	$(SILENT) $(SREC_CAT) $(OUT_HEX) -I $(SOFTDEVICE_HEX) -I -o $(OUT_COMBINED_HEX) -I

