#!/usr/bin/bash
find backup -mtime +11 -type f -delete
tar acf backup/$(date +%Y-%m-%d).tar.gz -C ../data/config state
