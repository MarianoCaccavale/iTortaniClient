import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:i_tortani_v_2_0/Screens/Tortani/TortaniAddScreen.dart';
import 'package:i_tortani_v_2_0/Screens/Tortani/TortaniDetailsScreen.dart';
import 'package:i_tortani_v_2_0/Screens/Tortani/TortaniListWithDate.dart';
import 'package:i_tortani_v_2_0/Utils/Constants.dart';
import 'package:i_tortani_v_2_0/Utils/Models/Entity/TortaniOrder.dart';

import '../../Utils/API/Tortani/TortaniAPIUser.dart';

class TortaniScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TortaniScreenState();
  }
}

class _TortaniScreenState extends State<TortaniScreen> {
  List<TortaniOrder> listaTortani = [];
  List<TortaniOrder> listaTortaniNonRitirati = [];
  DateTime selectedDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 0, 0);
  bool isSearching = false;
  int totProdotti = 0, totProdRitirati = 0, totProdNonRitirati = 0;
  int totTortani = 0,
      totMezziTortani = 0,
      totPizzeScarole = 0,
      totHalfPizzeScarole = 0,
      totPizzeRipiene = 0,
      totPizzeSalsicce = 0,
      totHalfPizzeSalsicce = 0,
      totRustici = 0;
  int totTortaniRitirati = 0,
      totMezziTortaniRitirati = 0,
      totPizzeScaroleRitirate = 0,
      totHalfPizzeScaroleRitirate = 0,
      totPizzeRipieneRitirate = 0,
      totPizzeSalsicceRitirate = 0,
      totHalfPizzeSalsicceRitirate = 0,
      totRusticiRitirati = 0;
  bool showContent = false;

  TextEditingController controllerSearch = new TextEditingController();

  _contaTortani() {
    listaTortaniNonRitirati.clear();

    totProdotti = 0;
    totProdRitirati = 0;
    totProdNonRitirati = 0;

    totTortani = 0;
    totMezziTortani = 0;
    totPizzeRipiene = 0;
    totPizzeScarole = 0;
    totHalfPizzeScarole = 0;
    totPizzeSalsicce = 0;
    totHalfPizzeSalsicce = 0;
    totRustici = 0;

    totTortaniRitirati = 0;
    totMezziTortaniRitirati = 0;
    totPizzeRipieneRitirate = 0;
    totPizzeScaroleRitirate = 0;
    totHalfPizzeScaroleRitirate = 0;
    totPizzeSalsicceRitirate = 0;
    totHalfPizzeSalsicceRitirate = 0;
    totRusticiRitirati = 0;

    totProdotti = listaTortani.length;

    listaTortani.forEach((tortano) {
      totTortani += tortano.num_tortani;
      totMezziTortani += tortano.num_half_tortani;
      totPizzeRipiene += tortano.num_pizze_ripiene;
      totPizzeScarole += tortano.num_pizze_scarole;
      totHalfPizzeScarole += tortano.num_half_pizze_scarole;
      totPizzeSalsicce += tortano.num_pizze_salsiccie;
      totHalfPizzeSalsicce += tortano.num_half_pizze_salsiccie;
      totRustici += tortano.num_rustici;

      if (tortano.ritirato != null) {
        totTortaniRitirati += tortano.num_tortani;
        totMezziTortaniRitirati += tortano.num_half_tortani;
        totPizzeRipieneRitirate += tortano.num_pizze_ripiene;
        totPizzeScaroleRitirate += tortano.num_pizze_scarole;
        totHalfPizzeScaroleRitirate += tortano.num_half_pizze_scarole;
        totPizzeSalsicceRitirate += tortano.num_pizze_salsiccie;
        totHalfPizzeSalsicceRitirate += tortano.num_half_pizze_salsiccie;
        totRusticiRitirati += tortano.num_rustici;

        totProdRitirati++;
      } else {
        if (tortano.data_ritiro?.compareTo(selectedDate) == 0) {
          listaTortaniNonRitirati.add(tortano);
        }
      }
    });

    totProdNonRitirati = totProdotti - totProdRitirati;

    setState(() {
      listaTortaniNonRitirati = listaTortaniNonRitirati;
    });
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {

    try{
      listaTortani = await TortaniAPIUser.getAllTortani();
    }catch(e){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('C\'è stato un problema nel download degli ordini. Controlla la connessione e riprova.\nErrore: ${e.toString()}'),
              actions: [
                TextButton(
                  child: Text('Capito'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
    }


    setState(() {
      listaTortani = listaTortani;
    });
    _contaTortani();
  }

  Future<void> onRefresh() async {
    _contaTortani();
    setState(() {});
  }

  ///Cerca nel database l'ordine del cliente con approssimazione di %nomeCliente%, ovvero basta che il nome del cliente contenga "nomeCliente"
  _search(String nomeCliente) async {
    if (nomeCliente.compareTo('') != 0) {

      try{
        listaTortani =
        await TortaniAPIUser.searchOrder(nomeCliente.trimRight().trimLeft());
      }catch(e){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Errore'),
                content: Text('C\'è stato un problema nella ricerca degli ordini, controlla la connessione internet e riprova.\n Errore: ${e.toString()}'),
                actions: [
                  TextButton(
                    child: Text('Capito'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            });
      }

      setState(() {
        listaTortani = listaTortani;
      });

      _contaTortani();
    } else {
      _setup();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget productSummary = SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      scrollDirection: Axis.horizontal,
      child: InkWell(
          onTap: () {
            setState(() {
              showContent = !showContent;
            });
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            showContent
                ? Icon(Icons.keyboard_arrow_up)
                : Icon(Icons.keyboard_arrow_down),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Totale prodotti: ' + totProdotti.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  showContent
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Rustici: $totRustici'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Tortani: $totTortani'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Mezzi tortani: $totMezziTortani'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Pizze ripiene: $totPizzeRipiene'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Pizze scarole: $totPizzeScarole'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    'Mezze pizze scarole: $totHalfPizzeScarole'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    'Pizze salsicce e friarielli: $totPizzeSalsicce'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    'Mezze pizze salsicce e friarielli: $totHalfPizzeSalsicce'),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Ritirati: ' + totProdRitirati.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      ),
                    ],
                  ),
                  showContent
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Rustici: $totRusticiRitirati'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Tortani: $totTortaniRitirati'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Mezzi tortani: $totMezziTortaniRitirati'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Pizze ripiene: $totPizzeRipieneRitirate'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Pizze scarole: $totPizzeScaroleRitirate'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    'Mezze pizze scarole: $totHalfPizzeScaroleRitirate'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    'Pizze salsicce e friarielli: $totPizzeSalsicceRitirate'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    'Mezze pizze salsicce e friarielli: $totHalfPizzeSalsicceRitirate'),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Non ritirati: ' + totProdNonRitirati.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                    ],
                  ),
                  showContent
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Rustici: ' +
                                    (totRustici - totRusticiRitirati)
                                        .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Tortani: ' +
                                    (totTortani - totTortaniRitirati)
                                        .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Mezzi tortani: ' +
                                    (totMezziTortani - totMezziTortaniRitirati)
                                        .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Pizze ripiene: ' +
                                    (totPizzeRipiene - totPizzeRipieneRitirate)
                                        .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Pizze scarole: ' +
                                    (totPizzeScarole - totPizzeScaroleRitirate)
                                        .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Mezze pizze scarole: ' +
                                    (totHalfPizzeScarole -
                                            totHalfPizzeScaroleRitirate)
                                        .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Pizze salsicce e friarielli: ' +
                                    (totPizzeSalsicce -
                                            totPizzeSalsicceRitirate)
                                        .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Mezze pizze salsicce e friarielli: ' +
                                    (totHalfPizzeSalsicce -
                                            totHalfPizzeSalsicceRitirate)
                                        .toString()),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ])),
    );

    Widget allProductPage = Center(
      child: RefreshIndicator(
          child: listaTortani.isEmpty
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
                    Text("Sembra non ci sia nessun ordine!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                )
              : Column(
                  children: [
                    productSummary,
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listaTortani.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                listaTortani[index].cliente +
                                    " - " +
                                    (listaTortani[index].ritirato != null
                                        ? "RITIRATO"
                                        : "NON RITIRATO"),
                                style: TextStyle(
                                    color: listaTortani[index].ritirato != null
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              subtitle: listaTortani[index]
                                          .cell_num
                                          .toString()
                                          .compareTo("5555555555") !=
                                      0
                                  ? Text(
                                      listaTortani[index].cell_num.toString())
                                  : Text("Numero non trovato"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () async {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TortaniDetailsScreen(
                                                listaTortani[index])));
                                _search(controllerSearch.text);
                              },
                            );
                          }),
                    ),
                  ],
                ),
          onRefresh: onRefresh),
    );

    Widget notWithdrawedProductPage = Center(
      child: RefreshIndicator(
          child: listaTortaniNonRitirati.isEmpty
              ? Column(
                  children: [
                    Column(children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            DatePicker.showDatePicker(context,
                                minTime: DateTime(2022, 1, 1),
                                onConfirm: (value) {
                              setState(() {
                                setState(() {
                                  selectedDate = DateTime(value.year,
                                      value.month, value.day, 18, 0, 0);
                                  _contaTortani();
                                });
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.it);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today, size: 35),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                    selectedDate.day.toString() +
                                        " - " +
                                        selectedDate.month.toString() +
                                        " - " +
                                        selectedDate.year.toString(),
                                    style: TextStyle(
                                      fontSize: Constants.fontsize,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 2,
                      ),
                    ]),
                    Column(
                      children: [
                        Text(
                            "Nessun ordine del " +
                                selectedDate.day.toString() +
                                " - " +
                                selectedDate.month.toString() +
                                " risulta non ritirato",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    Column(children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            DatePicker.showDatePicker(context,
                                minTime: DateTime(2022, 1, 1),
                                onConfirm: (value) {
                              setState(() {
                                setState(() {
                                  selectedDate = DateTime(value.year,
                                      value.month, value.day, 18, 0, 0);
                                  _contaTortani();
                                });
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.it);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today, size: 35),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                    selectedDate.day.toString() +
                                        " - " +
                                        selectedDate.month.toString() +
                                        " - " +
                                        selectedDate.year.toString(),
                                    style: TextStyle(
                                      fontSize: Constants.fontsize,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 2,
                      ),
                    ]),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listaTortaniNonRitirati.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                listaTortaniNonRitirati[index].cliente +
                                    " - " +
                                    (listaTortaniNonRitirati[index].ritirato !=
                                            null
                                        ? "RITIRATO"
                                        : "NON RITIRATO"),
                                style: TextStyle(
                                    color: listaTortaniNonRitirati[index]
                                                .ritirato !=
                                            null
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              subtitle: listaTortaniNonRitirati[index]
                                          .cell_num
                                          .toString()
                                          .compareTo("5555555555") !=
                                      0
                                  ? Text(listaTortaniNonRitirati[index]
                                      .cell_num
                                      .toString())
                                  : Text("Numero non trovato"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () async {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TortaniDetailsScreen(
                                                listaTortaniNonRitirati[
                                                    index])));
                                _search(controllerSearch.text);
                              },
                            );
                          }),
                    ),
                  ],
                ),
          onRefresh: onRefresh),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Text("Tutti", style: TextStyle(fontSize: 20))),
              Tab(icon: Text("Non Ritirati", style: TextStyle(fontSize: 20))),
            ],
          ),
          title: isSearching
              ? TextField(
                  autofocus: false,
                  controller: controllerSearch,
                  onSubmitted: (nomeCliente) => _search(nomeCliente),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x2B8E8E93),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                )
              : Text("Lista Ordini"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                    controllerSearch.text = "";
                    _search("");
                  });
                },
                icon:
                    Icon(!isSearching ? Icons.search : Icons.cancel_outlined)),
            IconButton(
                onPressed: () {
                  setState(() {
                    DatePicker.showDatePicker(context, minTime: DateTime.now(),
                        onConfirm: (value) {
                      setState(() {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return TortaniListWithDate(selectedDate: value);
                        }));
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.it);
                  });
                },
                icon: Icon(Icons.calendar_today)),
          ],
        ),
        body: TabBarView(
          children: [
            allProductPage,
            notWithdrawedProductPage,
          ],
        ),
        floatingActionButton: SizedBox(
          height: MediaQuery.of(context).size.width / 7,
          width: MediaQuery.of(context).size.width / 7,
          child: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return TortaniAddScreen();
              }));
              _search(controllerSearch.text);
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
