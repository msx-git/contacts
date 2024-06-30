import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/contacts_controller.dart';
import '../widgets/manage_contact_sheet.dart';
import '../widgets/contact_item.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: context.watch<ContactsController>().contacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Couldn't get contacts."));
          } else if (snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              "No contacts\n\nYou can add a contact with  +  button.",
              textAlign: TextAlign.center,
            ));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final contact = snapshot.data![index];
                return ContactItem(contact: contact);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const ManageContactSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
