import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/CameraScreen.dart';
import 'package:whatsapp/Screens/LoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "OpenSans",
          primaryColor: Color(0xFF075E54),
          appBarTheme: AppBarTheme(backgroundColor: Color(0xFF075E54)),
          tabBarTheme: TabBarTheme(
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xFF128C7E))),
      home: LoginScreen(),
    );
  }
}
