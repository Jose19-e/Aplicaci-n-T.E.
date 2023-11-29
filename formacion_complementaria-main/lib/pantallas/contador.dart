import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_service.dart';

class Contador extends StatefulWidget {
  @override
  State<Contador> createState() => _Contador();
}

class _Contador extends State<Contador>{
  FirebaseFirestore db = FirebaseFirestore.instance;
  AuthUser aU = AuthUser();

  List<String> tipo = [];
  List<String> actividad = [];
  List<String> horas = [];

  int suma = 0;

  void _cargaData() async {
    String? uid = await aU.getCurrentUserUid();
    QuerySnapshot hdoc = await db.collection("users").doc('$uid')
        .collection("HorasComplementarias").get();

    for(int j=0; j<hdoc.docs.length; j++){
      Map<String, dynamic> campo = hdoc.docs.elementAt(j).data() as Map<String, dynamic>;
      setState(() {
        tipo.add(campo["Nombre"]);
        print('Insercion de tipo: ' + tipo[j]);
        actividad.add(campo["Actividad"]);
        print('Insercion de Actividad: ' + actividad[j]);
        horas.add(campo["Horas"]);
      });
    }
  }

  List<DataRow> _cargaLista(){
    List<DataRow> datos = [];
    //int _suma = 0;
    for (int i=0; i<tipo.length; i++){
      datos.add(
        DataRow(
            cells: <DataCell>[
              DataCell(Text(tipo[i])),
              DataCell(Text(actividad[i])),
              DataCell(Text(horas[i])),
            ]
        ),
      );
      suma += int.parse(horas[i]);

    }

    return datos;
  }

  @override
  void initState(){
    _cargaData();
  }

  Widget crearTabla(){
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
              child: Text('Nombre', style: TextStyle(fontStyle: FontStyle.italic),),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text('Actividad', style: TextStyle(fontStyle: FontStyle.italic),),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text('Horas', style: TextStyle(fontStyle: FontStyle.italic),),
          ),
        )
      ],
      rows: _cargaLista(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          crearTabla(),
          Text('Horas totales: ${suma}', style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}