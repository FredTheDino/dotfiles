#!/usr/bin/env bash
curl -Ss 'https://wttr.in/Uppsala?m&format=3' | python3 -c "print(*input().split(':')[1].split()[::-1])"
