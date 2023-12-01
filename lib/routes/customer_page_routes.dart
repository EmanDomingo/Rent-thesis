// class AssistantMethods {
//   static void readCurrentOnLineUserInfo() async {
//     currentUser = firebaseAuth.currentUser;
//     DatabaseReference userRef =
//         FirebaseDatabase.instance.ref().child("users").child(currentUser!.uid);

//     userRef.once().then(
//       (snap) {
//         if (snap.snapshot.value != null) {
//           userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
//         }
//       },
//     );
//   }