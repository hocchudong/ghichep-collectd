#!/usr/bin/python

import requests
import logging
import json
import os
import shutil

IP_CON = '172.16.69.50'
mypath = '/var/lib/graphite/whisper/collectd'
admin_id = 'bcfb67cf1d3947ae8e87ef66087a68a9'
admin_pass = 'Welcome123'
admin_project_id = 'e42a00c2ba6c4bbaa4bf4d8d22e260c2'
ssl = https

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO)
loger = logging.getLogger(__name__)

def get_token():
    token = 'a'
    response = 'b'
    try:
        json_payload = {
          "auth": {
              "identity": {
                  "methods": [
                      "password"
                  ],
                  "password": {
                      "user": {
                          "id": admin_id,
                          "password": admin_pass
                      }
                  }
               },
               "scope": {
                   "project": {
                       "id": admin_project_id
                   }
               }
           }
        }

        headers = {'content-type': 'application/json', 'accept': 'application'}
        response = requests.post(url='{0}://{1}:35357/v3/auth/tokens'.format(ssl,IP_CON),
                                       data=json.dumps(json_payload),
                                       headers=headers,verify=False)
        token = response.headers.get('X-Subject-Token')
    except Exception as e:
          loger.critical(e)
    return token

def list_vms(token):
    try:
        headers = {'X-Auth-Token':token}
        response = requests.get(url='{0}://{1}:8774/v2.1/e42a00c2ba6c4bbaa4bf4d8d22e260c2/servers?all_tenants=1'.format(ssl,IP_CON), headers=headers,verify=False)
    except Exception as e:
        loger.critical(e)
    return response.json()

def list_db_whisper():
    list_dir = os.listdir(mypath)
    return list_dir

def main():
    token = get_token()
    vms = list_vms(token)
    instances = vms.get('servers')
    list = []
    for i in instances:
        list.append(i.get('id'))
    print list
    files = list_db_whisper()
    print files
    diff = set(files) - set(list)
    for i in diff:
        print i
        shutil.rmtree(os.path.join(mypath, i))

if __name__ == '__main__':
    main()
