#!/bin/bash

##
# Website status check script
# Author: Siim Aarmaa
# Date: 06.06.2021
##

##
# Discord webhook
##
url="https://discord.com/api/webhooks/"

##
# List of websites to check
##
websites_list="aarmaa.ee"
status_text="is running!"
error_text="showing error"

for website in ${websites_list} ; do
        status_code=$(curl --write-out %{http_code} --silent --output /dev/null -L ${website})

        if [[ "$status_code" -ne 200 ]] ; then
            # POST request to Discord Webhook with the domain name and the HTTP status code
            curl -H "Content-Type: application/json" -X POST -d '{"content":"'"${website} ${error_text} ${status_code}"'"}'  $url
        else
            curl -H "Content-Type: application/json" -X POST -d '{"content":"'"${website} ${status_text}"'"}' $url
        fi
done
