import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contacts_provider/provider/contact_provier.dart';


class ViewContactsScreen extends StatefulWidget {
   final String contactId;
  const ViewContactsScreen({super.key, required this.contactId});

  @override
  State<ViewContactsScreen> createState() => _ViewContactsScreenState();
}

class _ViewContactsScreenState extends State<ViewContactsScreen> {
  
  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<ContactProvider>(context, listen: false).getById(widget.contactId);
    if (contact == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Contact')),
        body: const Center(child: Text('Contact not found')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
               radius: 64,
              backgroundColor: Colors.purpleAccent,

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
             const SizedBox(height: 20),
             Text( contact.name, style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),

           const SizedBox(height: 40),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.purpleAccent),
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
                  const Icon(Icons.email, color:  Colors.purpleAccent),
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
          ]
        ),
      ),
    );
    
  }
}