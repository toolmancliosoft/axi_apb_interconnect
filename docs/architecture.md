# Architecture

The subsystem separates high-throughput AXI4 traffic from low-bandwidth APB4 control traffic. Read and write channels are arbitrated independently. Address decode is performed when an address handshake is accepted; the selected target remains locked until the associated response completes.

## Initiators

| ID | Initiator | Role |
|---:|---|---|
| 0 | Cortex-A53 | Software, instruction/data, device access |
| 1 | AXI DMA | DDR and accelerator streaming buffers |
| 2 | Ethernet GMAC | Descriptor and packet-buffer traffic |

## Targets

| ID | Target | Address region |
|---:|---|---|
| 0 | Boot ROM / SRAM | `0x0000_0000` - `0x001F_FFFF` |
| 1 | DX1 Accelerator | `0x4000_0000` - `0x4000_FFFF` |
| 2 | AXI DMA control | `0x4001_0000` - `0x4001_FFFF` |
| 3 | DDR | `0x8000_0000` - `0xFFFF_FFFF` |
| 4 | Ethernet GMAC | `0x6000_0000` - `0x6001_FFFF` |
| 5 | APB bridge | `0x6200_0000` - `0x64FF_FFFF` |
| 6 | Default error target | All unmapped addresses |

## Ordering model

- AXI IDs are preserved end-to-end.
- One target may service multiple initiators; arbitration occurs per address channel.
- Write data follows the accepted AW route until WLAST.
- Read responses remain associated with the accepted AR route until RLAST.
- Same-ID ordering follows AXI4 requirements within the configured route.
- The demo RTL limits each initiator to one active read route and one active write route.
