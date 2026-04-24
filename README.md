# S2I Nginx Application

A simple Source-to-Image (S2I) application that uses Red Hat UBI9 Minimal base image with Nginx serving a "Hello World" HTML page.

## Project Structure

```
.
├── Dockerfile          # Dockerfile using UBI9 minimal base image
├── index.html         # Simple Hello World HTML page
├── nginx.conf         # Nginx configuration file
└── README.md          # This file
```

## Prerequisites

- Docker or Podman installed
- Access to registry.access.redhat.com (Red Hat Container Registry)

## Building the Image

### Using Docker

```bash
docker build -t s2i-nginx-app:latest .
```

### Using Podman

```bash
podman build -t s2i-nginx-app:latest .
```

## Running the Application

### Using Docker

```bash
docker run -d -p 8080:8080 --name nginx-hello s2i-nginx-app:latest
```

### Using Podman

```bash
podman run -d -p 8080:8080 --name nginx-hello s2i-nginx-app:latest
```

## Accessing the Application

Once the container is running, open your web browser and navigate to:

```
http://localhost:8080
```

You should see a "Hello World!" message with a purple gradient background.

## Stopping the Application

### Using Docker

```bash
docker stop nginx-hello
docker rm nginx-hello
```

### Using Podman

```bash
podman stop nginx-hello
podman rm nginx-hello
```

## Deploying to OpenShift

### Using S2I Build

1. Create a new application from the Dockerfile:

```bash
oc new-app https://github.com/yourusername/s2i-nginx-app.git --name=nginx-hello
```

2. Expose the service:

```bash
oc expose svc/nginx-hello
```

3. Get the route:

```bash
oc get route nginx-hello
```

### Using Binary Build

1. Create a new build configuration:

```bash
oc new-build --name=nginx-hello --binary --strategy=docker
```

2. Start the build from local directory:

```bash
oc start-build nginx-hello --from-dir=. --follow
```

3. Create a new application:

```bash
oc new-app nginx-hello
```

4. Expose the service:

```bash
oc expose svc/nginx-hello
```

## Features

- **Base Image**: Red Hat UBI9 Minimal (registry.access.redhat.com/ubi9-minimal:latest)
- **Web Server**: Nginx
- **Port**: 8080 (non-privileged port for OpenShift compatibility)
- **Content**: Simple, responsive HTML page with modern styling

## Customization

### Modifying the HTML Content

Edit the `index.html` file to change the content displayed on the web page.

### Changing Nginx Configuration

Edit the `nginx.conf` file to modify Nginx settings such as:
- Port numbers
- Server names
- Location blocks
- Logging settings

### Adding More Content

You can add additional HTML, CSS, or JavaScript files and update the Dockerfile to copy them to `/usr/share/nginx/html/`.

## Troubleshooting

### Container fails to start

Check the logs:

```bash
# Docker
docker logs nginx-hello

# Podman
podman logs nginx-hello
```

### Port already in use

If port 8080 is already in use, map to a different port:

```bash
# Docker
docker run -d -p 8081:8080 --name nginx-hello s2i-nginx-app:latest

# Podman
podman run -d -p 8081:8080 --name nginx-hello s2i-nginx-app:latest
```

Then access the application at `http://localhost:8081`

### Permission issues in OpenShift

The application is configured to run on port 8080 (non-privileged) and should work in OpenShift's restricted security context. If you encounter permission issues, ensure your OpenShift project has the appropriate security context constraints.

## License

This is a sample application for demonstration purposes.
