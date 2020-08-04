import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Articel extends Equatable{
  final int id;
  final int thema_id;
  final String autor;
  final String titel;
  final String typ;
  final String content;

  Articel({
    @required this.id,
    @required this.thema_id,
    @required this.autor,
    @required this.titel,
    @required this.typ,
    @required this.content
    });

  @override
  List<Object> get props => [id, thema_id, autor, titel, typ, content];
}