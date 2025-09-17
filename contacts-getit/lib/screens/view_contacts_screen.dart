import 'dart:io';

import 'package:contacts_getit/screens/edit_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:contacts_getit/getit/contacts_service.dart';

class ViewContactsScreen extends StatefulWidget {
  final String contactId;

  const ViewContactsScreen({super.key, required this.contactId});

  

  @override
  State<ViewContactsScreen> createState() => _ViewContactsScreenState();
}

class _ViewContactsScreenState extends State<ViewContactsScreen> {

  final ContactService _service = GetIt.instance<ContactService>();

  @override
    void initState() {
    super.initState();
    _service.addListener(_onChange);
    }


@override
  void dispose() {
  _service.removeListener(_onChange);
  super.dispose();
  }


void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final contact = _service.getById(widget.contactId);
  if (contact == null) {
  return Scaffold(appBar: AppBar(title: const Text('Contact')), body: const Center(child: Text('Contact not found')));
  }
      return Scaffold(
      appBar: AppBar(
      title: Text(contact.name),
      ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         CircleAvatar(
               radius: 64,
              backgroundColor: Color.fromARGB(255, 33, 114, 180),

            child: CircleAvatar( 
                radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: contact.imagePath != null
                  ? FileImage(File(contact.imagePath!))
                  : null,
              child: contact.imagePath == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),
            ),
             const SizedBox(height: 20),
             Text( contact.name, style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
           
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(contact.phone, style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 20),
                        ],
                      ),
                       Row(
              children: [
                Expanded(child: 
                Divider(
              height: 20, 
              thickness: 0.8, 
              color: Colors.grey, 
              indent: 0, // Left padding
              endIndent:10,
              
                ))
              ],
            ),
                      const SizedBox(height:40),
            if (contact.email != null && contact.email!.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.email, color:  Colors.green),
                  const SizedBox(width: 8),
                  Text(contact.email!, style: const TextStyle(fontSize: 18)),
                ],
              ),
               if (contact.email != null && contact.email!.isNotEmpty)
                Row(
              children: [
                Expanded(child: 
                Divider(
              height: 20, 
              thickness: 0.8, 
              color: Colors.grey, 
              indent: 0,
              endIndent: 10,
              
                ))
              ],
                )
                  ],
              ),
            ),
      );
  }
}