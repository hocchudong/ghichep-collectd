#!/bin/bash 
eth0_address=`/sbin/ifconfig eth0 | awk '/inet addr/ {print $2}' | cut -f2 -d ":" `
echo "------------CAP NHAT HE THONG------------------"
apt-get update && apt-get -y dist-upgrade 
apt-get -y upgrade && apt-get -f install
echo "-----------------CAI DAT HE THONG-------------------------"
apt-get install -y graphite-web graphite-carbon
echo "--------------------------------------------------------"
echo "--------------------CAI DAT POSTGRESQL-------------------"
apt-get install -y  postgresql libpq-dev python-psycopg2
echo "---------Create a Database User and a Database------------"
cat << EOF |sudo -u postgres psql
  CREATE USER graphite WITH PASSWORD 'Admin123';
  CREATE DATABASE graphite WITH OWNER graphite;
 \q
EOF
echo " ------------------------------------------------------------"
echo "------------------CAU HINH GRAPHITE WEB APP-----------------"
filecollectd=/etc/graphite/local_settings.py
#-------------------------------------------------------
test -f $filecollectd.bka || cp $filecollectd $filecollectd.bka
#-------------------------------------------------------- 
rm $filecollectd
#-----------------Tao file moi rong-----------------------------------------
touch $filecollectd
#---------------------------------------------------------------------------------- 
cat << EOF >> $filecollectd 
SECRET_KEY = 'a_salty_string'
TIME_ZONE = 'Asia/Ho_Chi_Minh'
LOG_RENDERING_PERFORMANCE = True
LOG_CACHE_PERFORMANCE = True
LOG_METRIC_ACCESS = True
GRAPHITE_ROOT = '/usr/share/graphite-web'
CONF_DIR = '/etc/graphite'
STORAGE_DIR = '/var/lib/graphite/whisper'
CONTENT_DIR = '/usr/share/graphite-web/static'
WHISPER_DIR = '/var/lib/graphite/whisper'
LOG_DIR = '/var/log/graphite'
INDEX_FILE = '/var/lib/graphite/search_index'  # Search index file
USE_REMOTE_USER_AUTHENTICATION = True
DATABASES = {
'default': {
'NAME': 'graphite',
'ENGINE': 'django.db.backends.postgresql_psycopg2',
'USER': 'graphite',
'PASSWORD': 'Admin123',
'HOST': '127.0.0.1',
'PORT': ''
    }
  }
EOF
sleep 3
#-------------------------------------------------------------------------
echo "------DONG BO DU LIEU--------------------------------------------------------------------------------"
sudo graphite-manage syncdb
sleep 3
echo "----------------SUA FILE CAU HINH CARBON-----------------------------"
sed -i 's/false/true/g'  /etc/default/graphite-carbon
sleep 3
sed -i 's/false/true/g'  /etc/carbon/carbon.conf
echo "---------------Configure Storage------------------------------"
sudo cp /usr/share/doc/graphite-carbon/examples/storage-aggregation.conf.example /etc/carbon/storage-aggregation.conf
sleep 3
echo "---KHOI DONG LAI DICH VU CARBON-------------------------"
sudo service carbon-cache start
echo "------------------------------------------------------------------------------"
echo "-----------------CAI DAT VA CAU HINH WEBSERVER--------------------------------"
sudo apt-get  -y install apache2 libapache2-mod-wsgi
sudo apt-get update
#--------------------------------------------------------------------------------------
sudo a2dissite 000-default
#--------------------------------------------------------------------------------------
sudo cp /usr/share/graphite-web/apache2-graphite.conf /etc/apache2/sites-available
#-----------------------------------------------------------------------------------
sudo a2ensite apache2-graphite
#--------------------------------------------------------- ------------------------- 
echo "-----------KHOI DONG LAI DICH VU APACHE--------------------------------------"
sudo service apache2 reload
#------------------------------------------------------------------------------------"
echo "Truy cap vao tai khoan http://$eth0_address"
#------------------------------------------------------------------------------------
