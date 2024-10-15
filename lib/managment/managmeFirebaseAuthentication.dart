import 'package:firebase_auth/firebase_auth.dart';  //  firebase_auth: ^5.2.0

class managmeFirebaseAuthentication
{
static Future<String> createUserWithEmailAndPassword(String email, String password) async {
	return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((user) {
		return user.user!.uid;
	}).catchError((error) {
		print(error);
		throw error;
	});
}

}
