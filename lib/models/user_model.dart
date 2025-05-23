class Role {
  final String id;
  final List<String> names;

  Role({required this.id, required this.names});

  factory Role.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    final String roleId = json['id']?.toString() ?? '';
    List<String> namesList = [];

    if (json['name'] != null) {
      if (json['name'] is List) {
        namesList = (json['name'] as List).map((r) => r.toString()).toList();
      } else if (json['name'] is String) {
        namesList = [json['name']];
      }
    }

    return Role(
      id: roleId,
      names: namesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': names,
    };
  }
}

class User {
  final String? id;
  final String email;
  final String firstName;
  final String lastName;
  final Role role;

  User({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    json ??= {};

    return User(
      id: json['id']?.toString(),
      email: json['email']?.toString() ?? '',
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      role: Role.fromJson(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'role': role.toJson(),
    };
  }
}