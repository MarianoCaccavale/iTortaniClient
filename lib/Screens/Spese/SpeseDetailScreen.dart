import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_tortani_v_2_0/Utils/DB/Spese/SpeseDBUser.dart';
import 'package:i_tortani_v_2_0/Utils/Models/Entity/SpeseOrder.dart';

import '../../Utils/API/Spese/SpeseAPIUser.dart';
import 'SpeseUpdateScreen.dart';

class SpeseDetailScreen extends StatefulWidget {
  final SpeseOrder spesa;

  SpeseDetailScreen(this.spesa);

  @override
  State<StatefulWidget> createState() {
    return _SpeseDetailScreen();
  }
}

class _SpeseDetailScreen extends State<SpeseDetailScreen> {
  _marcaRitiro(SpeseOrder spesa) async {
    try{
      await SpeseAPIUser.updateSpesaRitiro(spesa);
    }catch(e){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('C\'è stato un problema nell\'aggiornamento della spesa, controlla la connessione internet e riprova.\n Errore: ${e.toString()}'),
              actions: [
                TextButton(
                  child: Text('Capito'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dettagli spesa"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text("Cliente",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Text(widget.spesa.cliente,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
            ),
            /*Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Numero di telefono",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Text(
                      widget.spesa.cell_num == 5555555555
                          ? "numero non trovato"
                          : widget.spesa.cell_num.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
            ),*/
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("Descrizione spesa",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Text(widget.spesa.descrizione,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("Luogo di conservazione",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Text(widget.spesa.luogo,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                      "Il cliente potrebbe aver ordinato anche dei tortani? " +
                          (widget.spesa.check_tortani ? "SI" : "NO"),
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Data di ritiro",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Text(
                      widget.spesa.data_ritiro!.day.toString() +
                          " - " +
                          widget.spesa.data_ritiro!.month.toString() +
                          " - " +
                          widget.spesa.data_ritiro!.year.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  widget.spesa.ritirato != null
                      ? Text(
                          "RITIRATO il " +
                              widget.spesa.ritirato!.day.toString() +
                              " - " +
                              widget.spesa.ritirato!.month.toString() +
                              " - " +
                              widget.spesa.ritirato!.year.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green))
                      : Text("NON RITIRATO",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text(
                "Marca ritirato",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 10)),
              onPressed: () => setState(() {
                _marcaRitiro(widget.spesa);
              }),
            ),
            TextButton(
                child: Text(
                  "Aggiorna",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(MediaQuery.of(context).size.width / 4,
                        MediaQuery.of(context).size.height / 10)),
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SpeseUpdateScreen(widget.spesa);
                  }));
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: Text(
                "Elimina",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 10)),
              onPressed: () async {
                try {
                  await SpeseAPIUser.deleteSpesa(widget.spesa);
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Errore nell'eliminazione della spesa"),
                          content: Text(
                              'C\'è stato un problema nell\'eliminazione della spesa, riprovare tra qualche minuto)'),
                          actions: [
                            TextButton(
                              child: Text('Capito'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
