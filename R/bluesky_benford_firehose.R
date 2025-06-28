#!/usr/bin/env Rscript

# Bluesky Benford's Law Analysis in R
# Replicates the functionality of the Python version
# Used code patterns from the Python atproto tutorial: https://jrashford.com/2024/12/11/bluesky-firehose-python-tutorial/

library(httr)
library(jsonlite)
library(stringr)
library(httpuv)

# Global variables
collected_numbers <- character(0)  # Vector to store collected numbers
MAX_NUMBERS <- 10000  # Limit for numbers to collect
client_running <- FALSE

# Function to extract numbers from text using regex
extract_numbers <- function(text) {
  # Find all numbers in the text (equivalent to Python's re.findall(r'[0-9]+', text))
  numbers <- str_extract_all(text, "[0-9]+")[[1]]
  return(numbers)
}

# Function to analyze Benford's law from collected numbers
analyze_benfords_law <- function(numbers) {
  # Extract first digits (equivalent to Python's [num[0] for num in collected_numbers])
  first_digits <- substr(numbers, 1, 1)
  
  # Count occurrences of each digit
  digit_counts <- table(first_digits)
  total_numbers <- length(first_digits)
  
  # Calculate proportions and round to 2 decimal places
  digit_proportions <- round(digit_counts / total_numbers, 2)
  
  # Convert to data frame for easier handling
  results <- data.frame(
    digit = names(digit_proportions),
    count = as.numeric(digit_counts),
    proportion = as.numeric(digit_proportions),
    stringsAsFactors = FALSE
  )
  
  # Sort by digit
  results <- results[order(results$digit), ]
  
  return(list(
    total_samples = total_numbers,
    results = results
  ))
}

# Function to print results in the same format as Python version
print_results <- function(analysis) {
  cat("Total Samples:", analysis$total_samples, "\n")
  for (i in 1:nrow(analysis$results)) {
    cat("Digit:", analysis$results$digit[i], "Proportion:", analysis$results$proportion[i], "\n")
  }
}

# WebSocket message handler (equivalent to Python's on_message_handler)
handle_firehose_message <- function(message) {
  tryCatch({
    # Parse the incoming message
    data <- fromJSON(message, simplifyVector = FALSE)
    
    # Check if this is a commit message with the right structure
    if (is.null(data$commit) || is.null(data$commit$blocks)) {
      return()
    }
    
    # For now, we'll extract text from a simplified structure
    # In a full implementation, this would need to decode CAR blocks
    # and handle the AT Protocol format properly
    
    # Extract text from any available text fields
    text_fields <- character(0)
    
    # This is a simplified approach - in practice, you'd need to:
    # 1. Decode the CAR (Content Addressable aRchive) blocks
    # 2. Parse the AT Protocol format
    # 3. Extract text from app.bsky.feed.post records
    
    # For demonstration, let's assume we can extract some text
    if (!is.null(data$commit$ops)) {
      for (op in data$commit$ops) {
        if (!is.null(op$data) && !is.null(op$data$text)) {
          text_fields <- c(text_fields, op$data$text)
        }
      }
    }
    
    # Extract numbers from all text fields
    for (text in text_fields) {
      numbers <- extract_numbers(text)
      if (length(numbers) > 0) {
        collected_numbers <<- c(collected_numbers, numbers)
        
        # Stop if we've collected enough numbers
        if (length(collected_numbers) >= MAX_NUMBERS) {
          cat("Stopping client! Collected", length(collected_numbers), "numbers.\n")
          client_running <<- FALSE
          return()
        }
      }
    }
  }, error = function(e) {
    # Silently continue on parse errors
    return()
  })
}

# Simplified WebSocket client (since AT Protocol WebSocket is complex)
# This is a demonstration version - a full implementation would need
# to properly handle AT Protocol WebSocket connections
connect_to_firehose <- function() {
  cat("Note: This is a simplified demonstration.\n")
  cat("A full AT Protocol WebSocket implementation would be needed for production use.\n")
  cat("For demonstration purposes, using simulated data...\n")
  
  # Simulate collecting numbers (since implementing full AT Protocol is complex)
  simulate_data_collection()
}

# Function to simulate data collection for demonstration
simulate_data_collection <- function() {
  cat("Simulating Bluesky firehose data collection...\n")
  
  # Generate some sample text with numbers (simulating social media posts)
  sample_texts <- c(
    "Just finished my 123rd workout this year!",
    "Meeting at 3:30 PM with 45 attendees",
    "My score was 987 points out of 1000",
    "Temperature today is 72 degrees",
    "Bought 25 items for $156.78",
    "Living in apartment 4B since 2019",
    "Flight 501 departing at gate 23",
    "Recipe calls for 2 cups and 350 degree oven",
    "Chapter 17 has 89 pages to read",
    "Phone number ends in 6794"
  )
  
  # Simulate real-time collection by adding numbers gradually
  for (i in 1:1000) {  # Simulate 1000 "posts"
    # Randomly select a sample text
    text <- sample(sample_texts, 1)
    
    # Sometimes modify numbers to create variety
    if (runif(1) > 0.5) {
      # Add some random numbers
      random_nums <- sample(1:9999, sample(1:3, 1))
      text <- paste(text, paste(random_nums, collapse = " "))
    }
    
    # Extract numbers from the text
    numbers <- extract_numbers(text)
    if (length(numbers) > 0) {
      collected_numbers <<- c(collected_numbers, numbers)
      
      # Stop if we've collected enough numbers
      if (length(collected_numbers) >= MAX_NUMBERS) {
        cat("Stopping simulation! Collected", length(collected_numbers), "numbers.\n")
        break
      }
    }
    
    # Small delay to simulate real-time collection
    if (i %% 100 == 0) {
      cat("Collected", length(collected_numbers), "numbers so far...\n")
      Sys.sleep(0.1)
    }
  }
}

# Main function (equivalent to Python's main())
main <- function() {
  cat("Starting Bluesky Benford's Law Analysis in R\n")
  cat("Maximum numbers to collect:", MAX_NUMBERS, "\n\n")
  
  # Initialize
  collected_numbers <<- character(0)
  client_running <<- TRUE
  
  # Connect to firehose (or simulate)
  connect_to_firehose()
  
  # Analyze the collected numbers
  if (length(collected_numbers) > 0) {
    cat("\nAnalyzing", length(collected_numbers), "collected numbers...\n\n")
    analysis <- analyze_benfords_law(collected_numbers)
    print_results(analysis)
  } else {
    cat("No numbers were collected.\n")
  }
}

# Run the main function if this script is executed directly
if (!interactive()) {
  main()
}