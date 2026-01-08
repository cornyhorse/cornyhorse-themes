#!/usr/bin/env python3
"""
Example Python file to showcase Solarized Light theme syntax highlighting.
This demonstrates various language constructs and their colors.
"""

import os
import sys
from pathlib import Path
from typing import List, Dict, Optional

# Constants and numbers
MAX_RETRIES = 3
PI = 3.14159
ENABLED = True
DEFAULT_NAME = None

# Global variable
config_path = "/etc/config.json"


class DataProcessor:
    """A sample class to demonstrate syntax highlighting."""
    
    def __init__(self, name: str, debug: bool = False):
        self.name = name
        self.debug = debug
        self._cache = {}
        
    def process_data(self, items: List[str]) -> Dict[str, int]:
        """Process a list of items and return statistics."""
        result = {}
        
        for idx, item in enumerate(items):
            # Check if item is valid
            if not item or len(item) == 0:
                continue
                
            # Store in cache
            self._cache[item] = idx
            result[item] = len(item)
            
        return result
    
    @staticmethod
    def validate(data: str) -> bool:
        """Validate input data."""
        return data is not None and isinstance(data, str)


def main():
    """Main entry point."""
    # String examples
    message = "Hello, Solarized!"
    multiline = """
    This is a multiline
    string example.
    """
    
    # Numeric operations
    count = 42
    ratio = 0.75
    total = count * ratio
    
    # Control flow
    if total > 30:
        print(f"Total is {total}")
    elif total > 20:
        print("Moderate")
    else:
        print("Low")
    
    # List comprehension
    squares = [x**2 for x in range(10) if x % 2 == 0]
    
    # Dictionary
    config = {
        "enabled": True,
        "timeout": 30,
        "retries": MAX_RETRIES,
        "path": Path("/tmp/data")
    }
    
    # Function call
    processor = DataProcessor("example", debug=True)
    results = processor.process_data(["apple", "banana", "cherry"])
    
    # Exception handling
    try:
        value = config["missing_key"]
    except KeyError as e:
        print(f"Error: {e}")
    finally:
        print("Cleanup complete")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
