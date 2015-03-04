#!/bin/sh
#set -e

if [ -e /.selenium-installed ]; then
  echo 'Selenimum already installed.'

else
  echo ''
  echo 'Installing composer'
  echo '----------'

  # Install Composer
  sudo apt-get install php5-curl
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer

  echo ''
  echo 'Installing Java, Firefox and xvfb'
  echo '----------'

  # Install Java, Firefox, Xvfb, and unzip
  sudo apt-get -y install openjdk-7-jre-headless firefox xvfb unzip

  echo ''
  echo 'Installing selenium'
  echo '----------'

  sudo wget "http://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar"
  sudo mv selenium-server-standalone-2.45.0.jar /usr/local/bin

  # So that running `vagrant provision` doesn't redownload everything
  sudo touch /.selenium-installed
fi

# Release old locks
echo "Releasing old XVFB locks from /tmp..."
cd /tmp
sudo rm -rf .X*-lock

echo "Starting Selenium Server. Default screen resolution: 1280x1024."
cd /usr/local/bin
DISPLAY=:1 xvfb-run --server-args="-screen 0 1280x1024x8" java -jar ./selenium-server-standalone-2.45.0.jar > /dev/null 2>&1 &

echo "Give Selenium Server a few minutes to fireup, then run your BDD tests."