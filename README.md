
# TweaXy

A social media app that was implemented as a clone for X (Twitter).

This repository is dedicated to the meticulous implementation of our DevOps strategy, specifically focusing on Continuous Integration (CI) and Continuous Deployment (CD). Within these confines, a refined pipeline is designed to optimize development processes and ensure the smooth deployment of our social media application.

## Containerization
**Docker Containerization**:

- [Docker Compose](https://docs.docker.com/compose/) files are available to simplify the deployment of multi-container applications. You can find them in the [docker-compose](docker-compose/) directory.

- [Docker Hub](https://hub.docker.com/) is used to host Docker images related to this project. You can find and pull the latest images from the [Docker Hub repository](https://hub.docker.com/r/your-username/your-repository) (username `Tweaxy`).

**Docker Images Built**
- `backend` (5 versions).
- `frontend` (2 versions).
- `jenkins` (1 version).
- `chat` (1 version)
## Cloud Providers


1. AWS Services:
   - **ec2** for the deployment of the backend apis server.
   - **cloudwatch** for the  backend apis server logs.
   - **RDS** for the sql database.
   - **S3** for cloud storage.
   - **Parameter Store** for credentials.

2. Azure Services:
   - **virtual Machines** for the deployment of the jenkins server, frontend server and chat micro service.
## Deployment

Each service is provided with two scripts that act as two stages for deployment:

- deploy.sh => run on jenkins server
- <service-name>.sh => run on the service server(s)

Jenkins-server:
```bash
   ./deploy.sh
```

Dedicated Server:

```bash
   ./<servicename>.sh
```

# CI/CD Pipeline

## Overview

This repository utilizes a CI/CD (Continuous Integration/Continuous Deployment) pipeline to automate the build and deployment process for both the frontend and backend components of the project.

## CI/CD Setup

We use Jenkins as our CI/CD tool to automate the pipeline. The pipeline is triggered automatically on pull requests, ensuring that changes are thoroughly tested and deployed seamlessly.

### Frontend Pipeline

The frontend CI/CD pipeline includes the following steps:

1. **Building**: Frontend code is built to be ready for deployment.

2. **Testing**: Automated unit tests are run to validate the functionality and reliability of the frontend code.

3. **Deployment**: The built artifacts (Docker Image) are deployed to the azure server hrough Docker hub.

### Backend Pipeline

The backend CI/CD pipeline follows a similar structure:

1. **Building**: Backend code is built to be ready for deployment.

2. **Testing**: Automated unit tests are run to validate the functionality and reliability of the frontend code.

3. **Deployment**: The built artifacts (Docker Image) are deployed to the AWS/Azure server through Docker hub.


## Jenkins Configuration

The Jenkins server is configured to automatically trigger the CI/CD pipeline on pull requests. This ensures that every change is thoroughly validated before being merged into the dev/main branch.


## Monitoring
### Tools Used

- **Prometheus**: An open-source monitoring and alerting toolkit designed for reliability and scalability.

- **Grafana**: A popular open-source analytics and monitoring platform that integrates with various data sources, including Prometheus.

### Components Monitored

#### Servers

Prometheus collects and stores metrics from servers, offering insights into CPU usage, memory utilization, disk I/O, and other vital system statistics.

#### Containers

Containerized applications are monitored to track resource usage, container health, and other relevant metrics.

### Alerts

Alerts are configured to notify the team of any abnormal behavior or critical issues. These alerts are triggered based on predefined thresholds and can be customized as needed.

## Grafana Dashboards

[Grafana](https://grafana.com/) dashboards provide a visual representation of the monitored metrics. You can access Grafana to view historical data, trends, and performance insights.
![image](https://github.com/TweaXy/devops/assets/87082462/4cf6c5e7-276a-4feb-91ef-a30ccc0cdc0e)
![image](https://github.com/TweaXy/devops/assets/87082462/f3009108-342e-4248-9d6f-87ef1b1d3ee5)
![image](https://github.com/TweaXy/devops/assets/87082462/c4cc619f-03de-4c58-a3f6-61150b8f394f)


## Environment Variables

To build this project's backend image, you will need to have the following environment variables file before running the `docker build` command

`.env`


## Badges


[![Docker](https://img.shields.io/badge/Docker-white?logo=Docker&labelColor=black
)](https://www.docker.com/)
[![Jenkins](https://img.shields.io/badge/Jenkins-white?logo=Jenkins&logoColor=white&labelColor=black
)](https://www.jenkins.io/)
[![Prometheus](https://img.shields.io/badge/Prometheus-white?logo=Prometheus&labelColor=black)](https://prometheus.io/)
[![Prometheus](https://img.shields.io/badge/Grafana-white?logo=Prometheus&logoColor=orange&labelColor=black)](https://grafana.com/)
[![Fluentd](https://img.shields.io/badge/fluentd-white?logo=fluentd&labelColor=black
)](https://www.fluentd.org/)
[![Nginx](https://img.shields.io/badge/nginx-white?logo=nginx&labelColor=black
)](https://nginx.org/en/)
[![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/en-us/)
