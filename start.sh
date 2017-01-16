#!/bin/sh
. /sabnzbd/configure.env
PYTHON=/usr/bin/python
SABNZBD=/sabnzbd
DATA=/Config/sabnzbd

if [ -r $DATA/sabnzbd_config.ini ];
then
	$PYTHON $SABNZBD/SABnzbd.py --config-file=$DATA/sabnzbd_config.ini
else
	mkdir -p $DATA/admin
	sed -i -- "s/newsserv/$NEWSSERV/g" "/$SABNZBD/sabnzbd_config.ini"
	sed -i -- "s/newsuser/$NEWSUSER/g" "/$SABNZBD/sabnzbd_config.ini"
	sed -i -- "s/newspass/$NEWSPASS/g" "/$SABNZBD/sabnzbd_config.ini"
	sed -i -- "s/newsconn/$NEWSCONN/g" "/$SABNZBD/sabnzbd_config.ini"
	mv $SABNZBD/server.* $DATA/admin/
	mv $SABNZBD/sabnzbd_config.ini $DATA
	$PYTHON $SABNZBD/SABnzbd.py --config-file=$DATA/sabnzbd_config.ini
fi
