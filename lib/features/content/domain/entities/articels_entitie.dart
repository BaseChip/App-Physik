import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Es gibt ein Entitie für die normalen Artikel, eins für die Artikel Elemente in
/// einer Liste, da wir fürs anzeigen der Artikel im Menü weniger Informationen
/// brauchen und mehr Informationen nur geladen werden, wenn der Artikel aufgerufen
/// wird
class Articels extends Equatable{
  final int id;
  final String titel;


  Articels({
    @required this.id,
    @required this.titel,
    });

  @override
  List<Object> get props => [id, titel];
}