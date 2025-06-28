## Exploring Benford's Law in Bluesky Firehose Data

As a part of my master's statistics class, I wrote scripts to pull bluesky firehose posts (in realtime) 
to analyze the distribution of first digits to explore [Benford's Law](https://en.wikipedia.org/wiki/Benford%27s_law).

This repository now contains implementations in both **Python** and **R** with the same core functionality.

### Python Implementation

The original Python version uses the atproto SDK to connect to Bluesky's firehose. I modified code from [this extremely helpful tutorial](https://jrashford.com/2024/12/11/bluesky-firehose-python-tutorial/) and received gpt-4o assistance with the threading setup.

The Python environment uses the [uv library](https://github.com/astral-sh/uv) for dependency management.

### R Implementation  

The R version replicates the same functionality using R's statistical computing capabilities. It includes both basic and advanced implementations with realistic data simulation.

## Project Structure

```
├── python/           # Python implementation
│   ├── bluesky_benford_firehose.py
│   ├── pyproject.toml
│   └── uv.lock
├── R/               # R implementation  
│   ├── bluesky_benford_firehose.R
│   ├── bluesky_benford_advanced.R
│   ├── DESCRIPTION
│   └── README.md
└── README.md        # This file
```

## Quick Start

### Python
```bash
cd python
uv run python bluesky_benford_firehose.py
```

### R
```bash
cd R
Rscript bluesky_benford_advanced.R
``` 

## Results

Findings from one run of a 10k sample, excluding leading zeros:

```
Total Samples: 10000
Digit: 1 Proportion: 0.21
Digit: 2 Proportion: 0.24
Digit: 3 Proportion: 0.11
Digit: 4 Proportion: 0.08
Digit: 5 Proportion: 0.07
Digit: 6 Proportion: 0.05
Digit: 7 Proportion: 0.05
Digit: 8 Proportion: 0.04
Digit: 9 Proportion: 0.04
```

And including leading zeros:

```
Total Samples: 10000
Digit: 0 Proportion: 0.1
Digit: 1 Proportion: 0.23
Digit: 2 Proportion: 0.25
Digit: 3 Proportion: 0.1
Digit: 4 Proportion: 0.07
Digit: 5 Proportion: 0.07
Digit: 6 Proportion: 0.05
Digit: 7 Proportion: 0.04
Digit: 8 Proportion: 0.05
Digit: 9 Proportion: 0.04
```