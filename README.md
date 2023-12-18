# Print XWord
This script downloads the latest daily New York Times crossword and sends it to your printer.

## Requirements
* An active NYTimes Games subscription
* A computer and printer that are awake/on standby when the script runs

## Setup

While logged into your account at https://www.nytimes.com/crosswords, open your browser's developer console and enter `document.cookies`. Copy the full cookie text into `NYT_COOKIE=""`

## Testing the script
To manually run the script:

```
bash print-xword.sh
```

It should print, to your default printer, tomorrow's crossword if available (ie. it's after 10pm local time). Otherwise, it'll print the current day's crossword.

## Automate with cron
Set up a cron job by running:

```
crontab -e
```

And adding the following line, replacing `your-path` with the path to your script:

```
01 22 * * * /your-path/print-xword.sh > /dev/null 2>&1
```

The first two numbers represent the minute (0–59) and hour (0–23) the job runs. As configured above, the script runs every day at 22:01 (10:01PM) local time. `> /dev/null 2>&1` suppresses logging. More on cron expressions can be found in [this guide](https://medium.com/@justin_ng/how-to-run-your-script-on-a-schedule-using-crontab-on-macos-a-step-by-step-guide-a7ba539acf76).

Verify that it's saved with:

```
crontab -l
```

Give it executable permissions so it will run in cron:

```
chmod +x /your-path/print-xword.sh
```

## Printing to a non-default printer
If you have more than one printer, you can choose which to print to via the `-P` option in `lpr`:

```
lpr -P your-printer-name -o media=Letter -o fit-to-page
```

`lpstat -p -d` will show a list printer names. See the [CUPS manual](https://www.cups.org/doc/options.html#PRINTER) for additional print options.

## Further notes
The NYT cookie expires after some time (often months or longer). You'll have to update `NYT_COOKIE` with the new cookie when it does. Unfortunately, nytimes.com changed their login system a few years ago in a way that makes it difficult to fetch the cookie automatically from a username/password, hence this workaround.