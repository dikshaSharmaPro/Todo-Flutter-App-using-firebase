import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Home.dart';
import 'package:todo_app/LoginScreen.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      // options:DefaultFirebaseOptions.currentPlatform,
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blueGrey,
      ),
      home: StreamBuilder(stream:FirebaseAuth.instance.authStateChanges(),
      builder:(context,userSnapshot){
        if(userSnapshot.hasData){
          return Home();
        }else{
          return const LoginScreen();
        }
      })
    );
  }
}

