#!/bin/bash
set -e

echo "Starting AWS VPC Peering Simulation..."

# Remove old lab namespaces
for ns in bastion app-a app-b router-a router-b; do
    ip netns delete "$ns" 2>/dev/null || true
done

# Create namespaces
for ns in bastion app-a app-b router-a router-b; do
    ip netns add "$ns"
    ip -n "$ns" link set lo up
done

# Create virtual Ethernet connections
ip link add bast0 type veth peer name ra-bast
ip link add appa0 type veth peer name ra-appa
ip link add appb0 type veth peer name rb-appb
ip link add peer-a type veth peer name peer-b

# Move interfaces into namespaces
ip link set bast0 netns bastion
ip link set ra-bast netns router-a
ip link set appa0 netns app-a
ip link set ra-appa netns router-a
ip link set appb0 netns app-b
ip link set rb-appb netns router-b
ip link set peer-a netns router-a
ip link set peer-b netns router-b

# Configure IP addresses
ip -n bastion addr add 10.10.1.10/24 dev bast0
ip -n router-a addr add 10.10.1.1/24 dev ra-bast

ip -n app-a addr add 10.10.2.10/24 dev appa0
ip -n router-a addr add 10.10.2.1/24 dev ra-appa

ip -n app-b addr add 10.20.1.10/24 dev appb0
ip -n router-b addr add 10.20.1.1/24 dev rb-appb

ip -n router-a addr add 169.254.100.1/30 dev peer-a
ip -n router-b addr add 169.254.100.2/30 dev peer-b

# Activate interfaces
ip -n bastion link set bast0 up
ip -n router-a link set ra-bast up
ip -n router-a link set ra-appa up
ip -n app-a link set appa0 up
ip -n router-b link set rb-appb up
ip -n app-b link set appb0 up
ip -n router-a link set peer-a up
ip -n router-b link set peer-b up

# Enable IP forwarding
ip netns exec router-a sysctl -w net.ipv4.ip_forward=1
ip netns exec router-b sysctl -w net.ipv4.ip_forward=1

# Configure VPC routes
ip -n router-a route add 10.20.1.0/24 via 169.254.100.2
ip -n router-b route add 10.10.1.0/24 via 169.254.100.1
ip -n router-b route add 10.10.2.0/24 via 169.254.100.1

# Configure machine routes
ip -n app-a route add 10.20.1.0/24 via 10.10.2.1
ip -n app-b route add 10.10.1.0/24 via 10.20.1.1
ip -n app-b route add 10.10.2.0/24 via 10.20.1.1
ip -n bastion route add 10.10.2.0/24 via 10.10.1.1
ip -n bastion route add 10.20.1.0/24 via 10.10.1.1

echo "Simulation created successfully!"
