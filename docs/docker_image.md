# Docker Image

The ServiceExample application is built and published as a multi-architecture Docker image that supports both amd64 and arm64 platforms.

## Image details
| **Property**      | **Value**                                   |
|--------------------|---------------------------------------------|
| **Image name**     | `ebaroks/serviceexample:latest`             |
| **Architectures**  | `linux/amd64`, `linux/arm64`               |
| **Registry**       | Docker Hub                                 |
| **Build system**   | GitHub Actions (multi-arch buildx)          |
| **Signature**      | Signed with Sigstore Cosign                 |

## Image verification

This image is cryptographically signed with Cosign to ensure integrity and authenticity.
You can verify it using the public key published in the root of this repository (cosign.pub):
```
cosign verify --key cosign.pub ebaroks/serviceexample:latest
```
