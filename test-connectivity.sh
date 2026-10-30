#!/bin/bash
set -e

echo "Testing VPC Peering Connectivity..."

echo "Test 1: Router A to Router B"
ip netns exec router-a ping -c 4 169.254.100.2

echo "Test 2: App-A to App-B"
ip netns exec app-a ping -c 4 10.20.1.10

echo "Test 3: App-B to App-A"
ip netns exec app-b ping -c 4 10.10.2.10

echo "All connectivity tests passed!"
