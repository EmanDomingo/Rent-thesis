

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:rental_app/views/buyers/productDetail/store_detail_screen.dart';

// class StoreScreen extends StatelessWidget {
//   const StoreScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> _ownersStream = FirebaseFirestore.instance.collection('owners').snapshots();


//     return StreamBuilder<QuerySnapshot>(
//       stream: _ownersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(
//               color: Colors.blue.shade300,
//             ),
//           );
//         }

//         return Scaffold(
//           appBar: AppBar(
//         title: Text(
//           'LIST OWNERS',
//           style: TextStyle(
//           color: const Color.fromARGB(255, 60, 128, 184),
//           fontFamily: 'JosefinSans',
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//           ),
//         ),
        
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(14.0),
//             child: Icon(Icons.list_sharp,
//             color: Colors.white,
//             ),
//           ),
//         ],
//       ),
        
//         body: SingleChildScrollView(
//           child: Container(
//             height: 500,
//             child: ListView.builder(
//               itemCount: snapshot.data!.size,
//               itemBuilder: (context, index) {
//                 final storeData = snapshot.data!.docs[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(context,
//                     MaterialPageRoute(builder: (context) {
//                       return StoreDetailScreen(storeData: storeData,);
//                     }));
//                   },
//                   child: ListTile(
//                     title: Text(storeData['bussinessName'],
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromRGBO(53, 61, 104, 1),
//                     ),
//                     ),
//                     subtitle: Text(storeData['countryValue']),
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(storeData['storeImage']),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//         )
//         );
//       },
//     );
//   }
// }