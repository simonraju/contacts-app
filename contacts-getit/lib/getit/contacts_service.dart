import 'package:flutter/foundation.dart';
import './model.dart';
import 'dart:math';


class ContactService extends ChangeNotifier {
final List<Contact> _contacts = [];


List<Contact> get contacts => List.unmodifiable(_contacts);


// Simple id generator
String _generateId() => DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(999).toString();


void addContact(String name, String phone, String? email, String? imagePath,) {
final c = Contact(id: _generateId(), name: name, phone: phone, email: email, imagePath: imagePath);
_contacts.add(c);
notifyListeners();
}


void updateContact(Contact updated) {
final idx = _contacts.indexWhere((c) => c.id == updated.id);
if (idx != -1) {
_contacts[idx] = updated;
notifyListeners();
}
}


void deleteContact(String id) {
_contacts.removeWhere((c) => c.id == id);
notifyListeners();
}


Contact? getById(String id) => _contacts.firstWhere((c) => c.id == id, orElse: () => null as Contact);
}