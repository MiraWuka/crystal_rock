APP_NAME := rainbow
SRC := rainbow.cr
BIN_DIR := ./bin
BUILD_FLAGS := --release

CRYSTAL ?= crystal

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
    TARGET_OS := linux
else ifeq ($(UNAME_S),Darwin)
    TARGET_OS := macos
else
    TARGET_OS := unknown
endif

all: build

.PHONY: build
build:
	@mkdir -p $(BIN_DIR)
	@echo "Building for $(TARGET_OS)..."
	$(CRYSTAL) build $(SRC) $(BUILD_FLAGS) -o $(BIN_DIR)/$(APP_NAME)
	@echo "[+] Done: $(BIN_DIR)/$(APP_NAME)"

.PHONY: debug
debug:
	@mkdir -p $(BIN_DIR)
	@echo "Debug build..."
	$(CRYSTAL) build $(SRC) -o $(BIN_DIR)/$(APP_NAME)-debug
	@echo "Debug binary: $(BIN_DIR)/$(APP_NAME)-debug"

.PHONY: run
run: build
	@echo "Running $(APP_NAME)..."
	$(BIN_DIR)/$(APP_NAME)

.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BIN_DIR)
	rm -rf .crystal
	rm -f *.dwarf
	@echo "[-] Clean"

.PHONY: linux
linux:
	@echo "🐧 Cross-compili

