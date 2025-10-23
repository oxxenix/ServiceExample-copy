# Local Development Setup

The ServiceExample project is a distributed .NET 9 microservice that depends on MongoDB, Redis, and NATS.

## Prerequisites
- .NET 9 SDK
- Docker

## Installation
1. Clone the repository
```
git clone https://github.com/oxxenix/ServiceExample-copy.git
cd ServiceExample-copy
```

2. Start the application stack

The app requires MongoDB, Redis, and NATS services, which are included in the docker-compose.yaml.
```
docker compose up --build
```

## Verify it's running

Once all containers are up, check:

Swagger UI: http://localhost:9080/swagger/index.html

Health check endpoint:

curl http://localhost:9080/api/Person


## To clean up:
```
docker compose down -v
```

## Notes

The local setup is for development/testing.
For production, use the Helm chart deployed via GitOps in Kubernetes.

Ensure that no other services are using ports 27017, 6379, or 4222, which are used by MongoDB, Redis, and NATS respectively.
