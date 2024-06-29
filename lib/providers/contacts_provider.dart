import 'package:contacts/services/database/db_service.dart';
import 'package:flutter/material.dart';

import '/models/contact.dart';

class ContactsProvider with ChangeNotifier {
  final _dbService = DbService();
  List<Contact> _list = [];

  Future<List<Contact>> get contacts async {
    _list = await _dbService.getContacts();
    return _list;
  }

  Future<void> addContact({
    required String title,
    required String phoneNumber,
  }) async {
    await _dbService.addContact(title: title, phoneNumber: phoneNumber);
    notifyListeners();
  }

  Future<void> deleteContact(int id) async {
    await _dbService.deleteContact(id);
    notifyListeners();
  }
}
