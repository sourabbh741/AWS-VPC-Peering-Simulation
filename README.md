# AWS VPC Peering Simulation

A local Linux-based simulation of AWS VPC Peering using network namespaces, virtual Ethernet interfaces, and IP routing.

## Project Overview

This project demonstrates communication between two isolated VPC-style networks through a simulated peering connection.

The environment runs locally using Ubuntu on WSL2. No AWS account or cloud resources are required.

## Network Architecture

| Component | IP Address |
|---|---|
| Bastion | 10.10.1.10 |
| App-A | 10.10.2.10 |
| App-B | 10.20.1.10 |
| Router A peering interface | 169.254.100.1 |
| Router B peering interface | 169.254.100.2 |

### Network ranges
- VPC A: 10.10.0.0/16
- VPC B: 10.20.0.0/16
- VPC A public-style subnet: 10.10.1.0/24
- VPC A private subnet: 10.10.2.0/24
- VPC B private subnet: 10.20.1.0/24

## Technologies Used
- Ubuntu on WSL2
- Linux network namespaces
- iproute2
- Virtual Ethernet (veth)
- IPv4 routing and forwarding
- Bash scripting
- Git and GitHub

## Connectivity Testing

Run:

    sudo bash scripts/test-connectivity.sh

## Cleanup

Run:

    sudo bash scripts/cleanup.sh

## Learning Outcomes
- Understanding VPC-style network isolation
- Configuring private IP addressing
- Understanding routing tables and next hops
- Enabling IPv4 packet forwarding
- Simulating VPC-to-VPC connectivity
- Testing communication using ICMP

## Important Limitations

This is a local educational simulation, not an actual AWS deployment. It does not create AWS VPCs, EC2 instances, security groups, internet gateways, or AWS-managed VPC peering resources.

## Author
Sourabh Awasthi
B.Tech - Electronics and Communication Engineering
GitHub: https://github.com/sourabbh741
