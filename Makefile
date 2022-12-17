define say
$(info [Project 1] $1)
endef

CC := g++
CC_FLAGS := -std=c++17 -Wall -g

# Determine some more paths
HOSTNAME := $(shell hostname)
SUBMISSION_DIR := .
RESULTS_JSON := ./results.json
RESULTS_JSON_FOR_GRADESCOPE := /autograder/results/results.json

$(call say,Hostname: $(HOSTNAME))
$(call say,Submission dir: $(SUBMISSION_DIR))
$(call say,Results path: $(RESULTS_JSON))
$(call say,Results path: $(RESULTS_JSON_FOR_GRADESCOPE))
#######


# Binary names
BIN_NAME := main
BIN := ./$(BIN_NAME)
#
TESTS_BIN_NAME := main-tests
TESTS_BIN := ./$(TESTS_BIN_NAME)


$(info )


#
default: help
.PHONY: default


#
help:
	@echo "***** Makefile Menu *****"
	@echo
	@echo "make build         ==> Build source files"
	@echo
	@echo "make run           ==> Run the debugging sandbox"
	@echo "make debug         ==> Debug the debugging sandbox"
	@echo
	@echo "make test          ==> Run tests against your dynamic vector"
	@echo "make debug-test    ==> Debug the tests run against your dynamic vector"
	@echo
	@echo "make clean         ==> Clean temporary build files"
.PHONY: help


# Run the debug sandbox
run:	$(BIN)
	$(BIN)
.PHONY: run


# Debug the debug sandbox
debug:	$(BIN)
	gdb $(BIN) -ex run
.PHONY: debug


# Build everything
build:	$(BIN) $(TESTS_BIN)
.PHONY: build


# Run tests
gradescope: clean
gradescope: test
tests: test
test: $(TESTS_BIN)
	$(TESTS_BIN)
.PHONY: tests test gradescope


# Debug the tests
debug-tests:		debug-test
debug-test:	$(TESTS_BIN)
	gdb $(TESTS_BIN) -ex run
.PHONY: debug-tests debug-test


# Build the main binary
$(BIN):	$(SUBMISSION_DIR)/main.cpp
	$(CC) $(CC_FLAGS) $^ -o "$@"


# Build the test binary
$(TESTS_BIN):	$(SUBMISSION_DIR)/CPP_Tests.cpp
	$(CC) $(CC_FLAGS) $^ -o "$@"


#
clean:
	-rm -f $(BIN)
	-rm -f $(TESTS_BIN)
	-rm -f $(RESULTS_JSON)
.PHONY: clean



