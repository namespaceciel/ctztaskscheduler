PROJECT_SOURCE_DIR := $(abspath ./)
BUILD_DIR ?= $(PROJECT_SOURCE_DIR)/build
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
    NUM_JOB := $(shell nproc)
else ifeq ($(UNAME_S), Darwin)
    NUM_JOB := $(shell sysctl -n hw.ncpu)
else
    NUM_JOB := 1
endif

clean:
	rm -rf $(BUILD_DIR)
.PHONY: clean

test:
	cmake -S . -B $(BUILD_DIR) && \
	cmake --build $(BUILD_DIR) --target ctz_test -j $(NUM_JOB) && \
	$(BUILD_DIR)/ctz_test
.PHONY: test

e1:
	cmake -S . -B $(BUILD_DIR) && \
	cmake --build $(BUILD_DIR) --target ctz_ticket_example -j $(NUM_JOB) && \
	$(BUILD_DIR)/ctz_ticket_example

e2:
	cmake -S . -B $(BUILD_DIR) && \
	cmake --build $(BUILD_DIR) --target ctz_waitgroup_example -j $(NUM_JOB) && \
	$(BUILD_DIR)/ctz_waitgroup_example

e3:
	cmake -S . -B $(BUILD_DIR) && \
	cmake --build $(BUILD_DIR) --target ctz_event_example -j $(NUM_JOB) && \
	$(BUILD_DIR)/ctz_event_example

format:
	./format.sh run $(PROJECT_SOURCE_DIR)/include $(PROJECT_SOURCE_DIR)/src $(PROJECT_SOURCE_DIR)/test $(PROJECT_SOURCE_DIR)/example
.PHONY: format

check_format:
	./format.sh check $(PROJECT_SOURCE_DIR)/include $(PROJECT_SOURCE_DIR)/src $(PROJECT_SOURCE_DIR)/test $(PROJECT_SOURCE_DIR)/example
.PHONY: check_format
