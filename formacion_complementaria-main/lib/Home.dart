import 'package:actividades_complementarias/AuthManager.dart';
import 'package:flutter/material.dart';
import 'package:actividades_complementarias/AuthManager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:actividades_complementarias/pantallas/usuario.dart';
import 'package:actividades_complementarias/pantallas/configuracion.dart';
import 'package:actividades_complementarias/pantallas/contador.dart';
import 'package:actividades_complementarias/pantallas/inforQR.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AuthManager handler;
  int _seleccionDrawerItem = 0;

  @override
  void initState(){
    super.initState();
    handler = AuthManager.getInstance(context);
  }

  //Metodo para cambiar de pantalla dentro de nuestro drawer
  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0: return Usuario(title: '',);
      case 1: return Contador();
      case 2: return InfoQR();
      case 3: return Configuracion();
    }
  }

  //Seleccion dentro de nuestro Drawer
  _onSelectItem(int pos){
    Navigator.of(context).pop();
    setState(() {
      _seleccionDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount? currentUser = handler.getCurrentUser();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(currentUser?.displayName ?? ' '),
              accountEmail: Text(currentUser?.email ?? ' '),
              currentAccountPicture: CircleAvatar(
                child: Image.network(
                  currentUser?.photoUrl ?? ' '
                ),
              ),
            ),
            ListTile(
              title: Text('Usuario'),
              leading: Icon(Icons.account_circle),
              onTap: (){
                _onSelectItem(0);
              },
            ),
            ListTile(
              title: Text('Mis Horas'),
              leading: Icon(Icons.assignment_turned_in),
              onTap: (){
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: Text('QR'),
              leading: Icon(Icons.qr_code),
              onTap: (){
                _onSelectItem(2);
              },
            ),
            Divider(),
            ListTile(
              title:  Text('Configuración'),
              leading: Icon(Icons.settings),
              onTap: (){
                _onSelectItem(3);
              },
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              leading: Icon(Icons.logout),
              onTap: () {
                // Puedes utilizar showDialog para confirmar el cierre de sesión
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Cerrar Sesión'),
                      content: Text('¿Estás seguro de que deseas cerrar sesión?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            heroTag: 'googleSignOutButton';
                            handler.signOut();
                          },
                          child: Text('Cerrar Sesión'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("FES Aragon ICO"),
        //backgroundColor: Colors.lightBlueAccent,
      ),
      body: _getDrawerItemWidget(_seleccionDrawerItem),
    );
  }
}