import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:i_tortani_v_2_0/Utils/DB/Spese/SpeseDBUser.dart';
import 'package:i_tortani_v_2_0/Utils/Models/Entity/SpeseOrder.dart';

import '../../Utils/API/Spese/SpeseAPIUser.dart';

class SpeseAddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpeseAddScreenState();
  }
}

class _SpeseAddScreenState extends State<SpeseAddScreen> {
  String cliente = '';
  String descrizione = '';
  int cell_num = 5555555555;
  String luogo = '';
  bool checkTortani = false;
  DateTime? data_ritiro = null;

  bool _checkSpesa() {
    bool isOK = true;

    if (cliente.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('Il nome del cliente non può essere vuoto'),
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
              content: Text('La data di ritiro è sbagliata, ricontrollala'),
              actions: [
                TextButton(
                  child: Text('Capito'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
      isOK = false;
    } else if (luogo.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('Specificare dove si trova la spesa'),
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

  _confirmSpesa() async {
    if (_checkSpesa()) {
      try {
        print(data_ritiro.toString());
        var spesa = SpeseOrder.FromJson({
          'cliente': cliente,
          'descrizione': descrizione,
          'cell_num': cell_num,
          'luogo': luogo,
          'check_tortani': checkTortani ? 1 : 0,
          'data_ritiro': data_ritiro.toString(),
          'ritirato': '',
        });

        try{
          await SpeseAPIUser.insertSpese(spesa);
        }catch(e){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Errore'),
                  content: Text('C\'è stato un problema nell\'inserimento della spesa, controlla la connessione internet e riprova.\n Errore: ${e.toString()}'),
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
      } catch (e) {
        print(e);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Errore'),
                content: Text(
                    'C\'è stato un problema nella conferma della spesa, controlla i dati e riprova'),
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
        title: Text("Crea spesa"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Inserire nome del cliente(*)',
                      style: TextStyle(fontSize: 20)),
                  TextField(
                    onChanged: (value) => cliente = value,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Descrizione', style: TextStyle(fontSize: 20)),
                  TextField(
                    onChanged: (value) => descrizione = value,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Dove è conservata la spesa(*)',
                      style: TextStyle(fontSize: 20)),
                  TextField(
                    onChanged: (value) => luogo = value,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Il cliente ordine anche dei tortani/pizze?',
                      style: TextStyle(fontSize: 20)),
                  Checkbox(
                      value: checkTortani,
                      onChanged: (value) {
                        setState(() {
                          checkTortani = !checkTortani;
                        });
                      })
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text('Data ritiro:(*)', style: TextStyle(fontSize: 20)),
                    data_ritiro != null
                        ? Text(data_ritiro!.day.toString() +
                            '-' +
                            data_ritiro!.month.toString() +
                            '-' +
                            data_ritiro!.year.toString())
                        : Text(''),
                  ],
                ),
                IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          minTime: DateTime.now(), onConfirm: (value) {
                        setState(() {
                          data_ritiro = value;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.it);
                    }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 30),
            child: TextButton(
              child: Text("Conferma spesa",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.height / 10)),
              onPressed: _confirmSpesa,
            ),
          ),
        ],
      ),
    );
  }
}
