#!/bin/bash

PYTHONPATH=$(realpath ../foo):$(realpath ../bar) python3 client.py
