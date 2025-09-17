# contacts_hive

A new Flutter project.


Project Arctecture

lib
 main.dart
 models/
    contact_model.dart
l10n/
    app_en.arb
    app_hi.arb
    app_te.arb
 screens/
    contact_list_screen.dart
    add_contact_screen.dart
    edit_contact_screen.dart
    view_contact_screen.dart


why this approach is useful?

Hive Database:

 1.Lightweight & super-fast No SQlFlight or SQL DB for Flutter.

 2.Data persists locally even after hot restart and app restarts.

 3.Useful for storing larger data

 4.No internet required.

 5.Easy to use

Localization:

 1.Built-in support for multiple languages.

 2.Easy to add multiple languages using .arb files.



- How to run the project.

 1. Clone the Repository
   using git clone "path"
   cd "app folder path"

 2. Install Dependencies
    using flutter pub get

 3. Install Hive Dependencies
     hive
     hive_flutter
     path_provider

Also add build_runner and hive_generator for model adapter
    hive_generator: ^2.0.1
    build_runner: ^2.4.8






## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
