# Bluesky Benford's Law Analysis

This project analyzes real-time data from the Bluesky social network using [Benford's Law](https://en.wikipedia.org/wiki/Benford%27s_law) to explore the distribution of first digits in numerical data found in posts. Benford's Law is a statistical principle that can be used for anomaly detection and fraud analysis, as naturally occurring datasets often follow a predictable pattern where smaller digits (1, 2, 3) appear as leading digits more frequently than larger digits (7, 8, 9).

The application connects to Bluesky's firehose API to collect numerical data from posts in real-time, then analyzes the frequency distribution of first digits to see how closely they match Benford's Law expectations.

## Features

- **Real-time Data Collection**: Connects to Bluesky's firehose API to collect numerical data from live posts
- **Benford's Law Analysis**: Analyzes the distribution of first digits in collected numbers
- **Flexible Analysis Options**: Supports analysis both including and excluding leading zeros
- **Threading Implementation**: Uses multi-threading for efficient real-time data processing
- **Configurable Sample Size**: Collects a specified number of samples (default: 10,000) before analysis
- **Statistical Output**: Provides proportion calculations for each digit with easy-to-read results
- **Easy Environment Management**: Uses UV for reproducible Python environment setup

## Installation

### Prerequisites

- Python 3.12 or higher
- Internet connection for accessing Bluesky's firehose API

### Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/kevin-m-kent/bluesky-benfords-law.git
   cd bluesky-benfords-law
   ```

2. **Install UV** (if not already installed):
   ```bash
   pip install uv
   ```

3. **Set up the virtual environment and install dependencies**:
   ```bash
   uv sync
   ```

## Usage

### Basic Usage

Run the main analysis script to collect data from Bluesky's firehose and analyze it:

```bash
uv run python bluesky_benford_firehose.py
```

### How it Works

The script will:
1. Connect to Bluesky's real-time firehose API
2. Extract numerical data from incoming posts
3. Collect up to 10,000 numbers (configurable in the script)
4. Analyze the distribution of first digits
5. Display results showing the proportion of each digit

### Customization

You can modify the analysis by editing the `_MAX_NUMBERS` variable in `bluesky_benford_firehose.py` to change the sample size:

```python
_MAX_NUMBERS = 10000  # Change this value to collect more or fewer samples
```

## Results

Example findings from a 10,000 sample analysis, excluding leading zeros:

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

## Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the repository** on GitHub
2. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** and commit them:
   ```bash
   git commit -m "Add your feature description"
   ```
4. **Push to your branch**:
   ```bash
   git push origin feature/your-feature-name
   ```
5. **Open a Pull Request** on GitHub with a clear description of your changes

### Development Guidelines

- Ensure your code follows Python best practices
- Test your changes before submitting
- Update documentation if you modify functionality
- Keep changes focused and atomic

## License

This project does not currently specify a license. Please contact the repository owner for licensing information before using this code in commercial or redistributed projects.

## Acknowledgements

- **Tutorial Reference**: Code modified from [this extremely helpful Bluesky firehose tutorial](https://jrashford.com/2024/12/11/bluesky-firehose-python-tutorial/) by J. Rashford
- **AI Assistance**: GPT-4o provided assistance with the threading setup implementation
- **Package Management**: Built using the [UV library](https://github.com/astral-sh/uv) for reproducible Python environment management
- **Academic Context**: Created as part of a master's statistics class project exploring real-world applications of Benford's Law