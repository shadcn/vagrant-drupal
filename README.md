vagrant-drupal
==============

Vagrant for Drupal development: A clone of https://drupal.org/project/vdd with some tweaks.

### Dependencies

    $ vagrant plugin install vagrant-hostsupdater
    
### Installation

    $ git clone https://github.com/arshad/vagrant-drupal.git vagrant-SITENAME
    $ cd vagrant-SITENAME
    
Edit config.json and configure IP, Site name, and Git. Set *behat* to true if you need Behat and Selenium. Then run:
    
    $ vagrant up

Once vagrant is provisioned and up, you can remove everything inside www and place Drupal in there.

See https://github.com/arshad/vagrant-d8 for Drupal 8
