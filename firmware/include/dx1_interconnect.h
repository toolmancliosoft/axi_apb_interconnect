#ifndef DX1_INTERCONNECT_H
#define DX1_INTERCONNECT_H
#include <stdint.h>
typedef struct { volatile uint32_t control,status,clear,reserved; volatile uint64_t writes,reads,write_stalls,read_stalls,decode_errors; } dx1_interconnect_regs_t;
#define DX1_INTERCONNECT_MONITOR_BASE 0x00000063010000ULL
#define DX1_INTERCONNECT_MONITOR ((dx1_interconnect_regs_t *)DX1_INTERCONNECT_MONITOR_BASE)
#endif
