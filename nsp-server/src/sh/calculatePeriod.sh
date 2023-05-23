#!/bin/bash
# calculate period netween to dates

 
# Set default values for parameters

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -sd|--start-date)
    start_date="$2"
    shift # past argument
    shift # past value
    ;;
    -ed|--end-date)
    end_date="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./calculatePeriod.sh [-sd DATE] [-ed DATE]"
    echo "show period of time between start and end dates"
    echo "-sd, --start-date DATE: start date variable in the format "YYYY-MM-DD HH:MM:SS""
    echo "-ed --end-date DATE: end date variable in the format "YYYY-MM-DD HH:MM:SS""
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Set the start and end dates
#start_date="2022-01-01 12:00:00"
#end_date="2022-01-03 12:00:00"

echo $start_date
echo $end_date

# Convert the start and end dates to timestamps
start_timestamp=$(date -d "$start_date" +%s)
#echo "Start timestamp: $start_timestamp"

end_timestamp=$(date -d "$end_date" +%s)
#echo "End timestamp: $end_timestamp"

# Calculate the difference in timestamps
difference=$((end_timestamp - start_timestamp))

# Calculate the number of days, hours, minutes, and seconds
# in the period of time
days=$((difference / 86400))
hours=$((difference % 86400 / 3600))
minutes=$((difference % 3600 / 60))
seconds=$((difference % 60))

# Print the result
echo "Total simulation time: $days days $hours hours $minutes minutes $seconds seconds"
