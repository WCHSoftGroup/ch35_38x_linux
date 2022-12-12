#!/bin/sh
cd driver_pre && make install && cd ..
cd driver && make install

echo 'wch\nwch_pre' > /etc/modules