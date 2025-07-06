# newt
some helper tools for newt

## About Newt

Newt is a tunneling client for Pangolin, developed by the [Fossorial Research Lab](https://github.com/fosrl). This repository contains configuration files and helper tools for deploying and managing Newt services.

### Official Repository

- **GitHub**: [fosrl/newt](https://github.com/fosrl/newt)
- **Description**: A tunneling client for Pangolin
- **Documentation**: [https://docs.fossorial.io](https://docs.fossorial.io)
- **Language**: Go
- **Latest Version**: 1.2.1

## Installation Options

### Option 1: Docker (Recommended)

Use the provided `docker-compose.yml` file for easy deployment:

#### Method A: Using .env file (Recommended)
```bash
# Set up environment variables
cp env.template .env
# Edit .env with your configuration
nano .env

# Start the service
docker-compose up -d
```

#### Method B: Using direct environment variables
Alternatively, you can configure environment variables directly in the docker-compose file by replacing the `env_file` section with an `environment` section:

```yaml
environment:
  - PANGOLIN_ENDPOINT=https://pangolin.th-luebeck.me
  - NEWT_ID=your_newt_client_id
  - NEWT_SECRET=your_newt_client_secret
```

**Note**: The .env file approach is recommended for security as it keeps sensitive credentials separate from version control.

### Option 2: Binary Installation

You can also install Newt as a standalone binary:

#### Option A: Homebrew (Recommended for macOS)

```bash
brew install newt
```

#### Option B: Manual Download

Visit the [official releases page](https://github.com/fosrl/newt/releases) or download directly:

**Linux (x86_64):**
```bash
wget https://github.com/fosrl/newt/releases/download/1.2.1/newt_linux_amd64
chmod +x newt_linux_amd64
sudo mv newt_linux_amd64 /usr/local/bin/newt
```

**macOS (Intel):**
```bash
curl -L -o newt https://github.com/fosrl/newt/releases/download/1.2.1/newt_darwin_amd64
chmod +x newt
sudo mv newt /usr/local/bin/
```

**macOS (Apple Silicon):**
```bash
curl -L -o newt https://github.com/fosrl/newt/releases/download/1.2.1/newt_darwin_arm64
chmod +x newt
sudo mv newt /usr/local/bin/
```

**Windows:**
Download `newt_windows_amd64.exe` from the releases page and rename to `newt.exe`.

#### Using Command-Line Parameters

The binary version requires command-line parameters (newt does not read environment variables):

**Option A: Use the provided script (Recommended)**
```bash
# Make the script executable (first time only)
chmod +x run_newt.sh

# Run newt using values from .env file
./run_newt.sh
```

**Option B: Use command-line parameters directly**
```bash
# Use command-line parameters directly
newt --id hhxsygdft51p7gnu7 \
     --secret v9gsw5fbatv091p2iy14bmvbj75bx1f05w3gyht7xac5awy3rl \
     --endpoint https://pangolin.th-luebeck.me \
     --log-level DEBUG
```

**Option C: Source .env and use variables**
```bash
# Source the .env file and use variables as parameters
source .env && newt --id "$NEWT_ID" --secret "$NEWT_SECRET" --endpoint "$PANGOLIN_ENDPOINT" --log-level DEBUG
```

**Note**: The `.env` file is used by the Docker version and can be used with the binary version via the script or manual sourcing.

## Host Access Configuration

When running newt in different environments, you may encounter issues with host access:

- **Docker version**: `localhost` refers to the container itself, not the host machine
- **Binary version**: `host.docker.internal` doesn't exist (Docker-specific hostname)

### Solution


**Note**: On macOS with Docker Desktop, `host.docker.internal` is automatically available, but we include it explicitly for compatibility.

#### Target Configuration Strategy

For maximum compatibility, configure your targets using:

1. **For services running on the same machine as newt if newt is started in docker:**
   - Use `host.docker.internal` instead of localhost (Docker only)
   - Use container names if in same Docker network

1. **For services running on the same machine as newt if newt is started NOT in docker:**
   - Use `localhost` (works for services running in both Docker and binary)

2. **For external services:**
   - Use full hostnames or IP addresses

### Example Target Configurations

```bash
# Local services (when running newt NOT in Docker)
localhost:8080          # works for services running in both Docker and binary
localhost:699           # works for services running in both Docker and binary

# Docker services (when running newt in Docker)
host.docker.internal:8089  # Docker only
container-name:5000        # If in same Docker network

# External services
sim01.th-luebeck.de:80     # External hostname
nasy:5000                  # External hostname
```

### Testing Host Access

#### From newt Docker Container:
```bash
# Test host.docker.internal access
docker exec newt ping host.docker.internal
```

#### From newt Binary:
```bash
# Test localhost access
ping localhost


### Troubleshooting

#### If localhost doesn't work in Docker:
- This is expected behavior - `host.docker.internal` is Docker-specific
- Use `host.docker.internal` instead for local services

#### If host.docker.internal doesn't work in binary:
- This is expected behavior - `host.docker.internal` is Docker-specific
- Use `localhost` instead for local services

#### For mixed environments:
- Use `localhost` for services on the same machine
- Use full hostnames for external services
- Avoid `host.docker.internal` in binary environments

## Part of Tunnel Meta Repository

This repository is included as a submodule in the [tunnel](https://github.com/hellbrueck/tunnel.git) meta repository, which is part of the larger [NetSysLab](https://github.com/hellbruh/NetSysLab) network infrastructure toolkit.

### Repository Hierarchy:
```
NetSysLab (meta repository)
└── tunnel/ (submodule)
    └── newt/ (submodule) ← This repository
```

## Environment Setup

The Newt service requires several environment variables to be configured before it can run properly. These variables are stored in a `.env` file to keep sensitive information separate from the docker-compose configuration.

### Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `PANGOLIN_ENDPOINT` | The URL endpoint for the Pangolin service | `https://pangolin.th-luebeck.me` |
| `NEWT_ID` | Your Newt client ID (obtained from service provider) | `your_newt_client_id` |
| `NEWT_SECRET` | Your Newt client secret (obtained from service provider) | `your_newt_client_secret` |

### Setup Instructions

#### Step 1: Copy the Template
```bash
cp env.template .env
```

#### Step 2: Edit the Environment File
Open the `.env` file in your preferred text editor and replace the placeholder values with your actual configuration:

```bash
# Example .env file
PANGOLIN_ENDPOINT=https://pangolin.th-luebeck.me
NEWT_ID=your_actual_newt_id
NEWT_SECRET=your_actual_newt_secret
```

#### Step 3: Verify Configuration
Make sure all required variables are set and contain valid values before starting the service.

### Security Notes

- **Never commit the `.env` file to version control** - it contains sensitive information
- The `.env` file is already included in `.gitignore` to prevent accidental commits
- Keep your `NEWT_SECRET` secure and don't share it with others
- Consider using a secrets management system for production deployments

### Usage

After setting up the `.env` file, you can start the service:

```bash
docker-compose up -d
```

To check the logs and verify the service is running correctly:

```bash
docker-compose logs -f newt
```

### Troubleshooting

If you encounter issues:

1. **Check file permissions**: Ensure the `.env` file is readable by the Docker process
2. **Verify variable names**: Make sure variable names match exactly (case-sensitive)
3. **Check for typos**: Ensure there are no extra spaces or special characters
4. **Restart the service**: After making changes to `.env`, restart the Docker container
