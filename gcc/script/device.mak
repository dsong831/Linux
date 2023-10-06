############################################################
## 	CROSS COMPILER
############################################################
CROSS 		?= arm-none-eabi-
CC		:= "$(PATH_TOOLCHAIN_WINDOWS)\$(CROSS)gcc"
AS		:= "$(PATH_TOOLCHAIN_WINDOWS)\$(CROSS)as"
AR		:= "$(PATH_TOOLCHAIN_WINDOWS)\$(CROSS)ar"
LD		:= "$(PATH_TOOLCHAIN_WINDOWS)\$(CROSS)ld"
NM		:= "$(PATH_TOOLCHAIN_WINDOWS)\$(CROSS)nm"
OBJDUMP		:= "$(PATH_TOOLCHAIN_WINDOWS)\$(CROSS)objdump"
OBJCOPY		:= "$(PATH_TOOLCHAIN_WINDOWS)\$(CROSS)objcopy"
SIZE		:= "$(PATH_TOOLCHAIN_WINDOWS)\$(CROSS)size"
############################################################
## 	BASE FLAGS
############################################################
BASE_AFLAGS 	:= $(ARCH_FLAGS)
BASE_CFLAGS 	:= $(ARCH_FLAGS) -Wall -Wextra -std=gnu99 -O1
BASE_LDFLAGS 	:= $(ARCH_FLAGS) -T$(USER_LINKER_SCRIPT) --specs=nano.specs -lgcc -lc -lnosys -Wl,--gc-sections
############################################################
## 	DEFAULT DIR
############################################################
DIR_BUILD 		:= build
DIR_BUILD_OBJECTS 	:= build/objects
############################################################
## 	HELP/ALL/CLEAN COMMAND
############################################################
.PHONY: help all clean
help:
	@echo "############# HELP #################"
	@echo "## make all   : Build all targets ##"
	@echo "## make clean : Clean objects     ##"
	@echo "####################################"
all: clean create_build_directory build_objects
clean: remove_build_directory
############################################################
## 	DIRECTORY COMMAND
############################################################
.PHONY: create_build_directory remove_build_directory
create_build_directory:
	@echo "## create_build_directory ##"
	@mkdir -p $(DIR_TARGET_BASE)/$(DIR_BUILD_OBJECTS)
	@chmod -R 777 $(DIR_TARGET_BASE)/$(DIR_BUILD)
remove_build_directory:
	@echo "## remove_build_directory ##"
	@rm -rf $(DIR_TARGET_BASE)/$(DIR_BUILD)

############################################################
##
## 	BUILD COMMAND
##
############################################################
USER_INCS 		:= $(addprefix -I,$(USER_INCS))
USER_DEFS 		:= $(addprefix -D,$(USER_DEFS))

OBJECTS 		:= $(USER_ASMS:.s=.o) $(USER_SRCS:.c=.o)
LINK_OBJECTS 		:= $(addprefix $(DIR_TARGET_BASE)/$(DIR_BUILD_OBJECTS)/,$(notdir $(OBJECTS)))
MAP_FILE 		:= $(DIR_TARGET_BASE)/$(DIR_BUILD)/$(TARGET).map
ELF_FILE 		:= $(DIR_TARGET_BASE)/$(DIR_BUILD)/$(TARGET).elf
BIN_FILE 		:= $(DIR_TARGET_BASE)/$(DIR_BUILD)/$(TARGET).bin
HEX_FILE 		:= $(DIR_TARGET_BASE)/$(DIR_BUILD)/$(TARGET).hex


.PHONY: build_objects
build_objects: $(OBJECTS) $(ELF_FILE) $(BIN_FILE) $(HEX_FILE)
	@echo "## Build Complete  ##"
	@echo " >> sources : $(notdir $(USER_ASMS)) $(notdir $(USER_SRCS))"
	@echo " >> objects : $(notdir $(OBJECTS))"
	@echo " >> elf     : $(ELF_FILE)"
	@echo " >> bin     : $(BIN_FILE)"
	@echo " >> hex     : $(HEX_FILE)"

%.o: %.s
	@echo [Compile... $(notdir $<)... ]
	@$(CC) $(BASE_CFLAGS) $(USER_AFLAGS) -c $< -o $@
	@mv $@ $(DIR_TARGET_BASE)/$(DIR_BUILD_OBJECTS)/

%.o: %.c
	@echo [Compile... $(notdir $<)... ]
	@$(CC) $(BASE_CFLAGS) $(USER_CFLAGS) $(USER_INCS) $(USER_DEFS) -c $< -o $@
	@mv $@ $(DIR_TARGET_BASE)/$(DIR_BUILD_OBJECTS)/

$(ELF_FILE): $(LINK_OBJECTS)
	@echo [Linking... $(notdir $@) ]
	@$(CC) $^ $(BASE_LDFLAGS) $(USER_LDFLAGS) -o $@ -Xlinker -Map=$(MAP_FILE)
	@$(SIZE) $@

$(BIN_FILE): $(ELF_FILE)
	@echo [Creating... $(notdir $(BIN_FILE)) ]
	@$(OBJCOPY) -O binary $^ $(BIN_FILE)
	@echo [Creating... $(notdir $(HEX_FILE)) ]
	@$(OBJCOPY) -O ihex $^ $(HEX_FILE)
    
