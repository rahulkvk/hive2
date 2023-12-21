import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/Login%20using%20hiveapapt/database/database.dart';
import 'package:untitled/Login%20using%20hiveapapt/model/usermodel.dart';
import 'package:untitled/Login%20using%20hiveapapt/screens/home.dart';
import 'package:untitled/Login%20using%20hiveapapt/screens/register.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.openBox<User>('user');

  runApp(GetMaterialApp(home: Log(),));
}

class Log extends StatelessWidget{
  TextEditingController uname=TextEditingController();
  TextEditingController pass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: uname,
              autofocus: true,
              decoration: InputDecoration(
              hintText: "UserName",prefixIcon: Icon(Icons.person_outline)
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: pass,
              decoration: InputDecoration(
              hintText: "Password",prefixIcon: Icon(Icons.password_sharp)
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60,left: 100,right: 100),
            child: ElevatedButton(onPressed: ()async{
              final userList=await Dbfunction.instance.getUser();
              findUser(userList);

            }, child: Text("Login")),
          ),
          TextButton(onPressed: (){
            Get.to(Reg());
          }, child:const Text("Not a user! ... Register Here"))

        ],
      ),
    );
  }
  Future<void>findUser(List<User>userList)async{
    final username=uname.text.trim();
    final password=pass.text.trim();
    bool userFound=false;
    final validate=await validateLogin(username,password);

    if(validate==true){
      await Future.forEach(userList, (user) {
        if(user.username==username && password==password){
          userFound=true;
        }else{
          userFound=false;
        }
      });
      if(userFound==true){
        Get.offAll(()=>Home(username:username));
        Get.snackbar("success", "Login success",backgroundColor: Colors.green);
      }else{
        Get.snackbar("Error", "Incorrect password",backgroundColor: Colors.red);
      }

    }

  }
  Future<bool> validateLogin(String username,String password)async{
    if(username!='' && password !=''){
      return true;
    }else{
      Get.snackbar("Error", "Fields can't be Empty",backgroundColor: Colors.red);
      return false;
    }
  }

}