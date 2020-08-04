import 'dart:developer';

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
  final RegExp bold_regex = RegExp(r"([*][*].{1,}?[*][*])+");

  /// [^z] = schließt das Zeichen z aus
  final RegExp italic_regex = RegExp(r"([*][^*].{1,}?[^*][*])+");
  final RegExp code_regex = RegExp(r"([`].{1,}?[`])+");

  /// \S* es können null oder mehr Lehrzeichen dazwischen sein
  final RegExp h1_reges = RegExp(r"([#]\S*.{1,})+");

  String parseString(String string) {
    String string_with_html_markdown = string;
    for (var match in _allStringMatches(string, bold_regex)) {
      String after = match.replaceFirst("**", "<b>");
      after = after.replaceAll("**", "</b>");
      string_with_html_markdown =
          string_with_html_markdown.replaceFirst(match, after);
    }
    for (var match in _allStringMatches(string, italic_regex)) {
      String after = match.replaceFirst("*", "<em>");
      after = after.replaceAll("*", "</em>");
      string_with_html_markdown =
          string_with_html_markdown.replaceFirst(match, after);
    }
    for (var match in _allStringMatches(string, code_regex)) {
      String after = match.replaceFirst("`", "<code>");
      after = after.replaceAll("`", "</code>");
      string_with_html_markdown =
          string_with_html_markdown.replaceFirst(match, after);
    }
    for (var match in _allStringMatches(string, h1_reges)) {
      String after = match.replaceFirst("#", "<h1>");
      after = after + "</h1>";
      string_with_html_markdown =
          string_with_html_markdown.replaceFirst(match, after);
    }
    string_with_html_markdown =
        string_with_html_markdown.replaceAll("\n", "<br>");
    string_with_html_markdown =
        string_with_html_markdown.replaceAll("---", "<hr>");
    return string_with_html_markdown;
  }

  Iterable<String> _allStringMatches(String text, RegExp regExp) =>
      regExp.allMatches(text).map((m) => m.group(0));
}
