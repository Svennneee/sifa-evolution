# Sifa Evolution – Stuttgart Edition

Web-App für den Mittwochabend der Sifa-Gruppe am **25.11.2026** in Stuttgart und Bad Cannstatt:
Eventplaner, Live-Dashboard und Evolutionssystem in einem.

## Dateien

| Datei | Zweck |
|---|---|
| `index.html` | Die komplette App (HTML, CSS, JavaScript) |
| `config.js` | Hier kommen die Supabase-Zugangsdaten rein |
| `supabase-setup.sql` | Legt Tabelle, Zugriffsregeln und Live-Sync in Supabase an |
| `README.md` | Diese Anleitung |

Ohne Eintrag in `config.js` läuft die App im **Demo-Modus**: Alles funktioniert, die Daten bleiben aber auf einem Gerät
(mehrere Browser-Tabs synchronisieren sich trotzdem live). Für die Gruppe braucht ihr Supabase – das dauert etwa 10 Minuten.

---

## In 10 Minuten online

### 1. Supabase-Projekt anlegen (kostenlos)
1. Auf <https://supabase.com> anmelden → **New project**.
2. Name z. B. `sifa-evolution`, Region **Frankfurt (eu-central-1)**, Datenbank-Passwort vergeben → **Create**.
3. Warten, bis das Projekt bereit ist (1–2 Minuten).

### 2. Datenbank einrichten
1. Links **SQL Editor** → **New query**.
2. Den kompletten Inhalt von `supabase-setup.sql` einfügen → **Run**.
3. Es sollte „Success. No rows returned“ erscheinen.

### 3. Zugangsdaten eintragen
1. Links **Project Settings → API** (bzw. „Data API“ / „API Keys“).
2. **Project URL** kopieren → in `config.js` bei `supabaseUrl` einfügen.
3. Den **anon / publishable key** kopieren → bei `supabaseAnonKey` einfügen.
   ⚠️ Niemals den `service_role`- bzw. Secret-Key verwenden – der gehört nicht in eine Webseite.

```js
window.SIFA_CONFIG = {
  supabaseUrl: "https://abcdefgh.supabase.co",
  supabaseAnonKey: "eyJhbGciOi...",
  room: "sifa-stuttgart-2026-11-25"
};
```

### 4. Veröffentlichen (eine Variante wählen)
- **Netlify Drop** (am einfachsten): <https://app.netlify.com/drop> öffnen, kostenloses Konto anlegen, den ganzen Ordner
  ins Fenster ziehen. Ihr bekommt sofort einen Link wie `https://irgendwas.netlify.app`.
- **GitHub Pages**: Repository anlegen, die Dateien hochladen, unter *Settings → Pages* „Deploy from branch“ wählen.
- **Vercel**: <https://vercel.com/new> → Ordner importieren.

### 5. Link in die Gruppe schicken
Link in WhatsApp/Signal posten. Tipp fürs Handy: „Zum Home-Bildschirm hinzufügen“ – dann startet die Seite wie eine App.

### Lokal testen
```bash
cd sifa-evolution
python3 -m http.server 8000
# dann http://localhost:8000 öffnen
```

---

## So wird’s benutzt

**Anmelden:** Namen eingeben – fertig. Kein Passwort. Wer das Gerät wechselt, wählt einfach seinen Namen aus der Liste.

**Basis**
- Countdown bis 16:00 Uhr, danach „Live seit …“.
- Eigener Charakter mit Level, Power-Level und Fortschrittsbalken.
- Getränke-Buttons (Bier, Wein, Ouzo/Shot, Cocktail, Alkoholfrei, Softdrink, Wasser) – alles zählt gleich, ohne Trinkzwang. „Letztes rückgängig“ korrigiert Vertipper.
- Status: Dabei / Vielleicht / Nicht dabei, plus Programmpunkte (Essen, Brauhaus, Wolfsrudel).
- „Ich verabschiede mich für heute“ graut den Charakter aus – er bleibt aber in allen Übersichten sichtbar. „Ich bin wieder da“ macht das rückgängig.
- Ablauf mit den aktuell führenden Uhrzeiten und dem Favoriten-Restaurant, darunter der Live-Feed.

**Evolution** (nach Anzahl erfasster Getränke)

| Level | Titel | ab |
|---|---|---|
| 1 | Normalzustand | 0 |
| 2 | Super-Sifa | 1 |
| 3 | Super-Sifa II | 3 |
| 4 | Super-Sifa III | 5 |
| 5 | Sifa-Gott | 7 |
| 6 | Sifa-Blau | 9 |
| 7 | Ultra-Instinkt | 12 |

Jede Stufe hat eigenes Design (Helmfarbe, Augen, Aura, Blitze, Funken). Beim eigenen Level-up gibt es eine Vollbild-Transformation mit Konfetti, bei anderen eine Meldung. Ein neuer Spitzenreiter löst ebenfalls Konfetti aus.
Die Schwellen lassen sich in `index.html` im Block `LEVELS` (Feld `min`) ändern.

**Ranking:** Power-Pyramide – ganz oben, wer am meisten eingetragen hat. Gleichstand = gleiche Stufe. Darunter die Truppe nach Status und alle Evolutionsstufen.

**Plan:** Wer kommt mit · Restaurant-Abstimmung (8 griechische Restaurants, die mittwochs geöffnet haben, plus eigene Vorschläge) · je Programmpunkt Teilnehmende, Uhrzeit-Abstimmung und Kommentare mit Antworten · alternative Programmpunkte mit Upvotes. Alle Stimmen lassen sich ändern (nochmal tippen = zurückziehen).

**Karte:** Leaflet mit OpenStreetMap-Daten. Die Route verbindet Start → Favoriten-Restaurant → Sophie’s Brauhaus → Wolfsrudel. Markierungen antippen für Infos und Google-Maps-Navigation (ÖPNV). Startpunkt (Hörsaal) und **Wolfsrudel** sind noch ohne Position: „Ort setzen“ tippen, dann auf die Karte tippen – gilt sofort für alle.

**Stats:** Kennzahlen, Getränke nach Sorte, Level-Verteilung, Getränke pro Stunde und Auszeichnungen (Spitzenreiter, Hydrations-Held, Ouzo-Orakel, Frühstarter, Durchhalte-Legende).

Zusätzlich tauchen alle paar Minuten humorvolle Sifa-Durchsagen auf.

---

## Technik & Sicherheit

- Reines HTML/CSS/JS, keine Build-Tools. Bibliotheken per CDN: Leaflet 1.9.4, supabase-js 2.49.1, Google Fonts (Bangers, Rubik). Kartenkacheln: CARTO Dark auf OpenStreetMap-Basis.
- Alle Daten liegen in **einer** Tabelle `sifa_items` (room, col, id, data als JSON). Jedes Getränk, jede Stimme und jeder Kommentar ist eine eigene Zeile – dadurch gibt es keine Zählkonflikte, wenn mehrere gleichzeitig tippen.
- Live-Sync über Supabase Realtime; zusätzlich wird beim Zurückkehren in den Tab und alle 90 Sekunden neu geladen.
- Row Level Security erlaubt nur Zugriffe auf den Raum `sifa-stuttgart-2026-11-25`; Feldgrößen sind begrenzt; alle Nutzertexte werden vor der Anzeige maskiert (kein HTML-Einschleusen).
- **Ehrlicher Hinweis:** Es gibt bewusst keine Passwörter. Wer den Link und den (öffentlichen) anon-Key kennt, kann theoretisch auch im Namen anderer eintragen. Für einen Abend unter Kolleg*innen ist das okay – teilt den Link nur in der Gruppe und löscht die Daten danach (SQL steht am Ende von `supabase-setup.sql`).
- Datensparsam: gespeichert werden nur Vorname/Spitzname, Status, Stimmen, Kommentare und Getränke-Einträge.

## Anpassen

- **Restaurants:** In `index.html` die Liste `BASE_VENUES` bearbeiten (Name, Adresse, Öffnungszeiten, Koordinaten).
- **Uhrzeit-Optionen:** Liste `STAGES` (`times`, `def`).
- **Anderes Datum / Raum:** `EVENT_START` in `index.html`, `room` in `config.js` und die Raum-Namen in `supabase-setup.sql` anpassen.

Öffnungszeiten stammen aus Google-Daten (Stand November 2026) – bitte vor der Reservierung kurz prüfen. Für die Gruppe unbedingt reservieren, v. a. Meze Meze, CAVOS und Sophie’s Brauhaus.

Viel Spaß – und denkt an die Öffis. 🦺
