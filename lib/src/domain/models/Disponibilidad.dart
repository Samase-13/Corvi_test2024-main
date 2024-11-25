import 'dart:convert';
import 'package:intl/intl.dart';

// Funciones para parsear y serializar la lista de Disponibilidad
List<Disponibilidad> disponibilidadFromJson(String str) =>
    List<Disponibilidad>.from(json.decode(str).map((x) => Disponibilidad.fromJson(x)));

String disponibilidadToJson(List<Disponibilidad> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Disponibilidad {
  int idMaquinaria;
  DateTime fechaInicio;
  DateTime fechaFin;

  Disponibilidad({
    required this.idMaquinaria,
    required this.fechaInicio,
    required this.fechaFin,
  });

  // Método para convertir JSON en un objeto Disponibilidad
  factory Disponibilidad.fromJson(Map<String, dynamic> json) => Disponibilidad(
        idMaquinaria: json["id_maquinaria"],
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        fechaFin: DateTime.parse(json["fecha_fin"]),
      );

  // Método para convertir un objeto Disponibilidad a JSON
  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return {
      'id_maquinaria': idMaquinaria,
      'fecha_inicio': formatter.format(fechaInicio),
      'fecha_fin': formatter.format(fechaFin),
    };
  }

  // Método para convertir el objeto Disponibilidad a un Map
  Map<String, dynamic> toMap() => toJson();
}
