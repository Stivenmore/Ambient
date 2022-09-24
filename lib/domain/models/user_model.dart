class UserModel {
  final String nombre;
  final String email;
  final String? telefono;
  final List? reciclaje;

  UserModel(
      {required this.nombre,
      required this.email,
      this.telefono,
      this.reciclaje});

  factory UserModel.fromFirebase(Map<String, dynamic> map) {
    return UserModel(
        nombre: map["name"] as String? ?? "",
        email: map["email"] as String? ?? "",
        telefono: "",
        reciclaje: []);
  }
}
