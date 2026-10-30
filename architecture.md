# Network Architecture

## VPC A
CIDR: 10.10.0.0/16

| Component | IP Address |
|---|---|
| Bastion | 10.10.1.10 |
| App-A | 10.10.2.10 |
| Router A - Bastion interface | 10.10.1.1 |
| Router A - App-A interface | 10.10.2.1 |

## VPC B
CIDR: 10.20.0.0/16

| Component | IP Address |
|---|---|
| App-B | 10.20.1.10 |
| Router B | 10.20.1.1 |

## VPC Peering Link

| Router | Peering IP |
|---|---|
| Router A | 169.254.100.1/30 |
| Router B | 169.254.100.2/30 |

## Traffic Flow

App-A
  |
Router A
  |
Virtual Peering Link
  |
Router B
  |
App-B

## Routing

Router A forwards traffic for 10.20.1.0/24 through Router B.

Router B forwards traffic for 10.10.1.0/24 and 10.10.2.0/24 through Router A.

This is a local educational model of VPC peering, not an actual AWS deployment.
