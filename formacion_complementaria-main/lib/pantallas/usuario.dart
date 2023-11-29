import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:actividades_complementarias/AuthManager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:actividades_complementarias/services/firebase_service.dart';

class Usuario extends StatefulWidget{
  const Usuario({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Usuario> createState() => _usuario();
}

class _usuario extends State<Usuario>{
  late AuthManager handler;

  AuthUser aU = AuthUser();


  FirebaseFirestore db = FirebaseFirestore.instance;

  String nombre = "";
  String numCuenta = "";
  String carrera = "";
  String ingreso="";




  @override
  void initState(){
    _cargaData();
    super.initState();
    handler = AuthManager.getInstance(context);
  }

  void _cargaData() async {
    String? uid = await aU.getCurrentUserUid();
    DocumentSnapshot docs = await db.collection("users").doc("$uid").get();
    //print(handler.getCurrentUserId());
    Map<String, dynamic> campos = docs.data() as Map<String, dynamic>;
    setState(() {
      nombre = campos["Nombre"];
      numCuenta = campos["NumCuenta"];
      print(numCuenta);
      carrera = campos["Carrera"];
      print(carrera);
      ingreso = campos["AñoIngreso"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount? currentUser = handler.getCurrentUser();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                'Bienvenido'
            ),
            Image.network(
              currentUser?.photoUrl ?? ' ',
              width: 200,
              height: 200,
            ),
            Text(nombre),
            Text('Numero de cuenta: ' + numCuenta),
            Text('Carrera: ' + carrera),
            Text('Año de ingreso: ' + ingreso),
            /*Text(
              'UID: ${handler.getCurrentUserId()}',
                //'${currentUser?.id}',
            ),*/
          ],
        ),
      ),
    );
  }
}