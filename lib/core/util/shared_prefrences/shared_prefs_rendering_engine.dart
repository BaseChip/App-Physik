import 'package:flutter/cupertino.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRenderingEngine {
  // default, da sie inline equations zulässt und Katex nicht
  final String _defaultEngine = "MathJax";
  final SharedPreferences prefs;
  SharedPrefsRenderingEngine({@required this.prefs});

  /// gibt die aktuelle Rendering Engine zurück, falls keine gesetzt ist wird 'MathJax' zurück gegegben
  String get renderingEngine {
    return prefs.getString("rendering_engine") ?? _defaultEngine;
  }

  TeXViewRenderingEngine get renderingEngineAsTeXEngine {
    String _engine = prefs.getString("rendering_engine") ?? _defaultEngine;
    switch (_engine) {
      case "Katex":
        {
          return TeXViewRenderingEngine.katex();
        }
        break;
      case "MathJax":
        {
          return TeXViewRenderingEngine.mathjax();
        }
      default:
        {
          // Auch wenn dieser Part niemals eintreten kann, ist er vorsichtshalber da
          return TeXViewRenderingEngine.mathjax();
        }
    }
  }

  /// Speichert die übergebene RenderingEngine (Katex / Mathjax) als neue Rendering Engine
  ///
  /// Katex = am schnellsten
  /// MathJax = etwas bessere Qualität, dafür etwas langsamer, zudem unterstützt die MathJax engine inzwischen inline equtations,
  /// weshalb diese standartmäßig ausgewählt ist
  set renderingEngine(String engine) {
    prefs.setString("rendering_engine", engine);
  }
}
