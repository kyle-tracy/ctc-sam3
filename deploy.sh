#!/usr/bin/env bash
# Push local changes to GitHub and copy notebook to vin.
set -e
git push github main
scp notebook_sam3.ipynb vin:~/ctc-sam3/notebook_sam3.ipynb
echo "Deployed to vin."
