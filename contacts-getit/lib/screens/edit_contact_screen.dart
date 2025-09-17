import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:contacts_getit/getit/contacts_service.dart';
import 'package:contacts_getit/getit/model.dart';
import 'package:image_picker/image_picker.dart';

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
  final ContactService _service = GetIt.instance<ContactService>();
  Contact? _contact;
  
  @override
void initState() {
  super.initState();
  _contact = _service.getById(widget.contactId);
  if (_contact != null) {
  _nameCtrl.text = _contact!.name;
  _phoneCtrl.text = _contact!.phone;
  _emailCtrl.text = _contact!.email ?? '';
  if (_contact?.imagePath != null) {
      _imageFile = File(_contact!.imagePath.toString());
    }
  }
}


@override
  void dispose() {
  _nameCtrl.dispose();
  _phoneCtrl.dispose();
  _emailCtrl.dispose();
  super.dispose();
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

void _save() {
  if (_formKey.currentState!.validate() && _contact != null) {
  final updated = _contact!.copyWith(name: _nameCtrl.text.trim(), phone: _phoneCtrl.text.trim(), email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(), imagePath:_imageFile!.path.isEmpty ? null : _imageFile?.path );
  _service.updateContact(updated);
  Navigator.pop(context);
  }
}
  @override
  Widget build(BuildContext context) {
    if (_contact == null) {
return Scaffold(appBar: AppBar(title: const Text('Edit')), body: const Center(child: Text('Contact not found')));
}


      return Scaffold(
        appBar: AppBar(title: const Text('Edit Contact')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          
            child: Column(
              children: [
                   CircleAvatar(
               radius: 64,
              backgroundColor: Colors.green,
          child:  CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60,
              backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null ? const Icon(Icons.person, size: 60) : null,
            ),
             ),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Change Photo'),
            ),
            SizedBox(height: 20),
                
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                       validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                       SizedBox(height: 20),
                      TextFormField(
                        controller: _phoneCtrl,
                       decoration: InputDecoration(
                        labelText: 'Phone Number',
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
                         validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                     SizedBox(height: 20),
                      TextFormField(controller: _emailCtrl,
                       decoration:  InputDecoration(
                        labelText: 'Email',
                        contentPadding: const EdgeInsets.all(20),
                                      enabledBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: BorderSide(color:  Colors.green, width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: BorderSide(color: Colors.red, width: 2.0), // Error state color
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(color: Colors.red, width: 2.0), 
                                        ),
                        ), 
                       keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                        onPressed: _save, 
                        child: const Text('Save')),
                      ],
                  ),
                ),
              ],
            ),
          ),
      );
  }
}