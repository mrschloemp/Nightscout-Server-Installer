# Nightscout-Server-Installer
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

