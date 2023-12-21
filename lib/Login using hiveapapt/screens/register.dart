import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/Login%20using%20hiveapapt/database/database.dart';

import '../model/usermodel.dart';


class Reg extends StatefulWidget{

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {
  TextEditingController username= TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController confirmpass= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registeration"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 80,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField( //autofocus: true,
              decoration: InputDecoration(
              hintText: "Name",prefixIcon: Icon(Icons.person)
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: username,
              decoration: InputDecoration(
              hintText: "UserName",prefixIcon: Icon(Icons.person_outline)
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: password,
              decoration: InputDecoration(
              hintText: "Password",prefixIcon: Icon(Icons.password)
            ),),
          ),Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: confirmpass,
              decoration: InputDecoration(
                hintText: "Confirm Password",prefixIcon: Icon(Icons.password)
            ),),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 80,left: 100,right: 100),
            child: ElevatedButton(onPressed: (){
              validatesignup();
            }, child: Text("Register")),
          )
        ],
      )
    );
  }
  void validatesignup()async{
    final email= username.text.trim();//trim used to avoid white space
    final pass= password.text.trim();
    final cpass=confirmpass.text.trim();
    final emailValidationResult= EmailValidator.validate(email);

    if(email !="" && pass!="" && pass!="") {
      if (emailValidationResult == true) {
        final passValidatorResult = checkPassword(pass, cpass);

        if (passValidatorResult == true) {
          final user = User(username: email, password: pass);
          await Dbfunction.instance.userSignup(user);

          Get.back();
          Get.snackbar("success", "Account created");
          print("Registerd");
        }
        else {
          Get.snackbar("Error", "Provide a valid Email");
        }
      }
    }
      else{
        Get.snackbar("Error", "Field can't be empty");
      }
    }
     checkPassword(String pass, String cpass){
      if(pass==cpass){
        if(pass.length<6){Get.snackbar("Error", "Length should >6");}
        else{
          return true;
        }
      }else{Get.snackbar("Error", "Password mistch");
      return false;
      }
    }

  }
