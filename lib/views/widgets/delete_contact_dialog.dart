import 'package:contacts/providers/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/contact.dart';

class DeleteContactDialog extends StatelessWidget {
  const DeleteContactDialog({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Deleting the contact?"),
      content: ListTile(
        title: Text(
          contact.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(contact.phoneNumber),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.teal),
          ),
        ),
        TextButton(
          onPressed: () async => await context
              .read<ContactsController>()
              .deleteContact(contact.id)
              .then(
                (_) => Navigator.pop(context),
              ),
          child: const Text(
            "Yes, delete",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
