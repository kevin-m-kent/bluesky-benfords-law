## Exploring Benford's Law in Bluesky Firehose Data

As a part of my master's statistics class, I wrote a script to pull bluesky firehose posts (in realtime) 
using the python SDK to analyze the distribution of first digits to explore [Benford's Law](https://en.wikipedia.org/wiki/Benford%27s_law).

I modified code from [this extremely helpful tutorial](https://jrashford.com/2024/12/11/bluesky-firehose-python-tutorial/) to accomplish this as well as some gpt-4o assistance to get the threading setup.

I also used the [uv library](https://github.com/astral-sh/uv) to manage the project environment and allow others to reproduce. 

## Results

Findings from one run of a 10k sample:

```


```