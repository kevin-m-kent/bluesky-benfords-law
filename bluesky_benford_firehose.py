import threading
import re
from atproto import FirehoseSubscribeReposClient, parse_subscribe_repos_message, models, CAR
from collections import Counter

## used code from this tutorial: https://jrashford.com/2024/12/11/bluesky-firehose-python-tutorial/

# Global variables
collected_numbers = []  # List to store the collected numbers
_MAX_NUMBERS = 10000  # Limit for numbers to collect
client = FirehoseSubscribeReposClient()  # Initialize the client

def on_message_handler(message):
    """
    Handle incoming Firehose messages, extract numbers, and stop once the required limit is reached.
    """
    global collected_numbers

    # Parse the incoming message
    commit = parse_subscribe_repos_message(message)
    if not isinstance(commit, models.ComAtprotoSyncSubscribeRepos.Commit):
        return

    if not commit.blocks:
        return

    # Decode CAR data
    car = CAR.from_bytes(commit.blocks)
    pattern = re.compile(r'[0-9]+')  # Regex to find numbers

    for op in commit.ops:
        if op.action in ["create"] and op.cid:
            data = car.blocks.get(op.cid)

            if data['$type'] == 'app.bsky.feed.post':
                text = data['text']

                # Find numbers in post text
                numbers = pattern.findall(text)
                if numbers:
                    collected_numbers.extend(numbers)

                    # Stop the client if we've collected enough numbers
                    if len(collected_numbers) >= _MAX_NUMBERS:
                        print(f"Stopping client! Collected {len(collected_numbers)} numbers.")
                        client.stop()
                        return


def main():
    """
    Run the Firehose client and stop it once we've collected 1,000 numbers.
    """
    global collected_numbers

    # Start the client in a separate thread
    client_thread = threading.Thread(target=client.start, args=(on_message_handler,))
    client_thread.start()

    # Wait for the client thread to finish
    client_thread.join()

    # Print the first few collected numbers and total count
    print("First few numbers collected:", collected_numbers[:10])
    print(f"Total numbers collected: {len(collected_numbers)}")

    total_numbers = len(collected_numbers)
    numbers_first_digit = [num[0] for num in collected_numbers if num[0] != '0']
    counter = Counter(numbers_first_digit)
    counter_items = sorted(counter.items())
    counter_items_prop = [(item[0], round(item[1]/total_numbers, 4)) for item in counter_items]
    print("Total Samples: ", total_numbers, "\n")
    for item in counter_items_prop:
        print("Digit: ", item[0], "Proportion: ", item[1], "\n")

if __name__ == "__main__":
    main()