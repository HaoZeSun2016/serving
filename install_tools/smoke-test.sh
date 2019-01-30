#!/usr/bin/env bash

while true; do
  timestamp=$(date +%s)
  curl -d "{\"instances\":[1.0,2.0,5.0], \"request_id\":$timestamp}" http://localhost:8501/v1/models/half_plus_three/versions/123:predict  
done
