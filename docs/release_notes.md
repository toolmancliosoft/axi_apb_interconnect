# Release Notes v1.0.0

- Initial reusable release for DX1.
- Added three-initiator AXI4 topology and six functional targets plus default error target.
- Added 128-bit data path and 40-bit address support.
- Added APB4 bridge and eight-peripheral decode map.
- Added secure-region access filtering using AXI protection attributes.
- Added round-robin arbitration, default DECERR behavior, and saturating performance counters.
- Added configuration-driven C header, device-tree include, and manifest generation.
- Added protocol assertions, regression plan, SDC, and CDC/RDC intent.

Known limitations:
- The demonstration RTL limits each initiator to one active read and one active write route.
- Production implementation must replace the structural top shell with generated route matrices.
- AXI-to-APB clock-domain crossing requires the qualified asynchronous bridge implementation.
- Synthetic qualification results are not silicon-signoff evidence.
