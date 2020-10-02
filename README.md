# Physik LK APP
> Eine App die alle Themen für den Physik LK vom GSG Wetter zusammen fassen soll

![stars][github-stars]
![issues][github-issues]
[![Codemagic build status][status-badge]][last-build]
![License][github-license]

:us:

This app is designed to help you prepare for the Abitur examination in NRW by summarising all relevant topics. The app loads all summaries of the topics from an api written by me especially for this purpose. You can also register and login and write notes, which are available from the web app as well as from the mobile version. It should be mentioned that all articles and notes support Markdown and LaTex and the app offers many possibilities for customization.

You can download the app from the Google Playstore: https://play.google.com/store/apps/details?id=de.thebotdev.physik_lp_app

Web App: http://srv2.thebotdev.de/web/physik

:de: 

Diese App soll einem helfen sich auf die Abiturprüfung in NRW vorbereiten zu können, indem sie alle Abiturreleavanten Themen zusammenfasst. Dabei lädt die App alle Zusammenfassungen der Themen aus einer von mir extra dafür geschriebenen Api. Zudem kann man in der App sich registrieren und anmelden und dann Notizen schreiben, welche sowohl aus der Web App als auch aus der Mobilen Variante erreichbar sind. Dabei sollte erwähnt werden, dass alle Artikel und Notizen Markdown und LaTex unterstützen und die App viele möglichkeiten der Anpassung gibt.

Die App gibt es im Google Playstore als Download: https://play.google.com/store/apps/details?id=de.thebotdev.physik_lp_app
Web App: http://srv2.thebotdev.de/web/physik

## API
Die Api zu der App kann [hier][link_api] gefunden werden.

## Artikel erstellen
Um zu erfahren, wie Artikel für die App erstellt werden, lies dir bitte die [Wiki][wiki] durch. Dort findest du alle Informationen zum erstellen eines Artikels und Beispiele für jeden Artikeltypen der unterstützt wird.

## Changelog
* 1.1.4
    * Added: Markdown Articel type
    * Added: Unit testing for content feature
    * Fixed: Code Cleanup
* 1.1.3
    * Added: Web version / checks
    * Added: CDot option (use \cdot instead of \times)
    * Fixed: Sub-Menu page title now displays the topics name
    * Changed: Android Target SDK updated to 29
* 1.1.2
    * Added: Intro Slider
    * Added: Dark Blue Theme
    * Changed: Light Theme update
    * Changes: Dark Theme -> Material Dark Theme
    * Fixed: Code fixes / cleanup
* 1.1.1
    * New Editor
    * Markdown support
* 1.1.0
    * Added: Notizen
    * Added: Login
    * Added: Offline support
    * Changed: Api interface changes implemented
* 1.0.0
    * Grundversion der App
## Markdown
Die App unterstützt die folgende Markdown syntax, diese kann in jedem Artikel und in allen Notizen verwendet werden:
| Aktion                          | Synatx                                              |
|---------------------------------|-----------------------------------------------------|
| Text **fettgedruckt** schreiben | `**text der fettgedruckt werden soll**`             |
| Text *kursiv* schreiben         | `*text der kursiv geschrieben werden soll*`         |
| Überschrift                     | `# Überschrift`                                     |
| `Text als code`                 | ``` `Text der als code dargetellt werden soll`  ``` |
| Unterstrich                     | ---                                                 |

## Meta

Falk Michaelis – [@BaseChip](https://twitter.com/BaseChip) – physik_app@falkmichaelis.eu

Veröffentlicht unter der GNU General Public License 3 Lizenz. Sieh ``LICENSE`` für mehr informationen.


[github-stars]: https://img.shields.io/github/stars/BaseChip/App-Physik
[github-issues]: https://img.shields.io/github/issues-raw/BaseChip/App-Physik
[github-license]: https://img.shields.io/github/license/BaseChip/App-Physik
[wiki]: https://github.com/BaseChip/App-Physik/wiki
[link_api]: https://github.com/BaseChip/Api-Physik
[status-badge]: https://api.codemagic.io/apps/5f37ba24dd1056311a5e949f/5f37ba24dd1056311a5e949e/status_badge.svg
[last-build]: https://codemagic.io/apps/5f37ba24dd1056311a5e949f/5f37ba24dd1056311a5e949e/latest_build