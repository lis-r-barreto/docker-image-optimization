# Docker Image Optimization

This repository demonstrates the optimization of a Jenkins Docker image, emphasizing efficiency in terms of image size, layer count, and build time. The project's aim is to deliver a streamlined and faster-running image while retaining full Jenkins functionality.

## Included Files

- `jenkins/Dockerfile`: The optimized Dockerfile.
- `01_build.sh`: Script for building the optimized Docker image.
- `02_run.sh`: Script for launching the Jenkins container.

## Implemented Optimizations

- **Size Reduction:**
  - Minimization of layers and removal of unnecessary dependencies to decrease the final image size.

- **Build Efficiency:**
  - Utilization of best practices to accelerate the build time by avoiding unnecessary operations.

## Executing the Scripts

### Building the Optimized Image

```bash
./01_build.sh <YOUR_NAME>
```

This script utilizes Docker to build the optimized Jenkins image.

### Starting Jenkins

```bash
./02_run.sh jenkins
```

This script initiates the Jenkins container, enabling access to Jenkins at [http://localhost:8080/](http://localhost:8080/).

## Additional Notes

- Ensure Docker is installed and running on your system before executing the scripts.
- Make any additional adjustments necessary to meet specific requirements or preferences.
- The optimization focuses on efficiency and performance, making it an ideal solution for development or integration into production environments.
