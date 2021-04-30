$TTL 7200 ; default para registros sem TTL
;
@	IN	SOA	ns1.asf.com.	analista.asf.com. (
	2021042901 ; serial
	8h ; refresh
	1h ; retry
	3d ; expire
	3h ; negative caching TTL
);
;
@			IN	NS		ns1.asf.com.
@			IN	NS		ns2.asf.com.
@			IN	MX		10 mail.asf.com.
@			IN	A		192.168.1.40
ns1			IN	A		192.168.1.10
ns2			IN	A		192.168.1.20
www			IN	A		192.168.1.40
ftp			IN	CNAME	www
mail		IN	A		192.168.1.20
smtp		IN	CNAME	mail
pop			IN	CNAME	mail
imap		IN	CNAME	mail
webmail		IN	CNAME	mail
