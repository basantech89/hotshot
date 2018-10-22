#!/bin/bash
apt-get remove -y *ovd* *inuvika* mysql-server
rm -r $(find / -name *ovd*)
rm -r $(find / -name *inuvika*)
apt-get -y autoremove
apt-get clean
apt-get autoclean
