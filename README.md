# Classroom Observation Tool

The Classroom Observation Tool provides a web-based tool for 
recording in-class observation during review. It is based
upon the work of Paul Magnuson and others.

View the application at https://observations.las.ch

## App Upgrading

Ideally, this app should be managed by chef. However, there is no guarantees that this will happen. In that case, you will need to upgrade manually.

```
$ ssh manager@observations.las.ch
$ cd /var/www/prolearning
$ git pull origin master
Username for 'https://bitbucket.org': itnotification
Password for 'https://bitbucket.org': <find this password in 1password>
```