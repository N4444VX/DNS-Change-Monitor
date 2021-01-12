# DNS-Change-Monitor
Monitor a list of domain names for IP changes and email the difference

## How to run
pull
cd DNS-Change-Monitor
chmod 755 DNS-Change-Monitor.sh
./DNS-Change-Monitor.sh

## Notes
 List your URLs to watch in file "sites.txt" in the same directory as the script. 
 
 Run the script from it's directory unless you set the directory explicitly in the script
 
 Uses mailgun.com SMTP Relay to send changes via email. You must have an account (free tier available) to use mailgun.org and insert your account variables in the section regarding the mailgun information.
