## Exploring Benford's Law in Bluesky Firehose Data

As a part of my master's statistics class, I wrote a script to pull bluesky firehose posts (in realtime) 
using the python SDK to analyze the distribution of first digits to explore [Benford's Law](https://en.wikipedia.org/wiki/Benford%27s_law).

I modified code from [this extremely helpful tutorial](https://jrashford.com/2024/12/11/bluesky-firehose-python-tutorial/) to accomplish this as well as some gpt-4o assistance to get the threading setup.

I also used the [uv library](https://github.com/astral-sh/uv) to manage the project environment and allow others to reproduce. 

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