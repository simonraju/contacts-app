import 'package:contacts_provider/provider/contact_provier.dart';
import 'package:contacts_provider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/contacts_list_screen.dart';

void main() {

runApp(
  ChangeNotifierProvider(
    create: (_) => ContactProvider(),
    child: MyApp(),
  ),
);}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts ',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
    
      home: const ContactsListScreen(),
    );
  }
}
