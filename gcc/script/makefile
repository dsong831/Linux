############################################################
## 	TOOLCHAIN / ARCH_FLAGS / TARGET / DIR
############################################################
PATH_TOOLCHAIN_LINUX 	:= /opt/toolchains/gcc-arm-none-eabi-10.3-2021.10/bin
PATH_TOOLCHAIN_WINDOWS 	:= C:\Program Files (x86)\GNU Arm Embedded Toolchain\10 2021.10\bin
ARCH_FLAGS 		:= -mcpu=cortex-m3 -mthumb -mthumb-interwork -mapcs-frame -ggdb3

TARGET 			:= app
DIR_TARGET_BASE 	:= .

############################################################
## 	USER FLAGS
############################################################
USER_AFLAGS 		+=
USER_CFLAGS 		+=
USER_LDFLAGS 		+=

############################################################
##
## 	USER DIRECTORY STRUCTURE
##
############################################################
############################################################
## 	USER LINKER SCRIPT
############################################################
USER_LINKER_SCRIPT 	:= $(DIR_TARGET_BASE)/gcc_arm.ld

############################################################
## 	USER SOURCES
############################################################
USER_ASMS 		+= $(DIR_TARGET_BASE)/startup_gcc_arm.s

USER_SRCS 		+= $(DIR_TARGET_BASE)/../src/main.c

############################################################
## 	USER INCLUDES
############################################################
USER_INCS 		+= $(DIR_TARGET_BASE)/../inc

############################################################
## 	USER DEFINES
############################################################
USER_DEFS 		+= DEVICE

include ./device.mak

