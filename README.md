# Linux Server Health Monitor

A Bash scripting project that monitors basic system health on an Ubuntu Linux server running on AWS EC2.

## Features

- Displays hostname, current user, and system uptime
- Reports CPU load average and compares it with a configurable threshold
- Checks memory usage and warns when usage reaches the configured threshold
- Checks root filesystem usage and warns when usage reaches the configured threshold
- Displays a timestamp for each health check
- Saves reports to a local log file

## Technologies Used

- Ubuntu Linux
- AWS EC2
- Bash scripting
- Linux command-line utilities
- Git and GitHub

## Configuration

The current script uses these example thresholds:

- CPU load: 80% of the number of available CPU cores
- Memory usage: 80%
- Root disk usage: 80%

These are configurable learning-project thresholds, not universal production alerting standards.

## How to Run

Clone the repository:

```bash
git clone https://github.com/Neo-Aura/linux-server-health-monitor.git
cd linux-server-health-monitor
```

Make the script executable:

```bash
chmod +x health-monitor.sh
```

Run the health monitor:

```bash
./health-monitor.sh
```

View the saved log:

```bash
tail -n 30 logs/health-monitor.log
```

## Example Checks

The script reports CPU load, memory usage, and root disk usage, with an `OK` status or a warning when a configured threshold is reached.

## What I Learned

- Writing Bash scripts for Linux administration
- Reading system metrics using Linux commands
- Using conditional statements for threshold-based alerts
- Saving terminal output to log files
- Practicing system monitoring on AWS EC2

## Project Status

Learning project — developed and tested on an Ubuntu AWS EC2 instance. Further improvements may be added as I continue learning Linux administration and Cloud/DevOps.
