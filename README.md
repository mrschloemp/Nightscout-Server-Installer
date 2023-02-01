# Nightscout-Server-Installer
# Anleitung und Download unter: https://www.michael-schloemp.de/2023/01/16/nightscout-server-installer/
Der Nightscout Installer und lädt fast alle Dateien/Pakete herunter, die für die

Verwendung von Nightscout nötig sind.


Apache 2 wird deinstalliert und gelöscht, dafür wird nginx als Webserver installiert.

Der Installer arbeitet automatisch alle Punkte ab, wenn Fehlermeldungen erscheinen,

läuft der Installer weiter und es kann vorkommen, dass Nightscout im Anschluss nicht

funktioniert.

Für die Funktionalität kann keine Gewährleistung übernommen werden.


Datenbank Benutzername, Passwort und Datenbankname ist in dem Script vorgegeben.

In Zeile 51 der Datei „launch.sh“ sind die Daten für Datenbank, Benutzername und

Passwort enthalten.

Werden dort Änderungen vorgenommen, so muss das in der start.sh Zeile 5

ebenfalls geändert werden.


Standard Datenbankname: Nightscout

Datenbankbenutzer: Mongobenutzer

Passwort: myCgn4hmhQN639BH

Der Api-Secret wird in der start.sh Zeile 7 angepasst.

Standardmäßig ist das Api-Secret: bjXBztyVPbHyGePz


Um die Sicherheit zu Gewährleisten empfehle ich das Ändern der Passwörter.

Dies sollte vor der Installation erfolgen, um Fehlfunktionen auszuschließen.


Der Installer kann nicht die volle Arbeit abnehmen.

Er Übernimmt aber einen Großteil der Aktionen, die Erforderlich sind.

Grundlegende Dinge wie neuen Benutzer anlegen und NodeJs/NVM installieren,

das Einrichten des SSL Zertifikat, die Host Datei anpassen und das Einrichten der

Portweiterleitung kann das Script nicht übernehmen.

Das Script spart Zeit und abtippen der Befehle.

# Readme start

Logge dich per SSH mit Putty auf deinem Server ein.
Erstelle einen neuen Benutzer mit dem Namen "mainuser"

 adduser mainuser

mainuser Root:

$ usermod -aG sudo mainuser

check Root/SU:

$ su mainuser

$ grep '^sudo' /etc/group

Check Updates/Install Updates

$ sudo apt-get update
$ sudo apt update
$ sudo apt upgrade -y

Install NodeJS with features:

$ sudo apt install nodejs -y build-essential checkinstall -y libssl-dev -y

Download NVM:

$ wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

Schließe die Putty Sitzung und logge dich wieder neu per SSH auf den Server mit dem mainuser Account ein.

$ source /etc/profile

nvm installieren:

$ nvm install 14.18.1

nvm Version auswählen:

$ nvm use 14.18.1

Wget Download Installer

Automatischer Download Wget

Um den Nightscout-Installer auf dem Server ausführen zu können,
ist ein Download notwendig.
Diesen führen wir mit dem Wget Befehl aus. Dazu in der Putty Konsole
folgenden Befehl eingeben:

wget -r -p -x -np -nH --reject "index.html*" --recursive http://ns-installer.michael-schloemp.de/

Es werden alle erforderlichen Dateien (identisch wie die Zip Datei beim FTP Upload)
heruntergeladen.
Nach dem herunterladen müssen die Zugriffsrechte geändert werden:

chmod -R 775 base/ vollinstallation/ ns-installer.sh


Installer ausführen

Gehe zurück nach Putty und starte den Nightscout Installer:

$ bash ns-installer.sh

gebe

launch.sh

ein und bestätige die Eingabe

Nun läuft der Installer durch und lädt/installiert die nötigen Komponenten.

Nachdem der Installer durchgelaufen ist, kommt eine Erfolgsmeldung

Script ausgeführt
Script executed

Manuelle Einrichtung

Nach der Erfolgsmeldung geht es weiter mit der manuellen Einrichtung der host/Domain etc...

Als erstes wechseln wir das Verzeichnis

cd cgm-remote-monitor

Anschließen führen wir die start.sh einmal aus

$ bash start.sh

Wenn die start.sh Ordnungsgemäß durchgeführt wurde, erscheint einen Meldung in Grün

"WS:"

Mit strg+c beenden wir die Ausführung

Nightscout Service einrichten und starten

$ sudo systemctl daemon-reload

Nigtscout Service aktivieren und starten:

$ sudo systemctl enable nightscout.service


$ sudo systemctl start nightscout.service

Nightscout Service Status anzeigen lassen:

$ sudo systemctl status nightscout.service

Der Satus muss Grün, active sein. Ist er das nicht, liegt eine Fehlkonfiguration vor.

Host Datei anpassen

In diesem Tutorial verwende ich eine duckdns.org Domain. Duckdns.org ist ein DynDny Dienstleister, die DynDNS lässt sich problemlos als Domain für den Server Verwenden.

$ sudo nano /etc/hosts

Hier wird nach dem Muster ip Domain eintragen beispiel:

123.255.14.388 subdomain.duckdns.org

Mit strg+x wird Nano geschlossen, mit Y bestätigen wir das die Datei gespeichert wird.

Domain Konfiguration anlegen

Als erstes daktivieren wir die default Konfiguration.

sudo unlink /etc/nginx/sites-enabled/default

Anschließend erstellen wir eine neu Konfiguration (subdomain.duckdns.org durch deine Domain ersetzen).

sudo nano /etc/nginx/sites-available/subdomain.duckdns.org.conf

Diesen Bereich kopieren und anpassen auf deine Domain/DynDNS:

server {
listen 80;

server_name subdomain.duckdns.org;
server_name www.subdomain.duckdns.org;

location / {
proxy_pass http://127.0.0.1:1337;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header X-Forwarded-Proto "https";
}
}

Konfiguration aktivieren

Als nächstes aktivieren wir die Konfiguration und starten anschließen nginx neu.

sudo ln -s /etc/nginx/sites-available/subdomain.duckdns.org.conf /etc/nginx/sites-enabled/

sudo service nginx restart

SSL-Zertifikat erstellen

Damit man AAPS nutzen kann, ist eien SSL Verbindung von nöten. Das erstellen wir mit Certbot und Let´s Encrypt.

sudo certbot --nginx -d subdomain.duckdns.org -d www.subdomain.duckdns.org

Bei der ersten Zertifikatserstellung muss eine E-Mailadresse angegeben werden, Nutzungsbedingungen mit A bestätigen.
Newsletter nach Wahl ja oder nein. Redirect mit 2 (automatische Weiterleitung auf https) bestätigen.

Certbot Timer prüfen:

$ sudo systemctl status certbot.timer

Erneuerungsprozess testen

$ sudo certbot renew --dry-run

Das war´s. Nun erscheint beim Aufruf der Doamin deine Nightscout Instanz.

Nach der Installation sollten die Nightscout-Installer Dateien und Verzeichnisse vom Server gelöscht werden.

Dazu in der Konsole zurück in den Übergeordneten Verzeichnis mit dem Befehl "cd" wechseln.
Anschließend zum löschen folgenden Befehl eingeben:

rm -r vollinstallation base icons ns-installer.sh
