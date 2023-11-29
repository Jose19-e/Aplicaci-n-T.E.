import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qr_bar_code/code/code.dart';
import 'package:qr_bar_code/qr/qr.dart';
//import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:actividades_complementarias/AuthManager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:actividades_complementarias/services/firebase_service.dart';


class InfoQR extends StatefulWidget {
  @override
  State<InfoQR> createState() => _InfoQR();
}

class _InfoQR extends State<InfoQR>{
  String numCuenta = "";
  late AuthManager handler;

  AuthUser aU = AuthUser();
  FirebaseFirestore db = FirebaseFirestore.instance;

  void _cargaData() async {
    String? uid = await aU.getCurrentUserUid();
    DocumentSnapshot docs = await db.collection("users").doc("$uid").get();
    //print(handler.getCurrentUserId());
    Map<String, dynamic> campos = docs.data() as Map<String, dynamic>;
    setState(() {
      numCuenta = campos["NumCuenta"];
    });
  }

  @override
  void initState(){
    _cargaData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QRCode(data: numCuenta,size: 200),
          ],
        ),
      ),
    );

  }
}