#!/bin/bash

domainName="cesi.local"
email='testmail@test.fr'
rootDir='/etc/apache2/sites-available'
documentRoot='/var/www/test.local'

echo "
<VirtualHost *:80>

	ServerAdmin $email
	ServerName $domainName
	ServerAlias $domainName

	DocumentRoot $documentRoot

		ErrorLog /var/log/apache2/error.log

	LogLevel warn

	CustomLog /var/log/apache2/access.log combined

   </VirtualHost>" >> $rootDir/$domainName.conf

echo "127.0.0.1		$domainName" >> /etc/hosts
a2ensite $domainName.conf
/etc/init.d/apache2 reload

echo "
<html>
	<head>
		<title>Site cesi.local</title>
	</head>
		
	<body>
		<h1>Bienvenue sur le site cesi.local !</h1>
	</body>
</html>" >> $documentRoot/index.html