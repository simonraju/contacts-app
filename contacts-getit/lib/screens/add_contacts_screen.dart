import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:contacts_getit/getit/contacts_service.dart';
import 'package:image_picker/image_picker.dart';

class AddContactsScreen extends StatefulWidget {
  const AddContactsScreen({super.key});

  @override
  State<AddContactsScreen> createState() => _AddContactsScreenState();
}

class _AddContactsScreenState extends State<AddContactsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  File? _imageFile;
  final ContactService _service = GetIt.instance<ContactService>();

    Future<void> pickImage() async{
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState((){
      _imageFile = File(pickedFile.path);

      });
    }
  }

  @override
    void dispose() {
      _nameCtrl.dispose();
      _phoneCtrl.dispose();
      _emailCtrl.dispose();
      super.dispose();
    }


void _save() {
  if (_formKey.currentState!.validate()) {
  _service.addContact(_nameCtrl.text.trim(), _phoneCtrl.text.trim(), _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(), _imageFile?.path);
  Navigator.pop(context);
}
}
    @override
  Widget build(BuildContext context) {
     return Scaffold(
          appBar: AppBar(title: const Text('Add Contact')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                   CircleAvatar(
               radius: 64,
              backgroundColor: Colors.green,
             child: CircleAvatar( radius: 60,
                backgroundColor: Colors.white,
              backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null ? Icon(Icons.person, size: 60, color: Colors.grey,) : null,
            ),
            ),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        
                      ),
                 onPressed: pickImage,
                 child: Text(_imageFile == null ?'Add Photo' : 'Change Photo'),
               ),

            SizedBox(height: 30),

                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUnfocus, 
                        child: Column(
                            children: [
                              TextFormField(
                                controller: _nameCtrl, 
                                decoration: InputDecoration(
                                  labelText: 'Name',
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
                                validator: (v) => v == null || v.trim().isEmpty ? 'Name is Required' : null
                                ),
                                SizedBox(height: 30),
                              TextFormField(
                                controller: _phoneCtrl,
                               decoration: InputDecoration(
                                labelText: 'Phone Number',
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
                               keyboardType: TextInputType.phone, 
                               validator: (v) => v == null || v.trim().isEmpty ? 'Phone Number Required' : null,
                               ),
                                SizedBox(height: 30),
                              TextFormField(
                                controller: _emailCtrl, 
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
                                keyboardType: TextInputType.emailAddress,
                                ),
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