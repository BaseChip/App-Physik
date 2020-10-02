/// Eine Klasse die einen Übergebenen String mit normalen Markdown symbolen
/// in einen String mit umgewandelten html elementen verwandelt, da TeXView
/// html unterstützt und man so Markdown in den Artikeln und den Notizen
/// verwenden kann
///
/// Unterstütztes Markdown:
///  - # Headline -> <h1> Headline </h1>
///  - ** bold text ** -> <b> bold text</b>
///  - *italic text* -> <em>italic text</em>
///  - `code` -> <code>code</code>
///  - --- -> <hr>
class MarkDownParser {
  /// [*] -> muss * enthalten
  /// . -> jeder Buchstabe / jedes Zeichen | Ausgenommen neue Zeile
  /// z{x, y} ->  Zeichen z min x mal, maximal y mal, wenn kein y
  /// angegeben ist y = unendlich
  /// {}? -> möglichst wenig
  /// (Sorgt dafür, dass möglichst wenige ausgewählt werden -> sonst wäre
  ///  **bold 1** **bold 2** das gleiche (match = **bold 1** **bold 2**) und
  ///  so sind es dann zwei verschiedene Matches (match1 = **bold 1**, match2=...))
  final RegExp boldRegex = RegExp(r"([*][*].{1,}?[*][*])+");

  /// [^z] = schließt das Zeichen z aus
  final RegExp italicRegex = RegExp(r"([*][^*].{1,}?[^*][*])+");
  final RegExp codeRegex = RegExp(r"([`].{1,}?[`])+");

  /// \S* es können null oder mehr Lehrzeichen dazwischen sein
  final RegExp h1Reges = RegExp(r"([#]\S*.{1,})+");

  /// Aufbau Bilder in MarkDown ![[bildname]]
  final RegExp imageRegex = RegExp(r"[!]['\[']['\['].{1,}?['\]']['\]']");

  String parseString(String string) {
    String stringWithHtmlMarkdown = string;
    for (var match in _allStringMatches(string, boldRegex)) {
      String after = match.replaceFirst("**", "<b>");
      after = after.replaceAll("**", "</b>");
      stringWithHtmlMarkdown =
          stringWithHtmlMarkdown.replaceFirst(match, after);
    }
    for (var match in _allStringMatches(string, italicRegex)) {
      String after = match.replaceFirst("*", "<em>");
      after = after.replaceAll("*", "</em>");
      stringWithHtmlMarkdown =
          stringWithHtmlMarkdown.replaceFirst(match, after);
    }
    for (var match in _allStringMatches(string, codeRegex)) {
      String after = match.replaceFirst("`", "<code>");
      after = after.replaceAll("`", "</code>");
      stringWithHtmlMarkdown =
          stringWithHtmlMarkdown.replaceFirst(match, after);
    }
    for (var match in _allStringMatches(string, h1Reges)) {
      String after = match.replaceFirst("#", "<h1>");
      after = after + "</h1>";
      stringWithHtmlMarkdown =
          stringWithHtmlMarkdown.replaceFirst(match, after);
    }
    for (var match in _allStringMatches(string, imageRegex)) {
      String dateiname = match.replaceFirst("![[", "").replaceFirst("]]", "");
      String after;
      String extras =
          "alt=\"Image from articel\" style=\"max-width: 100%; max-height: 100%;\"";
      if (dateiname.startsWith("http")) {
        after = "<img src=\"$dateiname\" $extras/>";
      } else {
        after =
            "<img src=\"http://srv2.thebotdev.de/img/physik/$dateiname\" $extras/>";
      }
      stringWithHtmlMarkdown =
          stringWithHtmlMarkdown.replaceFirst(match, after);
    }
    stringWithHtmlMarkdown = stringWithHtmlMarkdown.replaceAll("\n", "<br>");
    stringWithHtmlMarkdown = stringWithHtmlMarkdown.replaceAll("---", "<hr>");
    return stringWithHtmlMarkdown;
  }

  Iterable<String> _allStringMatches(String text, RegExp regExp) =>
      regExp.allMatches(text).map((m) => m.group(0));
}
