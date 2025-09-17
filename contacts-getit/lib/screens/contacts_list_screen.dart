import 'dart:io';

import 'package:contacts_getit/screens/edit_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:contacts_getit/getit/contacts_service.dart';
import 'package:contacts_getit/getit/model.dart';
import 'package:contacts_getit/screens/view_contacts_screen.dart';
import 'package:contacts_getit/screens/add_contacts_screen.dart';


class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});

  @override
  State<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {


  final ContactService _service = GetIt.instance<ContactService>();


@override
void initState() {
super.initState();
// example seed data (optional)

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
    final contacts = _service.contacts;
    return Scaffold(
    appBar: AppBar(title: const Text('Contacts List screen'),
     centerTitle: true,
     ),
    body: contacts.isEmpty ? const Center(child: Text('No contacts yet'))
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
        final contact = contacts[index];
          return Dismissible(
            key: Key(contact.toString()),
             direction: DismissDirection.horizontal, 
              background: Container(
                color: const Color.fromARGB(255, 255, 44, 29),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              secondaryBackground: Container(
                color:  Colors.lightGreenAccent,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.edit, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  // Edit
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditContactScreen(contactId: contact.id)),
                  );
                  
                  return false;
                } else if (direction == DismissDirection.startToEnd) {
                    _confirmDelete(context, contact);
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Contact ${contact.name} is Deleted')),
                  );
                  // Delete

                }
                return false;
              },
              //  onDismissed: (direction) {
              //   if (direction == DismissDirection.startToEnd) {
                  
              //   _confirmDelete(context, contact);
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text('Contact ${contact.name} is Deleted')),
              //     );
              //   }
              // },
            child: Card(
              child: ListTile(
                  leading: contact.imagePath != null
                      ? CircleAvatar(
                         radius: 30,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          backgroundImage: FileImage(File(contact.imagePath!)),
                          radius: 25,
                          )
                          )
                          : const CircleAvatar(
                         radius: 30,
                        backgroundColor: Colors.green,

                        child: CircleAvatar(
                         backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          radius: 25,
                          child: Icon(Icons.person),
                        )
                        ),
                title: Text(contact.name),
                  subtitle: Text(contact.phone),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ViewContactsScreen(contactId: contact.id )),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddContactsScreen()),
      ),
      ),
      );
      }

      void _confirmDelete(BuildContext ctx, Contact c) async {
        final yes = await showDialog<bool>(
        context: ctx,
        builder: (ctx) => AlertDialog(
          title: const Text('Delete contact?'),
          content: Text('Delete ${c.name}?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
              TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
            ],
      ),
      );
      if (yes == true) {
      _service.deleteContact(c.id);
      }
}
}
    
  
