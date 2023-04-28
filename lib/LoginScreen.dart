import 'package:flutter/material.dart';
import 'package:todo_app/Loginform.dart';



class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  
      @override
      State<StatefulWidget> createState() => LoginScreenState();
        
   
      
  }
  
  class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Login'),centerTitle:true,),
      
      body: const LoginForm() ,
    );
    
  }
  }

