# Security Model

AXI `AxPROT[1]` is treated as the non-secure indicator. The access-policy block compares each transaction against the generated secure-region table. Non-secure requests to secure-only regions are terminated locally with DECERR and are not forwarded.

Protected APB regions:

- Secure Boot Controller
- Clock/reset fault and lifecycle-control registers
- Security-sensitive GPIO banks

This block performs access gating only. System trust still depends on Cortex-A53 TrustZone configuration, GIC security groups, debug lifecycle policy, and correct peripheral implementation.
