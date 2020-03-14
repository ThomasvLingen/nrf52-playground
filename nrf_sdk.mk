NRF = lib/nRF5SDK160098a08e2
NRF_LIB = $(NRF)/components/libraries
NRF_X = $(NRF)/modules/nrfx

BOILERPLATE_INCLUDE = \
	-I $(NRF)/components/boards \
	-I $(NRF)/components/toolchain/cmsis/include \
	-I $(NRF)/components/drivers_nrf/nrf_soc_nosd \


BOILERPLATE_SRC_FILES = \
	$(NRF_X)/mdk/system_nrf52840.c \
	$(NRF)/components/boards/boards.c \


INCLUDE_PATHS += \
	$(BOILERPLATE_INCLUDE) \
	-I $(NRF_X) \
	-I $(NRF_X)/mdk \
	-I $(NRF_X)/hal \
	-I $(NRF)/integration/nrfx \
	-I $(NRF_LIB)/delay \
	-I $(NRF_LIB)/util \
	-I $(NRF_LIB)/log \
	-I $(NRF_LIB)/log/src \
	-I $(NRF_LIB)/experimental_section_vars \
	-I $(NRF_LIB)/strerror \
	-I $(NRF_LIB)/balloc \
	-I $(NRF_LIB)/atomic \


SRC_FILES += \
	$(BOILERPLATE_SRC_FILES) \
	$(NRF)/external/fprintf/nrf_fprintf.c \
	$(NRF)/external/fprintf/nrf_fprintf_format.c \
	$(NRF_X)/soc/nrfx_atomic.c \
	$(NRF_LIB)/log/src/nrf_log_frontend.c \
	$(NRF_LIB)/log/src/nrf_log_str_formatter.c \
	$(NRF_LIB)/util/app_error.c \
	$(NRF_LIB)/util/app_error_handler_gcc.c \
	$(NRF_LIB)/util/app_error_weak.c \
	$(NRF_LIB)/util/app_util_platform.c \
	$(NRF_LIB)/util/nrf_assert.c \
	$(NRF_LIB)/atomic/nrf_atomic.c \
	$(NRF_LIB)/balloc/nrf_balloc.c \
	$(NRF_LIB)/memobj/nrf_memobj.c \
	$(NRF_LIB)/ringbuf/nrf_ringbuf.c \
	$(NRF_LIB)/strerror/nrf_strerror.c \

AS_FILES += \
	$(NRF_X)/mdk/gcc_startup_nrf52840.S

COMPILER_FLAGS += \
	-DBOARD_PCA10056 \
	-DBSP_DEFINES_ONLY \
	-DCONFIG_GPIO_AS_PINRESET \
	-DFLOAT_ABI_HARD \
	-DNRF52840_XXAA \
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
	-lm -lc -lgcc -lnosys \

OUT_COMBINED_HEX = $(OUT_HEX:.hex=-combined.hex)
SOFTDEVICE_HEX = $(NRF)/components/softdevice/s140/hex/s140_nrf52_7.0.1_softdevice.hex

$(OUT_COMBINED_HEX) : $(OUT_HEX)
	@echo SD $@
	$(SILENT) $(SREC_CAT) $(OUT_HEX) -I $(SOFTDEVICE_HEX) -I -o $(OUT_COMBINED_HEX) -I

