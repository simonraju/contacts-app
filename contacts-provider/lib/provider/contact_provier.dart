import 'package:contacts_provider/provider/model.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
final List<Contact> _contacts = [];

 List<Contact> get contacts => List.unmodifiable(_contacts);

 String _generateId() =>
      DateTime.now().millisecondsSinceEpoch.toString() +
      Random().nextInt(999).toString();

  void addContact(String name, String phone,   {String? email, String? imagePath}) {
    final contact = Contact(id: _generateId(), name: name, phone: phone, email: email, imagePath: imagePath);
    _contacts.add(contact);
     notifyListeners();
    
  }
void updateContact(Contact updated) {
    final index = _contacts.indexWhere((contact) => contact.id == updated.id);
    if (index != -1) {
      _contacts[index] = updated;
      notifyListeners();
    }
  }

  void deleteContact(String id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }

  Contact? getById(String id) {
    try {
      return _contacts.firstWhere((contact) => contact.id == id);
    } catch (_) {
      return null;
    }
  }
}