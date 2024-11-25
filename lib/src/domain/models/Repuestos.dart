import 'dart:convert';

// Funciones para parsear y serializar los datos de Repuesto
List<Repuesto> repuestosFromJson(String str) =>
    List<Repuesto>.from(json.decode(str).map((x) => Repuesto.fromJson(x)));

String repuestosToJson(List<Repuesto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Repuesto {
  int idRepuestos;
  String nombre;
  String descripcion;
  double precio;
  String disponibilidad;
  double voltaje;
  String imagen;

  Repuesto({
    required this.idRepuestos,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.disponibilidad,
    required this.voltaje,
    required this.imagen,
  });

  // Método para convertir JSON en un objeto Repuesto
  factory Repuesto.fromJson(Map<String, dynamic> json) => Repuesto(
        idRepuestos: json["id_repuestos"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: double.parse(json["precio"]
            .toString()), // Usar double.parse para convertir el precio a double
        disponibilidad: json["disponibilidad"],
        voltaje: double.parse(json["voltaje"]
            .toString()), // Usar double.parse para convertir el voltaje a double
        imagen: json["imagen"],
      );

  // Método para convertir un objeto Repuesto a JSON
  Map<String, dynamic> toJson() => {
        "id_repuestos": idRepuestos,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "disponibilidad": disponibilidad,
        "voltaje": voltaje,
        "imagen": imagen,
      };

  // Método para convertir el objeto Repuesto a un Map
  Map<String, dynamic> toMap() =>
      toJson(); // Reutiliza el método toJson para convertir a Map
}
