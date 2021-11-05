import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variaveis para pegar os dados
  double totalCasos;
  double totalMortos;
  double totalCurados;
  bool carregado = false;

  getInfoVirus() async {
    String url = "http://coronavirusdata.herokuapp.com/";
    http.Response response;
    response = await http.get(url);
    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);
      print(decodeJson['paises']['Brasil']);
      //retorna somente os parametros selecionados
      return (decodeJson['paises']['Brasil']);
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getInfoVirus().then((map) {
      setState(() {
        totalCasos = map['totalCasos'];
        totalMortos = map['totalMortes'];
        totalCurados = map['totalCurados'];
        carregado = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: carregado
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Total de Casos " + totalCasos.toString(),
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      "Total de Mortes " + totalMortos.toString(),
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      "Total de Curados " + totalCurados.toString(),
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: Text(
                  "Carregando...",
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
      ),
    );
  }
}
