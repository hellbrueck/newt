# newt
some helper tools for newt

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
