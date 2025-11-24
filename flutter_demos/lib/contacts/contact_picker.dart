/* File: contact_picker.dart
 * Created by GYGES.Harrison on 2024/11/18 at 15:53
 * Copyright © 2024 GYGES Limited.
 */
// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class SelectContactsExample extends StatefulWidget {
//   const SelectContactsExample({super.key});
//   @override
//   State<SelectContactsExample> createState() => _SelectContactsExampleState();
// }
//
// class _SelectContactsExampleState extends State<SelectContactsExample> {
//   List<Contact> contacts = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchContacts();
//   }
//
//   Future<void> fetchContacts() async {
//     if (await FlutterContacts.requestPermission()) {
//       List<Contact> fetchedContacts = await FlutterContacts.getContacts(
//         withProperties: true, // 获取详细信息
//       );
//       setState(() {
//         contacts = fetchedContacts;
//       });
//     } else {
//       PermissionStatus status = await Permission.contacts.status;
//       if (status.isDenied) {
//         // 请求权限
//         PermissionStatus result = await Permission.contacts.request();
//         if (result.isGranted) {
//           print("联系人权限已授予");
//         } else {
//           await openAppSettings();
//         }
//       } else if (status.isGranted) {
//         print("联系人权限已存在");
//       } else if (status.isPermanentlyDenied) {
//         print("联系人权限被永久拒绝，请前往设置开启权限");
//         await openAppSettings(); // 跳转到应用设置页面
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("通讯录")),
//       body: contacts.isEmpty
//           ? InkWell(
//               onTap: () async {
//                 await fetchContacts();
//               },
//               child: const Center(child: Text("未找到联系人或无权限")))
//           : ListView.builder(
//               itemCount: contacts.length,
//               itemBuilder: (context, index) {
//                 Contact contact = contacts[index];
//                 return ListTile(
//                   title: Text(contact.displayName.isNotEmpty ? contact.displayName : "无姓名"),
//                   subtitle: Text(contact.phones.isNotEmpty ? contact.phones.first.number : "无电话号码"),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

class ContactPickerPage extends StatefulWidget {
  @override
  _ContactPickerPageState createState() => _ContactPickerPageState();
}

class _ContactPickerPageState extends State<ContactPickerPage> {
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  Contact? _contact;

  Future<void> _pickContact() async {
    try {
      final contact = await _contactPicker.selectContact();
      setState(() {
        _contact = contact;
      });
    } catch (e) {
      print("选择联系人失败：$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var phone = '无号码';
    if (_contact != null && _contact!.phoneNumbers != null && _contact!.phoneNumbers!.isNotEmpty) {
      phone = _contact!.phoneNumbers![0];
    }
    return Scaffold(
      appBar: AppBar(title: Text("选择联系人")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _contact == null
                  ? "未选择联系人"
                  : "姓名: ${_contact!.fullName}\n电话: $phone",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickContact,
              child: Text("选择联系人"),
            ),
          ],
        ),
      ),
    );
  }
}