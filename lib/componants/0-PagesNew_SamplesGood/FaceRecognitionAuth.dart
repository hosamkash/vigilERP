import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FaceRecognitionAuth extends StatefulWidget {
  @override
  _FaceRecognitionAuthState createState() => _FaceRecognitionAuthState();
}

class _FaceRecognitionAuthState extends State<FaceRecognitionAuth> {
  final LocalAuthentication auth = LocalAuthentication();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String _authStatus = 'لم يتم التحقق بعد';

  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'يرجى التحقق من هويتك',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      print(e);
    }

    if (authenticated) {
      setState(() {
        _authStatus = 'تم التحقق بنجاح';
      });

      // تسجيل الحضور في Firestore
      await _registerAttendance();
    } else {
      setState(() {
        _authStatus = 'فشل التحقق';
      });
    }
  }

  Future<void> _registerAttendance() async {
    try {
      await firestore.collection('attendance').add({
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'حضور',
      });
      print('تم تسجيل الحضور بنجاح');
    } catch (e) {
      print('فشل تسجيل الحضور: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الحضور باستخدام بصمة الوجه')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_authStatus),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('تحقق باستخدام بصمة الوجه'),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: FaceRecognitionAuth(),
//   ));
// }