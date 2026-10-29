#!/usr/bin/env python3
from pathlib import Path
import argparse
import json
import yaml


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--config', required=True)
    parser.add_argument('--out', default='build/generated')
    args = parser.parse_args()

    cfg = yaml.safe_load(Path(args.config).read_text())
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    targets = cfg['axi']['targets']
    periphs = cfg['apb']['peripherals']

    header = [
        '/* Auto-generated. Do not edit. */',
        '#ifndef DX1_INTERCONNECT_ADDR_MAP_H',
        '#define DX1_INTERCONNECT_ADDR_MAP_H',
    ]
    for target in targets:
        name = target['name'].upper()
        header.extend([
            f"#define DX1_{name}_BASE 0x{int(target['base']):010X}ULL",
            f"#define DX1_{name}_SIZE 0x{int(target['size']):X}ULL",
        ])
    apb_base = next(int(t['base']) for t in targets if t['name'] == 'apb_bridge')
    for peripheral in periphs:
        addr = apb_base + int(peripheral['offset'])
        header.append(f"#define DX1_{peripheral['name'].upper()}_BASE 0x{addr:010X}ULL")
    header.extend(['#endif', ''])
    (out / 'dx1_interconnect_addr_map.h').write_text('\n'.join(header))
    (out / 'dx1_interconnect_manifest.json').write_text(json.dumps(cfg, indent=2))

    dtsi = ['/* Auto-generated. */', '/ {', '  soc {']
    for peripheral in periphs:
        addr = apb_base + int(peripheral['offset'])
        size = int(peripheral['size'])
        dtsi.append(
            f"    {peripheral['name']}@{addr:x} {{ reg = <0x0 0x{addr:x} 0x0 0x{size:x}>; }};"
        )
    dtsi.extend(['  };', '};', ''])
    (out / 'dx1-interconnect.dtsi').write_text('\n'.join(dtsi))
    print(f'Generated {len(targets)} AXI targets and {len(periphs)} APB peripherals in {out}')


if __name__ == '__main__':
    main()
