# Benchmark protocol

The benchmark is conducted on three Supermicro bare-metal servers (dual AMD EPYC 7262, 128GB DDR4 3200, NVMe disk, NIC Intel XL710 40Gbit/s) connected through a 40Gbit/s switch (Supermicro SSE-X3348SR). 
The servers are directly connected to the switch via DAC QSFP+ passive cables and are set up in the same VLAN with jumbo frames activated (MTU 9000).

Kubernetes 1.21.0 is deployed via `kubeadm` on Ubuntu 20.40. Docker is setup with a standard `apt install docker.io` (so it will be version `20.10.2`).

To improve reproducibility, we have chosen to always set up the master on the first node, to host the server part of the benchmark on the second server, and the client part on the third one. This is achieved via NodeSelector in Kubernetes deployments. 

The whole cluster is tear down and completely re-deployed between each CNI. Each CNI is tested 3 times, we retain the mean value.