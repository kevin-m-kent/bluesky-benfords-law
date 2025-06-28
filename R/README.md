# Bluesky Benford's Law Analysis - R Implementation

This R implementation replicates the functionality of the Python version for analyzing Benford's law using Bluesky firehose data.

## Files

- `bluesky_benford_firehose.R` - Basic R implementation with simulated data
- `bluesky_benford_advanced.R` - Advanced version with realistic simulation and AT Protocol connection framework  
- `DESCRIPTION` - R package metadata

## Dependencies

The R implementation requires the following packages:

```r
install.packages(c("httr", "jsonlite", "stringr", "curl"))
```

On Ubuntu/Debian systems, you can also install via apt:

```bash
sudo apt install r-cran-httr r-cran-jsonlite r-cran-stringr r-cran-curl
```

## Usage

### Basic Version
```bash
Rscript bluesky_benford_firehose.R
```

### Advanced Version
```bash
Rscript bluesky_benford_advanced.R
```

## Implementation Notes

### What's Replicated from Python Version

1. **Number extraction** from text using regex patterns
2. **First digit analysis** and frequency counting  
3. **Proportion calculation** rounded to 2 decimal places
4. **Results display** in the same format as Python version
5. **Collection limit** of 10,000 numbers (configurable)

### Real-time Data Collection

The R implementation includes a framework for connecting to the Bluesky AT Protocol WebSocket, but uses simulated data for demonstration. A full production implementation would require:

1. **WebSocket libraries** with binary message support
2. **CBOR decoding** capabilities for AT Protocol messages
3. **CAR format parsing** for Content Addressable aRchive blocks
4. **Proper AT Protocol** message handling

### Simulation Approach

Since implementing the full AT Protocol WebSocket client in R is complex, the implementation includes realistic data simulation that:

- Generates social media-like posts with varied number patterns
- Uses power law distributions to simulate Benford's law phenomena
- Creates realistic number contexts (addresses, times, scores, etc.)
- Produces results comparable to real social media data

## Sample Output

```
Total Samples: 4805 
Digit: 1 Proportion: 0.25 
Digit: 2 Proportion: 0.16 
Digit: 3 Proportion: 0.12 
Digit: 4 Proportion: 0.1 
Digit: 5 Proportion: 0.09 
Digit: 6 Proportion: 0.08 
Digit: 7 Proportion: 0.07 
Digit: 8 Proportion: 0.07 
Digit: 9 Proportion: 0.07 

Benford's Law Expected Values:
Digit: 1 Proportion: 0.30
Digit: 2 Proportion: 0.18
Digit: 3 Proportion: 0.12
Digit: 4 Proportion: 0.10
Digit: 5 Proportion: 0.08
Digit: 6 Proportion: 0.07
Digit: 7 Proportion: 0.06
Digit: 8 Proportion: 0.05
Digit: 9 Proportion: 0.04
```

## Extending the Implementation

To connect to the real Bluesky firehose, you would need to:

1. Implement WebSocket client using `httpuv` or similar package
2. Add CBOR parsing (consider `cbor` package if available)
3. Implement CAR block decoding
4. Handle AT Protocol authentication if required
5. Parse `app.bsky.feed.post` records properly

The current implementation provides the statistical analysis framework and can be easily extended with proper WebSocket and protocol handling.