#!/bin/bash

# Start the MongoDB service
sudo systemctl start mongod

# Keep the container running
tail -f /dev/null
