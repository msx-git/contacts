import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/contact.dart';
import 'delete_contact_dialog.dart';
import 'manage_contact_sheet.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            colors: [
              Color(0xff9d6ccd),
              Color(0xff622aba),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 1),
              spreadRadius: 1,
              blurRadius: 7,
              color: Color.fromRGBO(127, 83, 172, 0.3),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
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
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return ManageContactSheet(contact: contact);
                },
              );
            },
            icon: const Icon(
              Icons.edit_note_rounded,
              color: Colors.teal,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DeleteContactDialog(contact: contact),
              );
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
  }
}
