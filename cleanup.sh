#!/bin/bash

echo "Cleaning up VPC simulation..."

for ns in bastion app-a app-b router-a router-b; do
    ip netns delete "$ns" 2>/dev/null || true
done

echo "Cleanup completed!"
