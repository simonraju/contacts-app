import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contacts_provider/provider/contact_provier.dart';
import 'package:contacts_provider/provider/model.dart';
import 'package:contacts_provider/screens/add_contacts_screen.dart';
import 'package:contacts_provider/screens/view_contacts_screen.dart';
import 'package:contacts_provider/screens/edit_contact_screen.dart';

class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});

  
  @override
  State<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {


void _confirmDelete(BuildContext context, Contact contact) async {
    final provider = Provider.of<ContactProvider>(context, listen: false); 

    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete contact?'),
        content: Text('Delete ${contact.name}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );

    if (yes == true) provider.deleteContact(contact.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts List"),
        centerTitle: true,
      ),

      body: Consumer<ContactProvider>(
        builder: (context, provider, _) {
          final contacts = provider.contacts;
          if (contacts.isEmpty) {
            return const Center(child: Text("No contacts yet"));
          }
          return ListView.builder(
             itemCount: contacts.length,
            itemBuilder: (context, index){
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
                color:  const Color.fromARGB(255, 240, 153, 255),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.edit, color: Colors.white),
              ),


              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  // Edit
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditContactScreen(contactId: contact.id,)),
                  );
                  
                  return false;
                } else if (direction == DismissDirection.startToEnd) {
                     _confirmDelete(context,contact);
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Contact ${contact.name} is Deleted')),
                  );
                 

                }
                return false;
              },
              child: Card(
                color: Colors.black,
                child: ListTile(
                  leading: contact.imagePath != null
                      ? CircleAvatar(
                         radius: 30,
                        backgroundColor: Colors.purpleAccent,
                        child: CircleAvatar(
                          backgroundImage: FileImage(File(contact.imagePath!)),
                          radius: 25,
                          )
                          )
                          : const CircleAvatar(
                         radius: 30,
                        backgroundColor: Colors.purpleAccent,

                        child: CircleAvatar(
                         backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          radius: 25,
                          child: Icon(Icons.person, color: Color.fromARGB(255, 185, 185, 185),),
                        )
                        ),
                title: Text(contact.name),
                  subtitle: Text(contact.phone),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ViewContactsScreen(contactId: contact.id,)),
                ),
                ),
              ),

                );
            }
          );
        }
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
  

}