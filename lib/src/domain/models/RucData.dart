import 'package:equatable/equatable.dart';

class RucData extends Equatable {
  final bool esAgenteRetencion;
  final String condicion;
  final String departamento;
  final String direccion;
  final String distrito;
  final String estado;
  final String numeroDocumento;
  final String provincia;
  final String razonSocial;
  final String tipoDocumento;
  final String ubigeo;
  final String viaNombre;
  final String viaTipo;
  final String actividadEconomica; // Nueva propiedad
  final String tipoEmpresa; // Nueva propiedad

  RucData({
    this.esAgenteRetencion = false,
    this.condicion = 'No disponible',
    this.departamento = 'No disponible',
    this.direccion = 'No disponible',
    this.distrito = 'No disponible',
    this.estado = 'No disponible',
    this.numeroDocumento = 'No disponible',
    this.provincia = 'No disponible',
    this.razonSocial = 'No disponible',
    this.tipoDocumento = 'No disponible',
    this.ubigeo = 'No disponible',
    this.viaNombre = 'No disponible',
    this.viaTipo = 'No disponible',
    this.actividadEconomica = 'No disponible', // Agregar aquí
    this.tipoEmpresa = 'No disponible', // Agregar aquí
  });

  factory RucData.fromJson(Map<String, dynamic> json) {
    return RucData(
      esAgenteRetencion: json['EsAgenteRetencion'] as bool? ?? false,
      condicion: json['condicion'] as String? ?? 'No disponible',
      departamento: json['departamento'] as String? ?? 'No disponible',
      direccion: json['direccion'] as String? ?? 'No disponible',
      distrito: json['distrito'] as String? ?? 'No disponible',
      estado: json['estado'] as String? ?? 'No disponible',
      numeroDocumento: json['numeroDocumento'] as String? ?? 'No disponible',
      provincia: json['provincia'] as String? ?? 'No disponible',
      razonSocial: json['razonSocial'] as String? ?? 'No disponible',
      tipoDocumento: json['tipoDocumento'] as String? ?? 'No disponible',
      ubigeo: json['ubigeo'] as String? ?? 'No disponible',
      viaNombre: json['viaNombre'] as String? ?? 'No disponible',
      viaTipo: json['viaTipo'] as String? ?? 'No disponible',
      actividadEconomica: json['actividadEconomica'] as String? ?? 'No disponible', // Agregar aquí
      tipoEmpresa: json['tipoEmpresa'] as String? ?? 'No disponible', // Agregar aquí
    );
  }

  // Convert the instance to JSON (optional, in case you need to send it back to the backend)
  Map<String, dynamic> toJson() {
    return {
      'EsAgenteRetencion': esAgenteRetencion,
      'condicion': condicion,
      'departamento': departamento,
      'direccion': direccion,
      'distrito': distrito,
      'estado': estado,
      'numeroDocumento': numeroDocumento,
      'provincia': provincia,
      'razonSocial': razonSocial,
      'tipoDocumento': tipoDocumento,
      'ubigeo': ubigeo,
      'viaNombre': viaNombre,
      'viaTipo': viaTipo,
      'actividadEconomica': actividadEconomica,
      'tipoEmpresa': tipoEmpresa,
    };
  }

  @override
  List<Object?> get props => [
        esAgenteRetencion,
        condicion,
        departamento,
        direccion,
        distrito,
        estado,
        numeroDocumento,
        provincia,
        razonSocial,
        tipoDocumento,
        ubigeo,
        viaNombre,
        viaTipo,
        actividadEconomica, // Agregar aquí
        tipoEmpresa, // Agregar aquí
      ];
}
