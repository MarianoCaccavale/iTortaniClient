import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:i_tortani_v_2_0/Utils/Models/Entity/TortaniOrder.dart';

import '../../Utils/API/Tortani/TortaniAPIUser.dart';

class TortaniAddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TortaniAddScreenState();
  }
}

class _TortaniAddScreenState extends State<TortaniAddScreen> {
  String cliente = '';
  int num_half_tortani = 0;
  int num_tortani = 0;
  int num_pizze_ripiene = 0;
  int num_pizze_scarole = 0;
  int num_half_pizze_scarole = 0;
  int num_pizze_salsicce = 0;
  int num_half_pizze_salsicce = 0;
  int num_rustici = 0;
  String descrizione = '';
  int cell_num = 5555555555;
  DateTime? data_ritiro = null;

  _addHalfTortani() {
    setState(() {
      ++num_half_tortani;
    });
  }

  _removeHalfTortani() {
    setState(() {
      num_half_tortani > 0
          ? --num_half_tortani
          : num_half_tortani = num_half_tortani;
    });
  }

  _addTortani() {
    setState(() {
      ++num_tortani;
    });
  }

  _removeTortani() {
    setState(() {
      num_tortani > 0 ? --num_tortani : num_tortani = num_tortani;
    });
  }

  _addPizzeRipiene() {
    setState(() {
      ++num_pizze_ripiene;
    });
  }

  _removePizzeRipiene() {
    setState(() {
      num_pizze_ripiene > 0
          ? --num_pizze_ripiene
          : num_pizze_ripiene = num_pizze_ripiene;
    });
  }

  _addPizzeScarole() {
    setState(() {
      ++num_pizze_scarole;
    });
  }

  _removePizzeScarole() {
    setState(() {
      num_pizze_scarole > 0
          ? --num_pizze_scarole
          : num_pizze_scarole = num_pizze_scarole;
    });
  }

  _addHalfPizzeScarole() {
    setState(() {
      ++num_half_pizze_scarole;
    });
  }

  _removeHalfPizzeScarole() {
    setState(() {
      num_half_pizze_scarole > 0
          ? --num_half_pizze_scarole
          : num_half_pizze_scarole = num_half_pizze_scarole;
    });
  }

  _addPizzeSalsicce() {
    setState(() {
      ++num_pizze_salsicce;
    });
  }

  _removePizzeSalsicce() {
    setState(() {
      num_pizze_salsicce > 0
          ? --num_pizze_salsicce
          : num_pizze_salsicce = num_pizze_salsicce;
    });
  }

  _addHalfPizzeSalsicce() {
    setState(() {
      ++num_half_pizze_salsicce;
    });
  }

  _removeHalfPizzeSalsicce() {
    setState(() {
      num_half_pizze_salsicce > 0
          ? --num_half_pizze_salsicce
          : num_half_pizze_salsicce = num_half_pizze_salsicce;
    });
  }

  _addRustico() {
    setState(() {
      ++num_rustici;
    });
  }

  _removeRustico() {
    setState(() {
      num_rustici > 0 ? --num_rustici : num_rustici = num_rustici;
    });
  }

  bool _checkOrdine() {
    bool isOK = true;

    if (cliente.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('Il nome del cliente non pu?? essere vuoto'),
              actions: [
                TextButton(
                  child: Text('Capito'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
      isOK = false;
    } else if (num_half_tortani +
            num_tortani +
            num_pizze_scarole +
            num_half_pizze_scarole +
            num_pizze_ripiene +
            num_pizze_salsicce +
            num_half_pizze_salsicce +
            num_rustici ==
        0) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('Un cliente deve ordinare almeno un prodotto'),
              actions: [
                TextButton(
                  child: Text('Capito'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
      isOK = false;
    } else if (data_ritiro == null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('La data di ritiro ?? sbagliata, ricontrollala'),
              actions: [
                TextButton(
                  child: Text('Capito'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
      isOK = false;
    } else if (cell_num == 5555555555) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('Inserire il numero di cellulare del cliente'),
              actions: [
                TextButton(
                  child: Text('Capito'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
      isOK = false;
    }

    return isOK;
  }

  _confirmOrdine() async {
    if (_checkOrdine()) {
      try {
        var order = TortaniOrder.fromJson({
          'id': 0,
          'cliente': cliente,
          'num_half_tortani': num_half_tortani,
          'num_tortani': num_tortani,
          'num_pizze_ripiene': num_pizze_ripiene,
          'num_pizze_scarole': num_pizze_scarole,
          'num_half_pizze_scarole': num_half_pizze_scarole,
          'num_pizze_salsicce': num_pizze_salsicce,
          'num_half_pizze_salsicce': num_half_pizze_salsicce,
          'num_rustici': num_rustici,
          'descrizione': descrizione,
          'cell_num': cell_num,
          'data_ritiro': data_ritiro.toString(),
          'ritirato': '',
        });

        try{
          await TortaniAPIUser.insertOrdine(order);
        }catch(e){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Errore'),
                  content: Text('C\'?? stato un problema nell\'inserimento dell\'ordine, controlla la connessione internet e riprova.\n Errore: ${e.toString()}'),
                  actions: [
                    TextButton(
                      child: Text('Capito'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        },
                    ),
                  ],
                );
              });
        }

        Navigator.of(context).pop();

      } catch (e) {
        print(e);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Errore'),
                content: Text(
                    'C\'?? stato un problema nella conferma dell\'ordine, controlla i dati e riprova'),
                actions: [
                  TextButton(
                    child: Text('Capito'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crea ordine"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Text('Inserire nome del cliente(*)',
                          style: TextStyle(fontSize: 20)),
                      TextField(
                        autofocus: false,
                        onChanged: (value) => cliente = value,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Rustici', style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: _addRustico,
                              ),
                              Text(num_rustici.toString()),
                              IconButton(
                                onPressed: _removeRustico,
                                icon: Icon(Icons.remove_circle),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Mezzi Tortani', style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: _addHalfTortani,
                              ),
                              Text(num_half_tortani.toString()),
                              IconButton(
                                onPressed: _removeHalfTortani,
                                icon: Icon(Icons.remove_circle),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Tortani interi',
                              style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: _addTortani,
                              ),
                              Text(num_tortani.toString()),
                              IconButton(
                                onPressed: _removeTortani,
                                icon: Icon(Icons.remove_circle),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Pizze ripiene', style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: _addPizzeRipiene,
                              ),
                              Text(num_pizze_ripiene.toString()),
                              IconButton(
                                onPressed: _removePizzeRipiene,
                                icon: Icon(Icons.remove_circle),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Pizze di scarole',
                              style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: _addPizzeScarole,
                              ),
                              Text(num_pizze_scarole.toString()),
                              IconButton(
                                onPressed: _removePizzeScarole,
                                icon: Icon(Icons.remove_circle),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Mezze pizze di scarole',
                              style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: _addHalfPizzeScarole,
                              ),
                              Text(num_half_pizze_scarole.toString()),
                              IconButton(
                                onPressed: _removeHalfPizzeScarole,
                                icon: Icon(Icons.remove_circle),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Pizze salsicce e friggiarelli',
                              style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: _addPizzeSalsicce,
                              ),
                              Text(num_pizze_salsicce.toString()),
                              IconButton(
                                onPressed: _removePizzeSalsicce,
                                icon: Icon(Icons.remove_circle),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Mezze pizze salsicce e friggiarelli',
                              style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: _addHalfPizzeSalsicce,
                              ),
                              Text(num_half_pizze_salsicce.toString()),
                              IconButton(
                                onPressed: _removeHalfPizzeSalsicce,
                                icon: Icon(Icons.remove_circle),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.blueGrey,
                      ),
                      Text('Descrizione', style: TextStyle(fontSize: 20)),
                      TextField(
                        autofocus: false,
                        onChanged: (newDescrizione) =>
                            descrizione = newDescrizione,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Numero di telefono(*)',
                          style: TextStyle(fontSize: 20)),
                      TextField(
                        autofocus: false,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) => cell_num = int.parse(value),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text('Data ritiro(*): ',
                                  style: TextStyle(fontSize: 20)),
                              data_ritiro != null
                                  ? Text(
                                      data_ritiro!.day.toString() +
                                          '-' +
                                          data_ritiro!.month.toString() +
                                          '-' +
                                          data_ritiro!.year.toString(),
                                      style: TextStyle(fontSize: 20))
                                  : Text(''),
                            ],
                          ),
                          IconButton(
                              icon: Icon(Icons.calendar_today_outlined),
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    minTime: DateTime.now(),
                                    onConfirm: (value) {
                                  setState(() {
                                    //Imposto la data al giorno del ritiro, ma imposto custom l'ora alle 16. Questo mi permette successivamente
                                    //di controllare automaticamente gli ordini non ritirati entro le 18
                                    data_ritiro = DateTime(value.year,
                                        value.month, value.day, 18, 0);
                                    print(data_ritiro);
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.it);

                                FocusScope.of(context).unfocus();
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: Size(MediaQuery.of(context).size.width / 2,
                              MediaQuery.of(context).size.height / 10)),
                      child: Text(
                        "Conferma ordine",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      onPressed: _confirmOrdine,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
