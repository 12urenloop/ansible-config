#!/bin/sh
while true; do
    pnpm run dev
    notify-send 'manual-count-2 crashed'
    sleep 5
done
