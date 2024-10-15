import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../shared/sharedFunctions.dart';

class ctr_ContactsListFromMobile extends StatefulWidget {
  const ctr_ContactsListFromMobile({super.key});

  @override
  State<ctr_ContactsListFromMobile> createState() => _ctr_ContactsListFromMobileState();
}

class _ctr_ContactsListFromMobileState extends State<ctr_ContactsListFromMobile> {


  @override
  void initState() {
    super.initState();
    loadContactsPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('اختيار جهة الاتصال'),
        backgroundColor: Colors.white,
        titleSpacing: 20,
        actions: [
          // const SizedBox(width: 210),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_forward),
          ),
          // const SizedBox(width: 100),
        ],
      ),
      body:sharedFunctions_ContactsPhone.phoneContactsList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: sharedFunctions_ContactsPhone.phoneContactsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sharedFunctions_ContactsPhone.phoneContactsList[index].displayName ?? ''),
                  subtitle: Text((sharedFunctions_ContactsPhone.phoneContactsList[index].phones?.isNotEmpty ?? false) ? sharedFunctions_ContactsPhone.phoneContactsList[index].phones!.first.value ?? '' : ''),
                  onTap: () {
                    // هنا يمكنك استخدام بيانات العميل
                    var selectedContact = sharedFunctions_ContactsPhone.phoneContactsList[index];
                    print('Selected Contact: ${selectedContact.displayName}');
                    // يمكنك تنفيذ أي إجراء آخر هنا
                    Navigator.pop(context, selectedContact);
                  },
                );
              },
            ),
    );
  }

  Future<void> loadContactsPhone() async {

    // لو تم تعبئة البيانات مره ميعبيش تاني إلا بطلب المستخدم
    if(sharedFunctions_ContactsPhone.phoneContactsList.length > 0)
      return ;

    var status = await Permission.contacts.status;

    if (!status.isGranted) {
      await Permission.contacts.request();
    }

    if (await Permission.contacts.isGranted) {
      _loadContacts();
    }
  }

  Future<void> _loadContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      sharedFunctions_ContactsPhone.phoneContactsList = contacts.toList();
    });
  }


  }


