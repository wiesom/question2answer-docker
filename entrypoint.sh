#!/bin/bash
set -e
set -u
set -x
config_file=/var/www/html/qa-config.php
config_file_example=/var/www/html/qa-config-example.php

set_config() {
	key="$1"
	value="$2"
	php_escaped_value="$(php -r 'var_export($argv[1]);' "$value")"
	echo "define('${key}', ${php_escaped_value});" >> $config_file
}

if [ -e $config_file ];then
    rm $config_file
fi

cat  $config_file_example | grep -v "define('QA_MYSQL_HOST" | grep -v "define('QA_MYSQL_USER" | grep -v "define('QA_MYSQL_PASS"| grep -v "define('QA_MYSQL_DATABASE" > $config_file

echo "" >> $config_file

set_config 'QA_MYSQL_HOSTNAME' "${QUESTION2ANSWER_DB_HOST:-mysql}"
set_config 'QA_MYSQL_USERNAME' "${QUESTION2ANSWER_DB_USER}"
set_config 'QA_MYSQL_PASSWORD' "${QUESTION2ANSWER_DB_PASSWORD}"
set_config 'QA_MYSQL_DATABASE' "${QUESTION2ANSWER_DB_NAME}"

exec "$@"