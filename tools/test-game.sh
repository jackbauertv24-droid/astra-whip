#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
GODOT_BIN="${GODOT_BIN:-godot}"
mkdir -p evidence
"$GODOT_BIN" --headless --path game --editor --import --quit > evidence/import.log 2>&1
"$GODOT_BIN" --headless --path game --fixed-fps 120 --script res://tests/run.gd > evidence/gameplay.log 2>&1
cat evidence/gameplay.log
for regression in actor_pivot swooper_collision swooper_recovery_entry ranged_projectile ranged_projectile_art boss_wait_animation; do
 "$GODOT_BIN" --headless --path game --script "res://tests/$regression.gd" > "evidence/$regression.log" 2>&1
 cat "evidence/$regression.log"
done
if [[ "${1:-}" == "--mutations" ]]; then
 for id in T-01 T-02 T-03 T-04 T-05 T-06 T-07 T-08 T-09; do
  if ASTRA_MUTATION="$id" "$GODOT_BIN" --headless --path game --fixed-fps 120 --script res://tests/run.gd > "evidence/mutation-$id.log" 2>&1; then
   echo "ERROR: mutation $id escaped" >&2
   exit 1
  fi
  if ! rg -q "FAIL $id:" "evidence/mutation-$id.log"; then
   echo "ERROR: mutation $id failed for an unrelated reason" >&2
   exit 1
  fi
  echo "$id: expected failure observed"
 done
fi
