import 'dart:convert';

// Funciones para parsear y serializar los datos de Maquinaria
List<Maquinaria> maquinariaFromJson(String str) =>
    List<Maquinaria>.from(json.decode(str).map((x) => Maquinaria.fromJson(x)));

String maquinariaToJson(List<Maquinaria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Maquinaria {
  int idMaquinaria;
  String nombre;
  String tipo;
  String img;
  double precioHora;
  double precioDia;
  String descripcion;
  String estado;

  Maquinaria({
    required this.idMaquinaria,
    required this.nombre,
    required this.tipo,
    required this.img,
    required this.precioHora,
    required this.precioDia,
    required this.descripcion,
    required this.estado,
  });

  // Método para convertir JSON en un objeto Maquinaria
  factory Maquinaria.fromJson(Map<String, dynamic> json) => Maquinaria(
        idMaquinaria: json["id_maquinaria"],
        nombre: json["nombre"],
        tipo: json["tipo"],
        img: json["img"],
        precioHora: double.parse(json["precio_hora"].toString()),
        precioDia: double.parse(json["precio_dia"].toString()),
        descripcion: json["descripcion"],
        estado: json["estado"],
      );

  // Método para convertir un objeto Maquinaria a JSON
  Map<String, dynamic> toJson() => {
        "id_maquinaria": idMaquinaria,
        "nombre": nombre,
        "tipo": tipo,
        "img": img,
        "precio_hora": precioHora,
        "precio_dia": precioDia,
        "descripcion": descripcion,
        "estado": estado,
      };

  // Método para convertir el objeto Maquinaria a un Map
  Map<String, dynamic> toMap() => toJson(); // Reutiliza el método toJson para convertir a Map
}
