################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/os/rtos/source/subdir.mk
-include src/os/rtos/ports/xt804/subdir.mk
-include src/os/rtos/subdir.mk
-include src/network/lwip2.0.3/netif/subdir.mk
-include src/network/lwip2.0.3/core/ipv6/subdir.mk
-include src/network/lwip2.0.3/core/ipv4/subdir.mk
-include src/network/lwip2.0.3/core/subdir.mk
-include src/network/lwip2.0.3/api/subdir.mk
-include src/network/lwip2.0.3/subdir.mk
-include src/network/api2.0.3/subdir.mk
-include src/app/wm_atcmd/subdir.mk
-include src/app/web/subdir.mk
-include src/app/sslserver/subdir.mk
-include src/app/ping/subdir.mk
-include src/app/ota/subdir.mk
-include src/app/oneshotconfig/subdir.mk
-include src/app/ntp/subdir.mk
-include src/app/mqtt/subdir.mk
-include src/app/mbedtls/ports/subdir.mk
-include src/app/mbedtls/library/subdir.mk
-include src/app/matrixssl/core/subdir.mk
-include src/app/matrixssl/subdir.mk
-include src/app/mDNS/mDNSPosix/subdir.mk
-include src/app/mDNS/mDNSCore/subdir.mk
-include src/app/libwebsockets-2.1-stable/subdir.mk
-include src/app/library/subdir.mk
-include src/app/iperf/subdir.mk
-include src/app/httpclient/subdir.mk
-include src/app/dnsserver/subdir.mk
-include src/app/dhcpserver/subdir.mk
-include src/app/cJSON/subdir.mk
-include src/subdir.mk
-include platform/sys/subdir.mk
-include platform/drivers/watchdog/subdir.mk
-include platform/drivers/uart/subdir.mk
-include platform/drivers/timer/subdir.mk
-include platform/drivers/spi/subdir.mk
-include platform/drivers/sasc/subdir.mk
-include platform/drivers/rtc/subdir.mk
-include platform/drivers/pwm/subdir.mk
-include platform/drivers/pmu/subdir.mk
-include platform/drivers/irq/subdir.mk
-include platform/drivers/io/subdir.mk
-include platform/drivers/internalflash/subdir.mk
-include platform/drivers/i2s/subdir.mk
-include platform/drivers/i2c/subdir.mk
-include platform/drivers/gpio/subdir.mk
-include platform/drivers/flash/subdir.mk
-include platform/drivers/efuse/subdir.mk
-include platform/drivers/dma/subdir.mk
-include platform/drivers/cpu/subdir.mk
-include platform/drivers/adc/subdir.mk
-include platform/drivers/7816/subdir.mk
-include platform/common/utils/subdir.mk
-include platform/common/task/subdir.mk
-include platform/common/params/subdir.mk
-include platform/common/mem/subdir.mk
-include platform/common/fwup/subdir.mk
-include platform/common/crypto/symmetric/subdir.mk
-include platform/common/crypto/pubkey/subdir.mk
-include platform/common/crypto/prng/subdir.mk
-include platform/common/crypto/math/subdir.mk
-include platform/common/crypto/keyformat/subdir.mk
-include platform/common/crypto/digest/subdir.mk
-include platform/common/crypto/subdir.mk
-include platform/arch/xt804/minilibc/subdir.mk
-include platform/arch/xt804/bsp/subdir.mk
-include demo/console/subdir.mk
-include demo/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: w800.elf w800.ihex w800.bin

# Output Target
w800.ihex: w800.elf
	@echo 'Outputing file $@'
	@csky-elfabiv2-objcopy -O ihex "$<" "$@"

w800.bin: w800.elf
	@echo 'Outputing file $@'
	@csky-elfabiv2-objcopy -O binary "$<" "$@"

# Tool invocations
w800.elf: $(OBJS) $(USER_OBJS) D:\work-document\Seafile\20200606\1_SDK\wm_sdk_w800_20200605\ld\w800\gcc_csky.ld
	@echo 'Building target: $@'
	@csky-elfabiv2-gcc -mcpu=ck804ef -nostartfiles -Wl,--gc-sections    -L../../../../../../../lib/w800 -Wl,-zmax-page-size=1024 -mhard-float -T"D:\work-document\Seafile\20200606\1_SDK\wm_sdk_w800_20200605\ld\w800\gcc_csky.ld" -o "w800.elf" $(OBJS) $(USER_OBJS) $(LIBS) -Wl,-Map='$(@:%.elf=%.map)' 
	@echo ' '
	@echo 'Size of $@:'
	@csky-elfabiv2-size "$@"
	@echo ' '
	$(MAKE) --no-print-directory post-build

# Other Targets
clean:
	-$(RM) w800.ihex w800.bin w800.map
	-$(RM) $(OBJS)$(C_DEPS)$(ASM_DEPS)$(S_DEPS)$(S_UPPER_DEPS) w800.elf
	-@echo ' '

post-build:
	-sh ../$(ProjectPath)/../../../../../../tools/w800/utilities//aft_build_project.sh
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY: post-build

-include ../makefile.targets
