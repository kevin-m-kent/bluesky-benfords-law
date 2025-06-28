#!/usr/bin/env Rscript

# Simple test to verify R implementation functionality
source("bluesky_benford_firehose.R")

# Test the core functions
cat("Testing R Benford implementation...\n")

# Test number extraction
test_text <- "Meeting at 3:30 PM with 45 attendees in room 123"
numbers <- extract_numbers(test_text)
cat("Extracted numbers:", paste(numbers, collapse=", "), "\n")

# Test analysis with known data
test_numbers <- c("123", "456", "789", "111", "222", "333", "101", "201", "301", "121")
analysis <- analyze_benfords_law(test_numbers)

cat("Test analysis results:\n")
print_results(analysis)

cat("\nR implementation test completed successfully!\n")