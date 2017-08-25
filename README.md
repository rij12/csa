# README

Code for the SE31520/CHM5820 CSA (CS Alumni Application), V4b

This version corresponds to the worksheet on authentication and authorisation and the 
lecture on Rails security.

A series of further version will be provided as the module progresses.


* Running
Start using two command line windows:
In one start puma in non-ssl mode, type:

puma

In the other start in ssl mode. Here is an example:

puma -b 'ssl://127.0.0.1:3001?key=/Users/chrisloftus/.ssh/server.key&cert=/Users/chrisloftus/.ssh/server.crt'

To generate self-signed certificates for testing see: https://gist.github.com/tadast/9932075 

* Ruby version
This has been developed with ruby 2.4.1

* Database creation
An example development database is included

* Installation dependencies
ImageMagick must be installed

*  Testing
No extra tests were developed during this workshop, only those generated automatically
or developed in earlier workshops.
