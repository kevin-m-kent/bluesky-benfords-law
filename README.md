# Exploring Benford's Law in Bluesky Firehose Data

This project analyzes the distribution of leading digits in real-time posts from the [Bluesky Firehose](https://blueskyweb.xyz/) to explore [Benford's Law](https://en.wikipedia.org/wiki/Benford%27s_law), a phenomenon observed in many naturally occurring datasets. The work was originally created as part of a master's statistics class.

## Project Overview

- **Goal:** Test whether the frequency of first digits in Bluesky post data follows Benford's Law.
- **Approach:** Uses the Python SDK to stream Bluesky Firehose data, process leading digits, and compare distributions.
- **Inspiration:** Based on [this tutorial](https://jrashford.com/2024/12/11/bluesky-firehose-python-tutorial/) and improved with GPT-4o assistance for threading and code structure.
- **Environment:** Managed with [uv](https://github.com/astral-sh/uv) for reproducibility.

## Sample Results

Results from a sample run (10,000 posts):

**Excluding leading zeros:**
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

**Including leading zeros:**
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

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/kevin-m-kent/bluesky-benfords-law.git
   cd bluesky-benfords-law
   ```

2. **Set up the environment with [uv](https://github.com/astral-sh/uv):**
   ```bash
   uv venv
   uv sync
   ```

3. **Configure your Bluesky credentials:**  
   Ensure you have access to the Bluesky firehose and update any configuration files or environment variables as needed.

## Usage

1. **Run the main script:**
   ```bash
   python bluesky_benford_firehose.py
   ```

2. **Customize parameters:**  
   You can modify the sample size or data processing options by editing variables at the top of `bluesky_benford_firehose.py` (such as `_MAX_NUMBERS`).

3. **View results:**  
   Output will be printed to the console showing the distribution of first digits.

## Requirements

- Python 3.12+
- `atproto` (as specified in `pyproject.toml`)
- `uv` for virtual environment management

## Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to fork this repo and submit pull requests.

## License

This project is open source. Please check with the repository owner regarding licensing terms.

## Acknowledgments

- [jrashford's Bluesky Firehose Python Tutorial](https://jrashford.com/2024/12/11/bluesky-firehose-python-tutorial/)
- [uv environment manager](https://github.com/astral-sh/uv)
- GPT-4o for code review and threading assistance

---
*Created as a master's statistics class project by [Kevin M. Kent](https://github.com/kevin-m-kent).*