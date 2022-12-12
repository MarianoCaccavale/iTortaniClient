import 'package:flutter/material.dart';
import 'package:i_tortani_v_2_0/Screens/Spese/SpeseDetailScreen.dart';
import 'package:i_tortani_v_2_0/Utils/DB/Spese/SpeseDBUser.dart';
import 'package:i_tortani_v_2_0/Utils/Models/SpeseOrder.dart';

import 'SpeseAddScreen.dart';

class SpeseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpeseScreenState();
  }
}

class _SpeseScreenState extends State<SpeseScreen> {
  List<SpeseOrder> listaSpese = [];
  int speseTot = 0, speseRitirate = 0, speseNonRitirate = 0;
  bool isSearching = false;

  TextEditingController controllerSearch = new TextEditingController();

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _contaSpese() {
    speseTot = 0;
    speseNonRitirate = 0;
    speseRitirate = 0;

    speseTot = listaSpese.length;

    listaSpese.forEach((spesa) {
      if (spesa.ritirato != null) {
        speseRitirate++;
      } else {
        speseNonRitirate++;
      }
    });

    setState(() {});
  }

  _setup() async {
    listaSpese = await SpeseDbUser.getAllSpese();

    setState(() {
      listaSpese = listaSpese;
    });
    _contaSpese();
  }

  _search(String nomeCliente) async {
    if (nomeCliente.compareTo('') != 0) {
      listaSpese = await SpeseDbUser.searchOrder(nomeCliente);

      setState(() {
        listaSpese = listaSpese;
      });

      _contaSpese();
    } else {
      _setup();
    }
  }

  Future<void> onRefresh() async {
    _contaSpese();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                autofocus: false,
                controller: controllerSearch,
                onSubmitted: (nomeCliente) => _search(nomeCliente),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0x2B8E8E93),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              )
            : Text("Lista Spese"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: RefreshIndicator(
            child: listaSpese.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Image.asset(
                          'assets/empty-cart.png',
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                      ),
                      Text("Sembra non ci sia nessuna spesa!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Text(
                                  'Totale spese: ' + speseTot.toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Ritirate: ' + speseRitirate.toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.green),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Non ritiriate: ' +
                                      speseNonRitirate.toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red),
                                ),
                              ),
                            ]),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 2,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: listaSpese.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                  listaSpese[index].cliente +
                                      ' - ' +
                                      ((listaSpese[index].ritirato != null)
                                          ? "RITIRATO"
                                          : "NON RITIRATO"),
                                  style: TextStyle(
                                      color:
                                          (listaSpese[index].ritirato != null)
                                              ? Colors.green
                                              : Colors.red)),
                              subtitle: listaSpese[index].data_ritiro != null
                                  ? Text(
                                      "") //listaSpese[index].data_ritiro.toString().split(" ").first
                                  : Text("Data non trovata"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () async {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => SpeseDetailScreen(
                                            listaSpese[index])));
                                _search(controllerSearch.text);
                              },
                            );
                          }),
                    ],
                  ),
            onRefresh: onRefresh),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SpeseAddScreen();
            }));
            _search(controllerSearch.text);
          },
          child: Icon(Icons.add)),
    );
  }
}
