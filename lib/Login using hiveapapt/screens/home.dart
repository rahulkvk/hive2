import 'package:flutter/material.dart';



class Home extends StatelessWidget{
  final String username;
  const Home({Key?key,required this.username});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body:Center(
        child: Text(
          'Welcome $username',style: const TextStyle(fontSize: 30,color: Colors.greenAccent),
        ),
      )
    );
  }

}