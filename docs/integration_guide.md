# Integration Guide

1. Generate the DX1 package from `config/dx1_interconnect.yaml`.
2. Connect the three initiators in the configured order.
3. Connect target interfaces and the APB peripheral bus.
4. Apply `constraints/dx1_interconnect.sdc` and CDC/RDC intent.
5. Run lint, protocol assertions, decode tests, arbitration tests, and software address-map consistency checks.
6. Record the exact Git tag and generated configuration in the project BOM.

The generated address constants in RTL, firmware headers, device tree include, and documentation must share one source YAML. Manual address edits are prohibited.
