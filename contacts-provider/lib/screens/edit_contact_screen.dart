import 'dart:io';

import 'package:flutter/material.dart';
import 'package:contacts_provider/provider/contact_provier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class EditContactScreen extends StatefulWidget {
  final String contactId;
  const EditContactScreen({super.key, required this.contactId});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  File? _imageFile;

  @override
  void initState(){
    super.initState();
    final contact = Provider.of<ContactProvider>(context, listen: false).getById(widget.contactId);

    if(contact != null){
        _nameCtrl.text = contact.name;
        _phoneCtrl.text = contact.phone;
        _emailCtrl.text = contact.email ?? '';
       if (contact.imagePath != null) {
      _imageFile = File(contact.imagePath.toString());
    }
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _save(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    final contact = provider.getById(widget.contactId);
    if (_formKey.currentState!.validate() && contact != null) {
      final updated = contact.copyWith(
        name: _nameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        imagePath:_imageFile?.path ?? _imageFile?.path
      );
      provider.updateContact(updated);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
               CircleAvatar(
               radius: 64,
              backgroundColor: Colors.purpleAccent,
             child: CircleAvatar( radius: 60,
                backgroundColor: Colors.white,
              backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null ? Icon(Icons.person, size: 60, color: Colors.grey,) : null,
            ),
            ),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        foregroundColor: Colors.white,
                        
                      ),
                 onPressed: pickImage,
                 child: Text(_imageFile == null ?'Add Photo' : 'Change Photo'),
               ),

            SizedBox(height: 30),

              TextFormField(controller: _nameCtrl,
               decoration: InputDecoration(
                labelText: 'Name',
                 contentPadding: const EdgeInsets.all(20),
                                      enabledBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                        borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color:  Colors.green, width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color: Colors.red, width: 2.0), // Error state color
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color: Colors.red, width: 2.0), 
                                        ),
                ), 
                validator: (v) => v!.trim().isEmpty ? 'Required' : null
                ),

                SizedBox(height: 30),

              TextFormField(
                controller: _phoneCtrl, 
                decoration:  InputDecoration(
                  labelText: 'Phone',
                   contentPadding: const EdgeInsets.all(20),
                                      enabledBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                        borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color:  Colors.green, width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color: Colors.red, width: 2.0), // Error state color
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color: Colors.red, width: 2.0), 
                                        ),
                  ), 
                  keyboardType: TextInputType.phone, 
                  validator: (v) => v!.trim().isEmpty ? 'Required' : null
                  ),

                  SizedBox(height: 30),

              TextFormField(controller: _emailCtrl, 
              decoration: InputDecoration(
                labelText: 'Email',
                 contentPadding: const EdgeInsets.all(20),
                                      enabledBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                        borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color:  Colors.green, width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color: Colors.red, width: 2.0), // Error state color
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color: Colors.red, width: 2.0), 
                                        ),
                ), 
                keyboardType: TextInputType.emailAddress
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purpleAccent,
                                    foregroundColor: Colors.white,
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                onPressed: () => _save(context), 
                child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}