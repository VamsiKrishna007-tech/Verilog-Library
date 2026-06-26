# 4-Requester Round Robin Arbiter

## Overview

This project implements a synthesizable **4-requester Round Robin Arbiter** in Verilog.

A Round Robin Arbiter is commonly used in SoCs, buses, Network-on-Chip (NoC), DMA controllers, and memory controllers to provide **fair access** among multiple requesters while preventing starvation.

The arbiter grants access to **exactly one requester per clock cycle** using a rotating priority scheme.

---

## Features

- 4 Requesters
- One-hot grant output
- Fair round robin scheduling
- Pointer-based arbitration
- Priority override for Requester-0
- Active-high asynchronous reset
- Synthesizable RTL
- Self-checking testbench

---

## Interface

| Signal | Width | Direction | Description |
|---------|------|-----------|-------------|
| clk | 1 | Input | System Clock |
| reset | 1 | Input | Active High Asynchronous Reset |
| req | 4 | Input | Request Requests |
| priority_in | 1 | Input | Enables Priority Override |
| grant | 4 | Output | One-Hot Grant |
| grant_valid | 1 | Output | Indicates Valid Grant |

---

## Arbitration Algorithm

The arbiter remembers the **last granted requester** using a 2-bit pointer.

On every clock cycle:

1. Check Priority Override.
2. If `priority_in = 1` and `req[0] = 1`
   - Requester-0 immediately wins.
3. Otherwise:
   - Start searching from `(pointer + 1)`.
   - Search all four requesters in circular order.
   - Grant the first active requester.
   - Update pointer to the granted requester.
4. If no requests are active:
   - grant = 0
   - grant_valid = 0
   - pointer remains unchanged.

---

## Search Order

Pointer stores the **last granted requester**.

| Pointer | Search Order |
|----------|--------------|
| 0 | 1 → 2 → 3 → 0 |
| 1 | 2 → 3 → 0 → 1 |
| 2 | 3 → 0 → 1 → 2 |
| 3 | 0 → 1 → 2 → 3 |

---

## Priority Override

When

```
priority_in = 1
```

and

```
req[0] = 1
```

Requester-0 immediately receives the grant regardless of the current pointer position.

---

## Reset Behavior

After reset:

```
pointer = 0

grant = 4'b0000

grant_valid = 0
```

---

## Example

### Input Requests

```
req = 4'b1111
pointer = 0
```

### Grant Sequence

```
0010

0100

1000

0001

0010
...
```

This demonstrates fair round-robin arbitration.

---

## RTL Architecture

```
                req[3:0]
                    │
                    ▼
          +------------------+
          | Priority Check   |
          +------------------+
                    │
                    ▼
          +------------------+
          | Round Robin      |
          | Search Logic     |
          +------------------+
                    │
                    ▼
          +------------------+
          | Grant Generator  |
          +------------------+
                    │
                    ▼
          +------------------+
          | Pointer Update   |
          +------------------+
```

---
