import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';




class AddTodo extends StatefulWidget{
  const AddTodo({super.key});

  
      @override
      State<StatefulWidget> createState() => AddTodoState();
        
   
      
  }
  
  class AddTodoState extends State<AddTodo> {
    TextEditingController titlecontroller = TextEditingController();
   
    TextEditingController descriptioncontroller = TextEditingController();
  addtasktodatabse() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final uid = user!.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('userTasks').doc(time.toString()).set({
      'title':titlecontroller.text,
      'description':descriptioncontroller.text,'time':time.toString(),
    });
    Fluttertoast.showToast(msg:'Task added successfully');
    

  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Add Todo '),
        centerTitle:true,
      ),
      body:Container(
        child:Column(

          children: [
            Text("Add the task you want to do..."),
            TextField( controller :titlecontroller,
              decoration:InputDecoration(
              labelText:'Title',
              labelStyle:TextStyle(color:Colors.black),
              border:OutlineInputBorder(borderRadius: BorderRadius.circular(11.0),)
            ),),
            SizedBox(height:15),
            TextField( controller :descriptioncontroller,
              decoration:InputDecoration(
             
              labelText:'Description',
              labelStyle:TextStyle(color:Colors.black),
              border:OutlineInputBorder(borderRadius: BorderRadius.circular(11.0),)
            ),),
            SizedBox(height:35.0),
            ElevatedButton(child: Text('Add'),
            style:ElevatedButton.styleFrom(shadowColor: Colors.lightBlue,
            textStyle:TextStyle(fontWeight:FontWeight.bold,)),
            onPressed:(){
              addtasktodatabse();
              Navigator.pop(context);
              
            })

          ],
        )
      )

    );
  }
  }