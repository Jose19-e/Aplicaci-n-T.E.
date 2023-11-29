import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:actividades_complementarias/AuthManager.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{

  late AuthManager handler;

  @override
  void initState(){
    super.initState();
    handler = AuthManager.getInstance(context);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Fondo de la pantalla
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/images.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Bienvenido",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 70.0, //
                  ),
                ),

                Image.asset(
                  'assets/images/escudo.jpg',
                  height: 200.0,
                  width: 200.0,
                ),
                SizedBox(height: 40.0),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 250.0),
                  child: ElevatedButton(
                    onPressed: () => handler.signInWithGoogle(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/cuentas-aragon.png',
                          height: 90.0,
                          width: 200.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(''),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}