import 'package:hive/hive.dart';
import 'package:untitled/Login%20using%20hiveapapt/model/usermodel.dart';

class Dbfunction{
  Dbfunction.internal();
  //if class have one object we can all it using instance

  static Dbfunction instance=Dbfunction.internal();

  factory Dbfunction(){ //factory constructor
    return instance;
  }

  Future<void>userSignup(User user) async{
    final db=await Hive.openBox<User>('users');
    db.put(user.id, user);
  }
  Future <List<User>>getUser()async{
    final db=await Hive.openBox<User>('users');
    return db.values.toList();
  }

}