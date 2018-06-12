---

/!\ Work in progress, massive changes are to be applied!

---

# Zabbix Simple Web Check

Based on https://github.com/a-schild/zabbix-ssl 

The goal is to be able to monitor large number of sites with one simple json config.

```javascript
{
    "data":[
        { "{#URL}": "https://site1.domain.com", "{#REGEXP}":"Powered.by.Wordpress"},
        { "{#URL}": "http://site2.domain.com/app", "{#REGEXP}":"Powered.by.Joomla"}
    ]
}
```

The script checks if the site is available (HTTP 200 OK) and if the content matches given regexp.

In case of failure trigger is activated.

It doesn't collect any data.

Following curl options are set by default:
* --insecure - SSL certificates should be verified in separate process
* --silent 
* --max-filesize 10000000 - in case the web application went rogue
* --retry-connrefused - treat "connection refused" as transient error (to handle web server restarts) 
* --connect-timeout 30 
* --max-time 600 - just in case


## How to install ##
* Download the simplewebcheck.sh file to your **Zabbix Server**
  external script directory (Or your proxy if the servers are behind a Zabbix proxy)
  For example ExternalScripts=/usr/lib/zabbix/externalscripts
* Make it executable
* Import the templates for the different check types in your zabbix server
* Assign the templates to the hosts you wish to monitor
* Put the /etc/zabbix/zabbix_agentd.d/simplewebcheck-sites.conf in the config directory
  of your **client agent** (The server where your sites reside)
* Put the /etc/zabbix/simplewebcheck_sites.json in the config directory
  of your **client agent** (The server where your sites reside)
  and modify the list of urls which should be checked.
  Make sure it has a valid json syntax
* Restart the zabbix agent


