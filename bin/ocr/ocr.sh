#!/bin/bash
# v4
xfce4-screenshooter -r -s "$HOME/szmelc/bin/ocr/img/_$(date +%Y-%m-%d_%H-%M-%S).png"
sleep 1
cd ~/szmelc/bin/ocr && python3 ~/szmelc/bin/ocr/ocr.py
