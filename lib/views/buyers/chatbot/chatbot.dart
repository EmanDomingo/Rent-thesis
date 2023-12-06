
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/chatbot/Messages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rentbot',
      theme: ThemeData(brightness: Brightness.dark),
      home: Chatbot(),
    );
  }
}

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  List<String> predefinedQuestions = [
    "What types of properties do you have?",
    "How much is the rent for a one-bedroom apartment?",
    "What amenities are included in the rent?",
    "What amenities are included in the rent?",
    "What amenities are included in the rent?",
    "What amenities are included in the rent?",
    "What amenities are included in the rent?",
    "What amenities are included in the rent?",
    // Add more questions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 60, 128, 184),
        title: Text(
          'Chatbot',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(
              Icons.chat,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            // Display clickable questions in a vertical scrollable list
            Container(
              height: 230, // Set a fixed height for the list
              padding: EdgeInsets.symmetric(horizontal: 14),
              color: Colors.white,
              child: ListView(
                children: [
                  for (String question in predefinedQuestions)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _controller.text = question;
                        });
                        sendMessage(question);
                      },
                      child: Text(question),
                    ),
                ],
              ),
            ),
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Color.fromARGB(255, 45, 114, 241),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  sendMessage(String text) async {
    
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(
            Message(
                text: DialogText(
              text: [
                text,
              ],
            )),
            true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));

      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
  









  
  // if (response.message == null) return;
  //       setState(() {
  //         addMessage(response.message!);
  //       });
  //     }
  //   }

  //   addMessage(Message message, [bool isUserMessage = false]){
  //     messages.add({
  //       'message': message,
  //       'isUserMessage': isUserMessage
  //     });
  //   }
  // }
  











  
//   void sendMessage(String text) async {
//   if (text.isEmpty) {
//     print('Message is empty');
//   } else {
//     setState(() {
//       addMessage(Message(text: DialogText(text: [text]),), true);
//     });

//     DetectIntentResponse response = await dialogFlowtter.detectIntent(
//         queryInput: QueryInput(text: TextInput(text: text)));

//     if (response.message == null) return;
//     setState(() {
//       addMessage(response.message!);
    
//     });

//     // Handle product-related queries
//     if (text.contains('show products') || text.contains('product details')) {
//       // Fetch product details from Firebase
//       final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//       CollectionReference productsCollection = _firestore.collection('products');

//       // Get the snapshot of the products collection
//       QuerySnapshot snapshot = await productsCollection.get();

//       // Process product data
//       List<Product> products = [];
//       for (DocumentSnapshot document in snapshot.docs) {
//         Product product = Product(
//           ownerId: document.id,
//           productName: document.get('productName'),
//           category: document.get('category'),
//           productPrice: document.get('productPrice'),
//           imageUrl: document.get('imageUrl'),
//         );

//         products.add(product);
//       }

//       // Display product details in the chatbot
//       if (text.contains('show products')) {
//         // Display product list
//         for (Product product in products) {
//           addMessage(Message(
//             text: DialogText(
//               text: [
//                 'Product Name: ${product.productName}',
//                 'Product Description: ${product.category}',
//                 'Product Price: ${product.productPrice}',
//               ],
//             ),
//           ), true);
//         }
//       } else if (text.contains('product details')) {
//         // Extract product name from the query
//         String productName = text.split('product details')[1].trim();

//         // Find the product with the specified name
//         Product? productDetails;
//         for (Product product in products) {
//           if (product.productName.toLowerCase() == productName.toLowerCase()) {
//             productDetails = product;
//             break;
//           }
//         }

//         // Display product details if found
//         if (productDetails != null) {
//           addMessage(Message(
//             text: DialogText(
//               text: [
//                 'Product Name: ${productDetails.productName}',
//                 'Product Description: ${productDetails.category}',
//                 'Product Price: ${productDetails.productPrice}',
//                 //'Product Image: ${productDetails.imageUrl[0]}',
//               ],
//             ),
//           ), true);
//         } else {
//           addMessage(Message(
//             text: DialogText(
//               text: ['No product found with the name: $productName'],
//             ),
//           ), true);
//         }
//       }
//     }
//   }
// }






  //   sendMessage(String text) async {

  //     if (text.isEmpty) {
  //       print('Message is empty');
  //     }
  //     else {
  //       setState(() {
  //         addMessage(Message(
  //           text: DialogText(text: [text,],)),true);
  //       });

  //       DetectIntentResponse response = await dialogFlowtter.detectIntent(
  //         queryInput: QueryInput(text: TextInput(text: text)));
        
  //       if (text.contains('owner name')) {
  //   // Get the products from Firebase.
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   CollectionReference productsCollection = _firestore.collection('products');
  //   QuerySnapshot snapshot = await productsCollection.get();

  //   // Iterate over the snapshot and add the products to the list.
  //   List<Product> products = [];
  //   for (DocumentSnapshot document in snapshot.docs) {
  //     Product product = Product(
  //       ownerId: document.id,
  //       productName: document.get('productName'),
  //       category: document.get('category'),
  //       productPrice: document.get('productPrice'),
  //     );

  //     products.add(product);
  //   }

  //   // Update the list of products in the chatbot.
  //   setState(() {
  //     messages.clear();
  //     for (Product product in products) {
  //       addMessage(Message(
  //         text: DialogText(text: [product.productName, product.productPrice.toString()]),
  //       ), true);
  //     }
  //   });

  //   // Listen for realtime changes to the products collection.
  //   productsCollection.snapshots().listen((snapshot) {
  //     // Get the list of products from the snapshot.
  //     List<Product> products = [];
  //     for (DocumentSnapshot document in snapshot.docs) {
  //       Product product = Product(
  //         ownerId: document.id,
  //         productName: document.get('productName'),
  //         category: document.get('category'),
  //         productPrice: document.get('productPrice'),
  //       );

  //       products.add(product);
  //     }

  //     // Update the list of products in the chatbot.
  //     // setState(() {
  //     //   messages.clear();
  //     //   for (Product product in products) {
  //     //     addMessage(Message(
  //     //       text: DialogText(text: [product.productName, product.productPrice.toString()],
  //     //       ),
  //     //     ), true);
  //     //   }
  //     // });
  //   });
  // }
  // if (text.contains('price')) {
  //   // Get the products from Firebase.
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   CollectionReference productsCollection = _firestore.collection('products');
  //   QuerySnapshot snapshot = await productsCollection.get();

  //   // Iterate over the snapshot and add the products to the list.
  //   List<Product> products = [];
  //   for (DocumentSnapshot document in snapshot.docs) {
  //     Product product = Product(
  //       ownerId: document.id,
  //       productName: document.get('productName'),
  //       category: document.get('category'),
  //       productPrice: document.get('productPrice'),
  //     );

  //     products.add(product);
  //   }

  //   // Update the list of products in the chatbot.
  //   // setState(() {
  //   //   messages.clear();
  //   //   for (Product product in products) {
  //   //     addMessage(Message(
  //   //       text: DialogText(text: [product.productPrice.toString()]),
  //   //     ), true);
  //   //   }
  //   // });

  //   // Listen for realtime changes to the products collection.
  //   productsCollection.snapshots().listen((snapshot) {
  //     // Get the list of products from the snapshot.
  //     List<Product> products = [];
  //     for (DocumentSnapshot document in snapshot.docs) {
  //       Product product = Product(
  //         ownerId: document.id,
  //         productName: document.get('productName'),
  //         category: document.get('category'),
  //         productPrice: document.get('productPrice'),
  //       );

  //       products.add(product);
  //     }

  //     // Update the list of products in the chatbot.
  //     setState(() {
  //       messages.clear();
  //       for (Product product in products) {
  //         addMessage(Message(
  //           text: DialogText(text: [product.productPrice.toString()],),
  //         ), true);
  //       }
  //     });
  //   });
  // }

  // if (text.contains('rent')) {
  //   // Get the products from Firebase.
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   CollectionReference productsCollection = _firestore.collection('products');
  //   QuerySnapshot snapshot = await productsCollection.get();

  //   // Iterate over the snapshot and add the products to the list.
  //   List<Product> products = [];
  //   for (DocumentSnapshot document in snapshot.docs) {
  //     Product product = Product(
  //       ownerId: document.id,
  //       productName: document.get('productName'),
  //       category: document.get('category'),
  //       productPrice: document.get('productPrice'),
  //     );

  //     products.add(product);
  //   }

  //   // Update the list of products in the chatbot.
  //   setState(() {
  //     messages.clear();
  //     for (Product product in products) {
  //       addMessage(Message(
  //         text: DialogText(text: [product.category, product.productPrice.toString()],),
          
  //       ), true);
  //     }
  //   });

  //   // Listen for realtime changes to the products collection.
  //   productsCollection.snapshots().listen((snapshot) {
  //     // Get the list of products from the snapshot.
  //     List<Product> products = [];
  //     for (DocumentSnapshot document in snapshot.docs) {
  //       Product product = Product(
  //         ownerId: document.id,
  //         productName: document.get('productName'),
  //         category: document.get('category'),
  //         productPrice: document.get('productPrice'),
  //       );

  //       products.add(product);
  //     }

  //     // Update the list of products in the chatbot.
  //     // setState(() {
  //     //   messages.clear();
  //     //   for (Product product in products) {
  //     //     addMessage(Message(
  //     //       text: DialogText(text: [product.category, product.productPrice.toString()],),
  //     //     ), true);
  //     //   }
  //     // });
  //   });
  // }
