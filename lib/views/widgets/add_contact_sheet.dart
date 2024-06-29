import 'package:contacts/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../providers/contacts_provider.dart';

class AddContactSheet extends StatefulWidget {
  const AddContactSheet({super.key});

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            12.height,
            Text(
              "Add contact",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            10.height,
            TextFormField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Title'),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter title!";
                }
                return null;
              },
            ),
            12.height,
            InternationalPhoneNumberInput(
              formatInput: true,
              textFieldController: phoneController,
              keyboardType: TextInputType.phone,
              inputBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
                useBottomSheetSafeArea: true,
                useEmoji: true
              ),
              validator: (p0) {
                if (p0!.trim().isEmpty) {
                  return "Please, enter phone number!";
                }
                return null;
              },
              onInputChanged: (PhoneNumber value) async {
                phoneNumber = value.phoneNumber.toString();
              },
            ),
            12.height,
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await context
                        .read<ContactsProvider>()
                        .addContact(
                        title: titleController.text,
                        phoneNumber: phoneNumber)
                        .then(
                          (value) {
                        titleController.clear();
                        phoneController.clear();
                        Navigator.pop(context);
                      },
                    );
                  }
                },
                child: const Text("Add"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewInsets.bottom,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    titleController.dispose();
    super.dispose();
  }
}
