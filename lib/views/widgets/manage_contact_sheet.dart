import 'package:contacts/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../models/contact.dart';
import '../../providers/contacts_controller.dart';

class ManageContactSheet extends StatefulWidget {
  const ManageContactSheet({super.key, this.contact});

  final Contact? contact;

  @override
  State<ManageContactSheet> createState() => _ManageContactSheetState();
}

class _ManageContactSheetState extends State<ManageContactSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController phoneController;
  late final TextEditingController titleController;

  String phoneNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(
      text: widget.contact == null ? "" : widget.contact!.title,
    );
    phoneController = TextEditingController(
      text: widget.contact == null ? "" : widget.contact!.phoneNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.contact == null ? "Add a contact" : "Edit the contact",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              16.height,
              TextFormField(
                controller: titleController,
                textCapitalization: TextCapitalization.words,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: widget.contact == null ? 'Title' : 'New title',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return widget.contact == null
                        ? "Please, enter a title!"
                        : "Please, enter a new title!";
                  }
                  return null;
                },
              ),
              16.height,
              widget.contact == null
                  ? InternationalPhoneNumberInput(
                      formatInput: true,
                      textFieldController: phoneController,
                      keyboardType: TextInputType.phone,
                      inputBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        useBottomSheetSafeArea: true,
                        useEmoji: true,
                      ),
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return "Please, enter a phone number!";
                        }
                        return null;
                      },
                      onInputChanged: (PhoneNumber value) async {
                        phoneNumber = value.phoneNumber.toString();
                      },
                    )
                  : TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'New phone number',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please, enter a new phone number!";
                        }
                        return null;
                      },
                    ),
              12.height,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      widget.contact == null
                          ? await context
                              .read<ContactsController>()
                              .addContact(
                                  title: titleController.text,
                                  phoneNumber: phoneNumber)
                              .then(
                              (_) {
                                titleController.clear();
                                phoneController.clear();
                                Navigator.pop(context);
                              },
                            )
                          : await context
                              .read<ContactsController>()
                              .editContact(
                                id: widget.contact!.id,
                                newTitle: titleController.text,
                                newPhone: phoneController.text,
                              )
                              .then(
                              (_) {
                                titleController.clear();
                                phoneController.clear();
                                Navigator.pop(context);
                              },
                            );
                    }
                  },
                  child: Text(widget.contact == null ? "Add" : "Save"),
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
