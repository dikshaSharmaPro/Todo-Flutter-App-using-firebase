import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var username = '';
  var email = '';
  var password = '';
  bool isLogin = true;

  startauthenication() async {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      submitform(username, email, password);
    }
  }

  submitform(String username, String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      if (isLogin) {
        authResult = await  auth.signInWithEmailAndPassword(email: email, password: password);
  
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String userKiUid = authResult.user!.uid;
       
        await FirebaseFirestore.instance.collection('users').doc(userKiUid).set({
          'username': username,
          'email': email,
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: ListView(children: [
          Padding(
              padding: const EdgeInsets.all(21.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                           validator: (value) {
                              //value = examplegmail.com
                              if (value!.isEmpty ) {
                                return 'Please Enter name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              username = value!;
                            },
                            key:ValueKey('username'),
                            decoration: InputDecoration(
                          // hintText: 'Enter username ..',
                            labelText: 'Username',

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide:
                                  BorderSide(color: Colors.blue.shade900)),
                          prefixIcon: const Icon(Icons.account_circle_outlined),
                        )),
                        const SizedBox(height: 11),


                        TextFormField(
                          //user ne jo bhi type kara hai vo value mai store ho jyega
                            validator: (value) {
                              //value = examplegmail.com
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please Enter valid Email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email = value!;
                            },
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              // hintText: 'Enter email..',
                              labelText: 'Email',

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                      BorderSide(color: Colors.blue.shade900)),
                              prefixIcon: const Icon(Icons.email_rounded),
                            )),
                        const SizedBox(height: 11),
                        TextFormField(
                          validator:(value){
                            if(value!.isEmpty || value.length <7){
                              return'Please enter strong password';
                            }
                            return null;

                          },
                          onSaved:(value){
                            password = value!;
                          },
                          key:ValueKey('password'),
                            obscureText: true,
                            decoration: InputDecoration(
                                // hintText: 'Enter password..',
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11.0),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                                prefixIcon: const Icon(Icons.password_rounded),
                                suffixIcon:
                                    const Icon(Icons.remove_red_eye_outlined)
                                    )),

                        const SizedBox(height:11.0,),
                        Container(height:60,
                        width:double.infinity,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color:Colors.blue,
                        ),
                        child: ElevatedButton(onPressed: startauthenication, child: Text(isLogin ? 'Login':'Sign up',
                        style: const TextStyle(color:Colors.white,fontSize:20.0,)))
                    ),

                    const SizedBox(height:10.0),
                    TextButton(child: Text(isLogin ? 'Create new account': 'I already have an account', style:const TextStyle(
                      color:Colors.blue,fontSize:20.0,)),
                      onPressed:(){
                        setState(() {
                          isLogin=!isLogin;
                        });
                      } ,)
                      ])))
        ]),
      ),
    );
  }
}
