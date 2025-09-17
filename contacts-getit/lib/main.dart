import 'package:contacts_getit/screens/contacts_list_screen.dart';
import 'package:contacts_getit/theme.dart';
import 'package:flutter/material.dart';
import 'getit/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: ContactsListScreen(),
    );
  }
}

