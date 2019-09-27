# Docker Dev Image for grCUDA

This image gets published under `printcap/cuda_jvmci_mx` on
[Dockerhub](https://hub.docker.com/r/printcap/cuda_jvmci_mx).

It is based on `nvidia/cuda:10.0-devel-ubuntu16.04` and adds
the OpenJDK-8u222-jvmci-139.3-b02-linux-amd64. The `graalvm/mx`
repository is cloned and `mx` as well as `java` are in `PATH`.


Building the image and publishing it on Dockerhub:

```bash
docker -t cuda_jvmci_mx:10.0_ubuntu16_04 .
docker tag 1e566c8d2ab1 printcap/cuda_jvmci_mx:10.0_ubuntu16_04
docker push  printcap/cuda_jvmci_mx:10.0_ubuntu16_04
```

When run with `nvidia-docker2`, the host GPUs are accessible
inside the container.

