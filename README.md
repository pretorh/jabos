jabos
=====

Just A Bunch Of Scripts.

A collection of bash scripts for Linux and some general quick refrences


# Google #
## Google drive ##
### create ###
starts a resumable upload into a specified parent id.
https://www.googleapis.com/upload/drive/v2/files?uploadType=resumable

parameters:

+ `access_token` Google oauth2 access token
+ `parent_id` Google drive file id for the parent of the file
+ `file` path to the file
+ `title` optional. defaults to file name

outputs:

+ the https url that should be used to upload the file

### update ###

resume file upload

parameters:

+ `upload_url` url returned by a https://www.googleapis.com/upload/drive/v2/files?uploadType=resumable request
+ `access_token` Google oauth2 access token
+ `file` path to the file

outpus:

+ file name containing the detailed json results of the file upload

## oauth2 ##
### token-info ###
returns token information for a Google oauth2 token

parameters:

+ `access_token` Google oauth2 access token

output:

+ `expiration time`: seconds until the token expires
+ `scope`: scope of the token

### refresh ###

Acquire a new access token from a refresh token.
https://accounts.google.com/o/oauth2/token

parameters:

+ `client_id` the client id as on https://code.google.com/apis/console
+ `client_secret` the client secret as on https://code.google.com/apis/console
+ `refresh_token` the refresh token acquired previously

output:

+ `access_token`

# database #
## mongo ##
### backup ###
connect to the local running mongod instance, dump the specified database and tar-gzip it to a file based on the db name and date

parameters:

+ `db name`     name of the database to dump

output:

+ `filename` of the .tar.gz file


# security #
## encryption ##

### gpgcrypt ###
encrypt a file for multiple recipients using gpg

parameters:

+ `file`            the path for the file to encrypt
+ `recipient`...    a list of the recipients

output:

+ `filename`        of the encrypted file
