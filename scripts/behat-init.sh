#!/bin/sh
#set -e

if [ -e /.behat-installed ]; then
  echo 'Behat already installed.'

else
  echo ''
  echo 'INSTALLING'
  echo '----------'

  # Install Java, Firefox, Xvfb, and unzip
  apt-get -y install openjdk-7-jre-headless firefox xvfb unzip

  wget "http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.1.jar"
  mv selenium-server-standalone-2.42.1.jar /usr/local/bin

  # So that running `vagrant provision` doesn't redownload everything
  touch /.behat-installed
fi

# Release old locks
echo "Releasing old XVFB locks from /tmp..."
cd /tmp
sudo rm -rf .X*-lock

echo "Starting Selenium Server. Default screen resolution: 1280x1024."
cd /usr/local/bin
DISPLAY=:1 xvfb-run --server-args="-screen 0 1280x1024x8" java -jar ./selenium-server-standalone-2.42.1.jar > /dev/null 2>&1 &

echo "Give Selenium Server a few minutes to fireup, then run your BDD tests."