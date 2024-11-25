class Usuario {
  final int? id;
  String nombres;
  String apellido;
  String numeroTelefonico;
  String correo;
  String? password; // Cambiado de 'contraseña' a 'password'

  Usuario({
    this.id,
    required this.nombres,
    required this.apellido,
    required this.numeroTelefonico,
    required this.correo,
    this.password,
  });

  // Constructor para crear un objeto Usuario a partir de un JSON
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"], // 'id' puede ser null
    nombres: json["nombres"] ?? '',  // Aseguramos que si 'nombres' es null, sea una cadena vacía
    apellido: json["apellido"] ?? '',  // Lo mismo para 'apellido'
    numeroTelefonico: json["numero_telefonico"] ?? '',
    correo: json["correo"] ?? '',
    password: json["password"], // Esto puede ser null
  );

  // Método para convertir un objeto Usuario a JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "nombres": nombres,
    "apellido": apellido,
    "numero_telefonico": numeroTelefonico,
    "correo": correo,
    "password": password,  // Puede ser null
  };
}
