# AXI/APB Interconnect Subsystem

Internal, Git-managed digital soft IP providing the DX1 control and data interconnect. The subsystem combines a parameterized AXI4 crossbar, address decode, fixed-priority/round-robin arbitration, registered timing cuts, access-policy checks, an AXI4-to-APB4 bridge, default error targets, performance counters, and protocol assertions.

## DX1 v1.0.0 configuration

- **AXI initiators:** Cortex-A53 system port, DMA, Ethernet GMAC
- **AXI targets:** Boot/SRAM region, DX1 Accelerator, DMA control, DDR, Ethernet GMAC, APB bridge
- **APB peripherals:** Secure GPIO, I2C, SPI, UART, Clock/Reset, Secure Boot, System Monitor ADC, Watchdog
- **Data width:** 128-bit AXI4 data plane; 32-bit APB4 control plane
- **Clocking:** 400 MHz AXI target; 100 MHz APB target
- **Address width:** 40 bits
- **Security:** AXI protection propagation, secure-only region checks, default DECERR/PSLVERR response

This repository is synthetic production-style collateral for SOS-Enterprise demonstrations. It is structurally realistic but is **not silicon-signoff IP**.
