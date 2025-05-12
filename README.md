# TonerWatch

TonerWatch monitors printer toner levels via SNMP and notifies you when printers need a refill.

## Usage

1. Install the script

Run the following command to install TonerWatch and set up its operating environment:

```sh
bash <(curl -s https://raw.githubusercontent.com/Suirabu/tonerwatch/refs/heads/main/setup.sh)
```

2. Configure your printers

Update `printers.csv` to include your printer information in the following format:

```txt
PRINTER NAME,PRINTER LOCATION,IP ADDRESS,COLOR
```

Note: `COLOR` must either be `TRUE` (color printer) or `FALSE` (monoschrome).

Example:

```csv
HP LaserJet,Principals Office,192.168.1.45,FALSE
Canon ColorJet,Computer Lab,192.168.1.46,TRUE
```

3. Run the monitor script

```sh
bash monitor.sh
```

### Automate with Cron

To run the script automatically every weekday at 9:00 AM:

1. Open your crontab

```sh
$ crontab -e
```

2. Paste this line (replace the path with the full path to `monitor.sh`):

```txt
0 9 * * 1-5 /usr/bin/env bash path/to/monitor.sh
```

⚠️ Ensure your computer is powered on at the scheduled time for the cron job to run.