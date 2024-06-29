import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/contacts_provider.dart';
import '../widgets/add_contact_sheet.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final contacts = context.watch<ContactsProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: context.watch<ContactsProvider>().contacts,
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
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xff606060),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text(
                      contact.title[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  title: Text(
                    contact.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(contact.phoneNumber),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          color: Colors.teal,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<ContactsProvider>().deleteContact(contact.id);
                        },
                        icon: const Icon(
                          CupertinoIcons.trash,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                );
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
              return const AddContactSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
