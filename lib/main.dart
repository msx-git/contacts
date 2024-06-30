import 'package:contacts/providers/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/screens/contacts_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactsController(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ContactsScreen(),
      ),
    );
  }
}
