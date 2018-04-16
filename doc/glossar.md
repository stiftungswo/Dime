# Glossar
Die Namen in der Domain sind leider etwas inkonsistent. Dass sie im Frontend auf Deutsch und im Code auf Englisch vorhanden sind und dann teilweise auf der Datenbank nochmal anders heissen, hilft auch nicht. Hier werden kurz die wichtigsten Begriffe mit dem englischen Pendant verknüpft und erklärt.

#### Zeiterfassung

* Zeiteintrag (timeslice): Ein einzelner Arbeitsschrit einer Person, der auf eine *Aktivität* eines *Projekts* gebucht wird. Beispiel: "Max Müller hat am 4.12. für 8.4h im Projekt 'Ufer Zürichsee' Neophyten bekämpft". Timeslices werden auch für zeitlose Dinge missbraucht, z.B. "4x Fahrkostenpauschale am 4.12"
* Periode (period): Ein Arbeitszeitraum mit einem Arbeitspensum, worüber die *Zeiteinträge* zusammengezählt werden, um die Ist/Sollstunden und Ferien eines *Mitarbeiters* darzustellen.
* Kommentare (projectComments): Kommentare, die zu einem bestimmten Tag auf ein *Projekt* erfasst werden können.

#### Personen

* Kunde (customer): Die Auftraggeber. Besitzen eine Adresse und werden in *Offerten*, *Projekten* und *Rechnungen* zugewiesen.
* Mitarbeiter (employee/user): Die Arbeiter. Auf diese können *Zeiteinträge* gebucht werden. Dies sind auch die Benutzeraccounts, die sich in Dime einloggen können.

#### Offerten, Projekte, Rechnungen

*Offerten*, *Projekte* und *Rechnungen* sind eng verwandt und haben eine ähnliche Struktur: Einige Textfelder und dann eine Liste von *Services* (bzw. deren Ableitungen). Erst wird eine *Offerte* erstellt, aus der ein PDF für den Kunden erstellt werden kann. Kommt der Auftrag zustande, wird der Inhalt der *Offerte* in ein *Projekt* geklont. Auf Projekten geschieht die eigentliche Zeiterfassung, und es werden keine PDFs davon erzeugt. Schliesslich kann der Inhalt eines *Projekts* in eine *Rechnung* geklont werden, aus der wiederum ein PDF erzeugt werden kann.

* Service (service): Die Dienstleistungen, die verrechnet werden. Diese besitzen 1..n *Tarife*. 
  * Tarif (rate): Preis und eine *Einheit* eines *Service*, die je nach *Tarifgruppe* unterschiedlich sein können.
    * Einheit (rateUnitType): Einheit eines *Tarifs*, z.B. Stunden, Stückzahl
  * Tarifgruppe (rateGroup): z.B "Privatkunde" oder "Kanton". Damit können verschiedene Kunden anders verrechnet werden.
* Offerte (offer): Die Offerte für einen Auftrag, die gedruckt werden kann. Darauf werden u.A. Services erfasst.
  * Service (offerPosition): "Service" ist eine Fehlbennennung hier - es handelt sich um "Services, die der Offerte zugewiesen sind", bzw "Offertenposten"
  * Abzüge (offerDiscount)
* Projekt (project): Ein Projekt das ausgeführt wird. Darauf geschieht die Zeiterfassung.
  * Aktivität (activity): Die *Services* der Offerte heissen hier *Aktivitäten*. Auf *Aktivitäten* können *Zeiteinträge* (timeslices) gebucht werden.
  * Tätigkeitsbereich (projectCategory)
* Rechnung (invoice): Ein abgeschlossenes Projekt wird zu einer oder mehreren Rechnungen, die dem Kunden zugeschickt werden können.
  * Rechnungsposten (invoiceItem): Die *Aktivitäten* des *Projekts* sind hier als *Rechungsposten* aufgeführt und werden für den Schlusspreis zusammengezählt.
  * Abzüge (invoiceDiscount)
  * Kostenstellen (costGroup): Der Umsatz wird für die Buchhaltung auf diese Kostenstellen verteilt, um festzustellen, welcher Bereich wie viel Umsatz generiert.
