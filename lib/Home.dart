import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/AddTodo.dart';




class Home extends StatefulWidget{
  const Home({super.key});

  
      @override
      State<StatefulWidget> createState() => HomeState();
        
   
      
  }
  
  class HomeState extends State<Home> {
    String uid ='';
  @override
  void initState(){
    super.initState();
    getuid();
  }
  getuid() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
    
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      backgroundColor: Colors.blueGrey,
      title: Row(
       children: [
        RichText(text: TextSpan(
    
    children: <TextSpan>[
      TextSpan(text: 'T', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,color:Colors.red.shade300)),
      const TextSpan(text: 'o',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.white)),
      TextSpan(text: 'D', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,color:Colors.red.shade300)),
      const TextSpan(text: 'o',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.white)),

    ],)
  ),
 GestureDetector(
  onTap:(){
    FirebaseAuth.instance.signOut();

  },
  child:Container(
    child:const Icon(Icons.exit_to_app),
  ),
 )
 ])
),


      
    body: Container(
      height:MediaQuery.of(context).size.height,
      width:MediaQuery.of(context).size.width,
      child:StreamBuilder(stream:FirebaseFirestore.instance.collection('tasks').doc(uid).collection('userTasks').snapshots(),
      builder:(context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else{
          return ListView.builder(itemCount:snapshot.data!.docs.length,itemBuilder:(context,index){
            return Card(child:ListTile(
            title:Text(snapshot.data!.docs[index]['title']),
            subtitle: Text(snapshot.data!.docs[index]['description']),
            trailing: IconButton(
              icon:Icon(Icons.delete),
            onPressed: (){
              FirebaseFirestore.instance.collection('tasks').doc(uid).
              collection('userTasks').doc(snapshot.data!.docs[index].id).delete();},)
              )
              );
          }
          );}
   } )
          ),
            
           
    floatingActionButton: FloatingActionButton(
      onPressed:() {
        Navigator.push(context,MaterialPageRoute(builder:(context) => AddTodo()));

      },
      child:Icon(Icons.add),
      backgroundColor: Colors.lightBlue,
      ),
    );
    
  }
  }
