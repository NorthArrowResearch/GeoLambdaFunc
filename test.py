"""

    Sandbar Analysis Unit Testing

    How to use in pyCharm:
        1. preferncecs => Tools => Python Integrated Tools => Default Test Runner => Unittest
        2. Create a new run configuration using the run configuration dropdown in the top
            left. use the "+" button to choose Python Tests => Unittest
            Just se the default options
        3. Now you can run Unittests in sandbar-analysis

"""

# Utility functions we need
import unittest
import json
import numpy as np
from os import path, makedirs

class EventHandler(unittest.TestCase):

    def test_event(self):
        from handler import handler
        # 1. Mock up the worker so it doesn't run
        json_data = open('./test/event.json').read()
        event = json.loads(json_data)
        handler(event, None)
        self.assertTrue(False)

class Worker(unittest.TestCase):
    def test_raster(self):
        from worker import raster_shape
        self.assertTrue(False)