# Postfix for Docker

only for outgoing messages.
allows connection to the SMTP server from 
[private networks](https://en.wikipedia.org/wiki/Private_network) (10.0.0.0/8, 172.16.0.0/12 and 192.168.0.0/16) 
without authentication.


## configuration

### POSTFIX_DOMAIN (mydomain)

Set the domain name. Also sets the host name in the e-mail address if the host name is not an FQDN.
Will become the value vor **myorigin**, so we get something like 'user@<POSTFIX_DOMAIN>' as email sender info.

see http://www.postfix.org/postconf.5.html#mydomain

### POSTFIX_HOSTNAME (myhostname)

Default: `<container-hostname-hash>`

Set the hostname used for sender information in sent emails.

see http://www.postfix.org/postconf.5.html#myhostname

### POSTFIX_HELO_NAME 

Default: `<POSTFIX_HOSTNAME>`

Set the hostname used for introduction between smtp servers (in HELO or EHLO step).
The receiver identifies the sender with this name, it's IP and the according matching spf entry of the dns provider.

see http://www.postfix.org/postconf.5.html#smtp_helo_name


### POSTFIX_MY_NETWORKS

Default: `10.0.0.0/8 172.16.0.0/12 192.168.0.0/16`

Set the networks (IP-range) permitted to send emails over this relay. 
Defaults to networks within docker overlay network or typical local networks for development. 
Containers like 'humilit/common' or derivates of it in the same docker stack/network can use this as 'smtp' target.


### POSTFIX_SMTP_TLS_SECURITY_LEVEL

* Default: `may`
* Example: `POSTFIX_SMTP_TLS_SECURITY_LEVEL="may"`

Set the default security level for outgoing mails.

Valid levels are **none**, **may**, **encrypt**, … 

see http://www.postfix.org/postconf.5.html#smtp_tls_security_level



### POSTFIX_SMTP_TLS_POLICY_MAPS

* Default: `empty`
* Example: `POSTFIX_SMTP_TLS_POLICY_MAPS="foo.example.com encrypt\nbar.example.com may"`

tls policy maps allow setting different security levels for different subdomains

Valid levels are **none**, **may**, **encrypt**, … 

* see http://www.postfix.org/postconf.5.html#smtp_tls_security_level
* see http://www.postfix.org/postconf.5.html#smtp_tls_policy_maps


## Volumes

### /var/spool/postfix

To keep the unsent emails even when the container is restarted, 
create a volume for `/var/spool/postfix`.
