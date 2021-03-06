KERNELRELEASE ?= $(shell uname -r)
BUILD_KERNEL_PATH ?= /lib/modules/$(KERNELRELEASE)/build
INSTALL_MOD_PATH ?= $(INSTALL_PATH)/lib/modules/$(KERNELRELEASE)
INSTALL_PN5XX_I2C_PATH ?= $(INSTALL_MOD_PATH)/kernel/drivers/nfc

obj-m := pn5xx_i2c.o
nxp-pn5xx-objs := pn5xx_i2c.o

all: pn5xx_i2c.ko

pn5xx_i2c.ko: pn5xx_i2c.c pn5xx_i2c.h
	@echo "Compiling kernel module"
	$(MAKE) -C $(BUILD_KERNEL_PATH) M=$(CURDIR) modules

install: all
	mkdir -p $(INSTALL_PN5XX_I2C_PATH)
	install -m 644 pn5xx_i2c.ko $(INSTALL_PN5XX_I2C_PATH)

clean:
	$(MAKE) -C $(BUILD_KERNEL_PATH) M=$(CURDIR) clean

.PHONY: all install clean
.EXPORT_ALL_VARIABLES:
