class Contact {
String id;
String name;
String phone;
String? email;
String? imagePath;


Contact({
  required this.id,
 required this.name,
  required this.phone,
  this.email,
  this.imagePath
  }
  );


Contact copyWith({String? id, String? name, String? phone, String? email, String? imagePath}) {
return Contact(
  id: id ?? this.id,
  name: name ?? this.name,
  phone: phone ?? this.phone,
  email: email ?? this.email,
  imagePath: imagePath ?? this.imagePath
);
}
}