#!/bin/bash

# Exit if there is an error
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Help
if [ $# == 0 ]; then
    echo "
    Usage:
      observium-alerts.sh export [<filename.sql>]
      observium-alerts.sh import [<filename.sql>]
    "
    exit
fi

# Check all required variables are set
: "${OBSERVIUM_MYSQL_PASSWORD:?must be set}"

OBSERVIUM_MYSQL_USERNAME=${OBSERVIUM_MYSQL_USERNAME:-observium}
OBSERVIUM_MYSQL_DB=${OBSERVIUM_MYSQL_DB:-observium}

COMMAND=${1,,}
FILENAME=${2}
: "${FILENAME:?must be set}"

# Commands
case $COMMAND in

    "export")
        /usr/bin/mysqldump -u$OBSERVIUM_MYSQL_USERNAME -p$OBSERVIUM_MYSQL_PASSWORD $OBSERVIUM_MYSQL_DB alert_tests alert_assoc > $FILENAME
        echo "Observium alerts exported to $FILENAME"
        ;;
    "import")
        read -p "This will remove your existing alerts - are you sure? (y/n)" -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            /usr/bin/mysql -u$OBSERVIUM_MYSQL_USERNAME -p$OBSERVIUM_MYSQL_PASSWORD $OBSERVIUM_MYSQL_DB < $FILENAME
            echo "Observium alerts imported from $FILENAME"
        fi
        ;;
    *)
        echo "Unknown command: $COMMAND"
        exit
        ;;
esac
