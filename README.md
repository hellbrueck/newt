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

```bash
# Set up environment variables
cp env.template .env
# Edit .env with your configuration
nano .env

# Start the service
docker-compose up -d
```

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
