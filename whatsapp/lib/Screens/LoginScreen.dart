import 'package:flutter/material.dart';
import 'package:whatsapp/Model/ChatModel.dart';
import 'package:whatsapp/Screens/Homescreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
        name: "Sadrib",
        status: "A full stack developer",
        isGroup: false,
        time: '6.00 am',
        currentMessage: 'Hi',
        icon: '',
        id: 1),
    ChatModel(
        name: "Mahi",
        status: "Flutter Developer...........",
        isGroup: false,
        time: '4.00 pm',
        currentMessage: 'yes',
        icon: '',
        id: 10),
    ChatModel(
        name: "Arman",
        status: "Web developer...",
        isGroup: false,
        time: '3.00 am',
        currentMessage: 'are u there',
        icon: '',
        id: 11),
    ChatModel(
        name: "Bhanu Dev",
        status: "App developer....",
        isGroup: true,
        time: '2.00 pm',
        currentMessage: 'Hi',
        icon: '',
        id: 16),
  ];

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // WhatsApp logo
            Image.network(
              'https://img.freepik.com/premium-photo/modern-whatsapp-logo_971166-92502.jpg?size=626&ext=jpg', // Path to the WhatsApp logo
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),

            // Welcome message
            Text(
              "Welcome to WhatsApp clone",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),

            // Phone number input
            Text(
              "Enter your phone number",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "Enter your phone number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Done button
            ElevatedButton(
              onPressed: () {
                // Simulate the login and navigate to the home screen
                sourceChat = chatmodels[0]; // Default to first chat
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => Homescreen(
                      chatmodels: chatmodels,
                      sourchat: sourceChat,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  backgroundColor: Colors.green),
              child: Text(
                "Done",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
