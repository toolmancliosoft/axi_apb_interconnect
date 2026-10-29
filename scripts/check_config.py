#!/usr/bin/env python3
from pathlib import Path
import sys,yaml
cfg=yaml.safe_load(Path(sys.argv[1]).read_text()); regions=[]
for t in cfg['axi']['targets']:
 b=int(t['base']);e=b+int(t['size'])
 if int(t['size'])<=0: raise SystemExit(f"invalid size: {t['name']}")
 for n,lo,hi in regions:
  if max(b,lo)<min(e,hi): raise SystemExit(f"overlap: {t['name']} with {n}")
 regions.append((t['name'],b,e))
print(f"PASS: {len(regions)} non-overlapping AXI regions")
