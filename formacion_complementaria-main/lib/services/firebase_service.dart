import 'package:firebase_auth/firebase_auth.dart';


class AuthUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getCurrentUserUid() async{
    try{
      User? user = _auth.currentUser;
      if(user != null){
        return user.uid;
      }else{
        return null;
      }
    }catch(e){
      print("Error al obtener el UID: $e");
      return null;
    }
  }
}