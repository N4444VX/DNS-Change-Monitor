#!/bin/bash
# dig & archive DNS records for IPs and such
# echo changes and log DNS lookup IPs to output.txt file

## Set variables for main functions
date=$(date)
dir=$(/bin/pwd)
sites='/sites.txt'
output='/output.txt'
new_output='/newoutput.txt'
IFS=$'\n'
set -f

## delet results from last run
rm $dir$new_output

## do the thing
for i in $(cat < $dir$sites); do
 echo $i $(dig +short $i) >> $dir$new_output
done

## Output results to cli
date
echo "Changed:"
diff --suppress-common-lines $dir$output $dir$new_output
echo ""
echo "Results"
cat $dir$new_output

## Set $diff variable for Mailing only the changes
diff=$(diff --suppress-common-lines $dir$output $dir$new_output)

# email on diff (DNS Change) using mailgun.com API SMTP relay
if ! cmp $dir$output $dir$new_output  >/dev/null 2>&1
then
echo "PING!!"

# The variables below are not /bin/bash variables (except $diff) but
# should be changed to your mailgun.com account information
curl -s --user 'api:$YOUR_API_KEY' \
    https://api.mailgun.net/v3/$YOUR_SMTP_DOMAIN/messages \
    -F from='Joe Blow <EMAIL@DOMAIN.TLD>' \
    -F to='EMAIL@DOMAIN.TLD' \
    -F subject='DNS Change!!' \
    -F text="$date $diff"
fi

# overwrite current results to file for comparison next time
cat $dir$new_output > $dir$output
