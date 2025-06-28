#!/usr/bin/env python3

"""
WebSocket helper for R Bluesky firehose connection
This Python script connects to the actual Bluesky AT Protocol firehose
and outputs parsed text data for R to process
"""

import asyncio
import websockets
import cbor2
import json
import re
import sys
from io import BytesIO

FIREHOSE_URL = "wss://bsky.network/xrpc/com.atproto.sync.subscribeRepos"
MAX_MESSAGES = 1000
collected_numbers = []

def extract_text_from_cbor_data(data):
    """Extract text content from CBOR/CAR encoded AT Protocol data"""
    texts = []
    
    try:
        # Try to decode as CBOR
        decoded = cbor2.loads(data)
        
        # Recursively search for text fields in the decoded data
        def find_text_recursive(obj):
            if isinstance(obj, dict):
                for key, value in obj.items():
                    if key == 'text' and isinstance(value, str):
                        texts.append(value)
                    elif isinstance(value, (dict, list)):
                        find_text_recursive(value)
            elif isinstance(obj, list):
                for item in obj:
                    find_text_recursive(item)
        
        find_text_recursive(decoded)
        
    except Exception as e:
        # If CBOR decoding fails, try to extract text patterns from raw data
        try:
            data_str = data.decode('utf-8', errors='ignore')
            # Look for JSON-like text patterns
            text_matches = re.findall(r'"text"\s*:\s*"([^"]*)"', data_str)
            texts.extend(text_matches)
        except:
            pass
    
    return texts

def extract_numbers_from_text(text):
    """Extract numbers from text using same pattern as Python version"""
    if not text or not isinstance(text, str):
        return []
    numbers = re.findall(r'[0-9]+', text)
    return numbers

async def handle_firehose_message(websocket, path):
    """Handle incoming WebSocket messages from Bluesky firehose"""
    global collected_numbers
    message_count = 0
    
    print("Connected to Bluesky firehose", file=sys.stderr)
    
    try:
        async for message in websocket:
            if isinstance(message, bytes):
                # Extract text from the binary message
                texts = extract_text_from_cbor_data(message)
                
                for text in texts:
                    numbers = extract_numbers_from_text(text)
                    if numbers:
                        collected_numbers.extend(numbers)
                        # Output numbers for R to read
                        for num in numbers:
                            print(num)
                        sys.stdout.flush()
                
                message_count += 1
                if message_count % 100 == 0:
                    print(f"Processed {message_count} messages, found {len(collected_numbers)} numbers", file=sys.stderr)
                
                # Stop after collecting enough numbers or processing enough messages
                if len(collected_numbers) >= 10000 or message_count >= MAX_MESSAGES:
                    print(f"Stopping after {message_count} messages with {len(collected_numbers)} numbers", file=sys.stderr)
                    break
                    
    except Exception as e:
        print(f"Error processing messages: {e}", file=sys.stderr)

async def connect_to_firehose():
    """Connect to the Bluesky AT Protocol firehose"""
    try:
        print("Connecting to Bluesky AT Protocol firehose...", file=sys.stderr)
        print(f"URL: {FIREHOSE_URL}", file=sys.stderr)
        
        async with websockets.connect(FIREHOSE_URL) as websocket:
            await handle_firehose_message(websocket, None)
            
    except Exception as e:
        print(f"Failed to connect to firehose: {e}", file=sys.stderr)
        return False
    
    return True

def main():
    """Main function to run the WebSocket client"""
    try:
        # Run the async WebSocket connection
        asyncio.run(connect_to_firehose())
    except KeyboardInterrupt:
        print("Connection interrupted", file=sys.stderr)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)

if __name__ == "__main__":
    main()