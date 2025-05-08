# MEGA to Rclone Sync

This repository contains a GitHub Actions workflow that automatically processes MEGA links and transfers the content to a remote storage using Rclone.

## How It Works

1. The workflow reads links from `pending_links.txt`
2. It processes the first link in the list (downloads and transfers)
3. Once completed, it moves the processed link to `done_links.txt` with a timestamp
4. The workflow can be triggered manually or runs on a daily schedule

## Setup Instructions

### 1. Repository Structure

Ensure your repository has the following files:
- `.github/workflows/mega_sync.yml` - The workflow file
- `pending_links.txt` - List of MEGA links to process (one per line)
- `done_links.txt` - Record of processed links (created automatically)

### 2. GitHub Secrets

Add the following secrets to your repository:
- `MEGA_EMAIL` - Your MEGA account email
- `MEGA_PASSWORD` - Your MEGA account password
- `RCLONE_CONFIG` - Your base64-encoded rclone.conf file
- `GITHUB_TOKEN` - This is provided automatically by GitHub

To base64 encode your rclone.conf:
```bash
base64 -w 0 rclone.conf > rclone_base64.txt
```

### 3. Managing MEGA Links

- Add new links to `pending_links.txt` (one URL per line)
- Each workflow run processes exactly one link
- Processed links are automatically moved to `done_links.txt`
- The workflow will skip execution if there are no pending links

### 4. Running the Workflow

#### Manual Trigger
1. Go to the "Actions" tab in your repository
2. Select "MEGA to Rclone Sync" workflow
3. Click "Run workflow"

#### Automated Schedule
- The workflow runs daily at midnight UTC
- You can modify the schedule in the workflow file

## Monitoring Progress

- Check the workflow run logs to see which link was processed
- View `done_links.txt` for a history of processed links with timestamps
- The remaining links in `pending_links.txt` are pending processing
