#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Test counter
TESTS=0
PASSED=0
FAILED=0

# Function to run a test
run_test() {
    local description="$1"
    local command="$2"
    local expected_exit="$3"
    local expected_output="$4"
    
    TESTS=$((TESTS + 1))
    echo -n "Test $TESTS: $description... "
    
    # Run the command and capture output and exit code
    output=$(eval "$command" 2>&1)
    exit_code=$?
    
    # Check if exit code matches expected
    if [ $exit_code -eq $expected_exit ]; then
        # If we have expected output, check if it's in the actual output
        if [ -n "$expected_output" ]; then
            if echo "$output" | grep -q "$expected_output"; then
                echo -e "${GREEN}PASS${NC}"
                PASSED=$((PASSED + 1))
            else
                echo -e "${RED}FAIL${NC}"
                echo "Expected output containing: '$expected_output'"
                echo "Got: '$output'"
                FAILED=$((FAILED + 1))
            fi
        else
            echo -e "${GREEN}PASS${NC}"
            PASSED=$((PASSED + 1))
        fi
    else
        echo -e "${RED}FAIL${NC}"
        echo "Expected exit code: $expected_exit"
        echo "Got exit code: $exit_code"
        echo "Output: $output"
        FAILED=$((FAILED + 1))
    fi
}

# Create a temporary directory for test files
TEST_DIR=$(mktemp -d)
trap 'rm -rf "$TEST_DIR"' EXIT

# Create a dummy resume file for testing
echo "# Test Resume" > "$TEST_DIR/test.md"

# Test cases
echo "Running error handling tests..."

# Test 1: No arguments
run_test "No arguments provided" \
    "docker run -v $TEST_DIR:/resume ghcr.io/ruancomelli/pandoc-resume-docker" \
    1 \
    "Input file is required"

# Test 2: Unknown option
run_test "Unknown option provided" \
    "docker run -v $TEST_DIR:/resume ghcr.io/ruancomelli/pandoc-resume-docker -x" \
    1 \
    "Unknown option '-x'"

# Test 3: Unknown long option
run_test "Unknown long option provided" \
    "docker run -v $TEST_DIR:/resume ghcr.io/ruancomelli/pandoc-resume-docker --unknown" \
    1 \
    "Unknown option '--unknown'"

# Test 4: Non-existent input file
run_test "Non-existent input file" \
    "docker run -v $TEST_DIR:/resume ghcr.io/ruancomelli/pandoc-resume-docker nonexistent.md" \
    1 \
    "Input file '/resume/nonexistent.md' not found"

# Test 5: Help option
run_test "Help option" \
    "docker run -v $TEST_DIR:/resume ghcr.io/ruancomelli/pandoc-resume-docker --help" \
    0 \
    "Usage:"

# Print summary
echo
echo "Test Summary:"
echo "Total tests: $TESTS"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"

# Exit with failure if any tests failed
[ $FAILED -eq 0 ] 