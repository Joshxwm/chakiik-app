// ignore: file_names

class Rescuer {
  final String idRescatista;
  final String nombre;
  final String apellido;
  final String edad;
  final String especialidad;
  final String nivelCertificacion;
  final String contacto;
  final String disponibilidad;
  final String ubicacionActual;
  final String equipoAsignado;

  Rescuer({
    required this.idRescatista,
    required this.nombre,
    required this.apellido,
    required this.edad,
    required this.especialidad,
    required this.nivelCertificacion,
    required this.contacto,
    required this.disponibilidad,
    required this.ubicacionActual,
    required this.equipoAsignado,
  });

  factory Rescuer.fromJson(Map<String, dynamic> json) {
    return Rescuer(
      idRescatista: json['id_rescatista'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      edad: json['edad'],
      especialidad: json['especialidad'],
      nivelCertificacion: json['nivel_certificacion'],
      contacto: json['contacto'],
      disponibilidad: json['disponibilidad'],
      ubicacionActual: json['ubicacion_actual'],
      equipoAsignado: json['equipo_asignado'],
    );
  }
}
