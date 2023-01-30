# Terraform - Docker - Django Production Deployment

This repository contains the production grade deployment of a Django application using Terraform and Docker Compose. The deployment includes a Postgres database as a Docker container.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Postgres Docker Image

The Postgres database used in this deployment is from the official [Postgres Docker Image](https://hub.docker.com/_/postgres).

## Django and Psycopg2 Installation

The Django application uses the [Psycopg2 library](https://www.psycopg.org/docs/install.html) for interacting with the Postgres database. Please refer to the official Psycopg2 documentation for installation instructions.

## Terraform Configuration

The Terraform configuration files are located in the `deploy` directory. The `main.tf` file contains the definition of the resources to be deployed, including the Postgres container and the Django application.

## AWS Services Used

- Amazon Elastic Container Service (ECS)
  ECS is a fully managed container orchestration service that makes it easy to run, stop, and manage Docker containers on a cluster.

- Virtual Private Network (VPN)
  VPN provides a secure connection between your network and the AWS network.

- Public Subnets
  Public subnets are used for resources that need to be directly accessible from the Internet, such as a load balancer.

- Private Subnets
  Private subnets are used for resources that should not be directly accessible from the Internet, such as database instances.

## ECS (Amazon Elastic Container Service) provides the following benefits when used with Django and Docker:

1. Scalability: ECS can automatically scale the number of containers to handle changes in demand, without manual intervention.

2. Availability: ECS provides high availability through placement strategies and resource management, ensuring that containers are always running and accessible.

3. Cost-effective: ECS offers a cost-effective solution for managing containers, with pricing based on the number of containers, data transfer, and storage.

4. Integration with AWS Services: ECS integrates with other AWS services, such as EC2, RDS, and Elastic Load Balancing, allowing for seamless deployment and management of containers in the cloud.

5. Security: ECS provides secure access to containers through VPCs and security groups, ensuring that only authorized users have access to the containers.

6. Management: ECS provides a centralized management console that makes it easy to monitor, manage, and update containers, making it a great choice for large-scale production deployments.



## Docker Compose Configuration

The Docker Compose configuration file, `docker-compose.yml`, is located in the root directory of the repository. It contains the definition of the services that make up the deployment, including the Postgres database and the Django application.

## Deployment

To deploy the application, first initialize Terraform:
```
terraform init
terraform plan
terraform apply
```




## Conclusion

This repository demonstrates a production-grade deployment of a Django application using Terraform and Docker Compose. With this configuration, the application can be easily scaled and managed in a production environment.

