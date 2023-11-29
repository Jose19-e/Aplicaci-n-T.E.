import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:actividades_complementarias/login.dart';
import 'package:actividades_complementarias/Home.dart';

class AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:'249449002253-us4jvhio75loiuieaa3tnbmcnerran41.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  late GoogleSignInAccount? currentUser;

  final BuildContext context;

  static AuthManager? _instance;

  AuthManager._(this.context);

  static AuthManager getInstance(BuildContext context) {
    _instance ??= AuthManager._(context);
    return _instance!;
  }

  Future<void> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleUser != null){
        currentUser = googleUser;
        setupAuthListener();
      }
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

    } catch (e){
      print('Error during Google sign in: $e');
      throw e;
    }
  }

  void setupAuthListener(){
    _googleSignIn.onCurrentUserChanged.listen((account) {
      currentUser = account;
      if(currentUser != null){
        print("El usuario ya esta autenticado");
        IniciarSesion();
      }
    });

    _googleSignIn.signInSilently().then((account) {
      if (account != null){
        currentUser = account;
        print('El usuario se encuentra ya autenticado');
        IniciarSesion();
      }
    }).catchError((e){
      print('Error durante la autenticacion silenciosa: $e');
    });
  }

  void IniciarSesion(){
    GoogleSignInAccount? user = currentUser;
    if (user != null){
      _pantallaHome();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    currentUser = null;
    print('SignOut Exitoso');
    _pantallaFin();
  }

  void _pantallaHome(){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyHomePage(title: "Bienvenido"),
      ),
    );
  }

  void _pantallaFin(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Login(title: "Inicio"),
      ),
    );
  }

  GoogleSignInAccount? getCurrentUser(){
    return currentUser;
  }

}
