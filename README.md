# MEGA to Rclone Sync GitHub Action

This workflow automates downloading files from MEGA and uploading them to a remote storage via Rclone.

## Setup Instructions

### 1. Create Repository Secrets

You need to add the following secrets to your GitHub repository:

- `MEGA_EMAIL`: Your MEGA account email
- `MEGA_PASSWORD`: Your MEGA account password
- `RCLONE_CONFIG`: Your base64-encoded rclone.conf file
- `DEFAULT_MEGA_URL` (optional): Default MEGA URL to use for scheduled runs

To base64 encode your rclone.conf:

```bash
base64 -w 0 rclone.conf > rclone_base64.txt
```

Then copy the contents of rclone_base64.txt into the `RCLONE_CONFIG` secret.

### 2. Directory Structure

Ensure your repository has the following structure:

```
your-repo/
├── .github/
│   └── workflows/
│       └── mega_sync.yml
└── (other files)
```

### 3. Running the Workflow

#### Manual Trigger:
1. Go to the "Actions" tab in your repository
2. Select "MEGA to Rclone Sync" workflow
3. Click "Run workflow"
4. Enter the MEGA URL you want to download from
5. Click "Run workflow" button

#### Automated Schedule:
The workflow is configured to run daily at midnight UTC. You can modify the schedule in the workflow file.

### 4. Troubleshooting

- Check the workflow logs for detailed error messages
- Ensure your MEGA and Rclone credentials are correct
- Verify that the MEGA URL is valid and accessible with your account
- Check if your rclone remote "NewDrop" is configured correctly in your rclone.conf

## Security Considerations

- Your MEGA and Rclone credentials are stored as GitHub Secrets and are not exposed in logs
- For additional security, consider using GitHub's OIDC with your cloud provider for authentication
- Set appropriate permissions for your workflow

## Customization

- Adjust the timeout, cron schedule, or resource allocation as needed
- Modify the rclone parameters in the "Upload to Rclone destination" step for different performance characteristics
