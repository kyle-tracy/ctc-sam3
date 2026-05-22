# ctc-sam3

SAM3 cell tracking on CTC `Fluo-N2DH-SIM+` sequence 02.

## Notebook

`notebook_sam3.ipynb` — a self-contained notebook that runs on `vin` inside `colab-env`.

| Cell | What it does |
|---|---|
| 1 | Config & imports — **edit paths / `SEED_MODE` here** |
| 3 | Export raw TIF frames to JPEG (one-time, skips existing) |
| 5 | Load SAM3 predictor, open video session |
| 7 | Seed frame 0 from GT masks (or YOLO — stub) |
| 9 | Propagate → `masks` dict |
| 11 | Write CTC mask TIFFs + `res_track.txt` |
| 13 | SEG + TRA metrics, append `results.csv` |

## Setup on vin

```bash
cd ~ && git clone git@github.com:kyle-tracy/ctc-sam3.git
source ~/.venvs/colab-env/bin/activate
# open notebook_sam3.ipynb in Jupyter
```

## Updating

```bash
# local
git push github main

# vin
git -C ~/ctc-sam3 pull
```

## SAM3 API notes

- Use `points=` + `obj_id=` in `add_prompt`, **not** `bounding_boxes=`.
  The box path resets all tracker state on every call.
- Patch `sam3.model.sam3_video_inference.fill_holes_in_mask_scores` to a no-op
  before importing `Sam3VideoPredictor` — Triton kernel overflows on large frames.
- `propagate_in_video` yields `{"frame_index": int, "outputs": dict | None}`.
  Mask keys: `"out_obj_ids"`, `"out_binary_masks"`.
