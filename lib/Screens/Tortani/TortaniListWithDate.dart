import 'package:flutter/material.dart';
import 'package:i_tortani_v_2_0/Utils/DB/Tortani/TortaniDBUser.dart';

import '../../Utils/Models/TortaniOrder.dart';

class TortaniListWithDate extends StatefulWidget {
  final DateTime selectedDate;

  const TortaniListWithDate({Key? key, required this.selectedDate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TortaniListWithDateState();
  }
}

class TortaniListWithDateState extends State<TortaniListWithDate> {
  int totProdotti = 0, totProdRitirati = 0, totProdNonRitirati = 0;
  int totTortani = 0,
      totMezziTortani = 0,
      totPizzeScarole = 0,
      totHalfPizzeScarole = 0,
      totPizzeRipiene = 0,
      totPizzeSalsicce = 0,
      totHalfPizzeSalsicce = 0, totRustici = 0;
  int totTortaniRitirati = 0,
      totMezziTortaniRitirati = 0,
      totPizzeScaroleRitirate = 0,
      totHalfPizzeScaroleRitirate = 0,
      totPizzeRipieneRitirate = 0,
      totPizzeSalsicceRitirate = 0,
      totHalfPizzeSalsicceRitirate = 0, totRusticiRitirati = 0;

  late List<TortaniOrder> tortaniOfThisDay;

  void _setup() async {
    tortaniOfThisDay =
        await TortaniDBUser.getTortaniFromDate(widget.selectedDate);

    setState(() {
      tortaniOfThisDay = tortaniOfThisDay;
    });

    _contaTortani();
  }

  _contaTortani() {
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

    totProdotti = tortaniOfThisDay.length;

    tortaniOfThisDay.forEach((tortano) {
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
      }
    });

    totProdNonRitirati = totProdotti - totProdRitirati;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Ordini del ${widget.selectedDate.toString().split(" ").first}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Totale ordini: ' + totProdotti.toString(),
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Rustici: $totRustici',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Tortani: $totTortani',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Mezzi tortani: $totMezziTortani',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Pizze ripiene: $totPizzeRipiene',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Pizze scarole: $totPizzeScarole',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Mezze pizze scarole: $totHalfPizzeScarole',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Pizze salsicce e friarielli: $totPizzeSalsicce',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Mezze pizze salsicce e friarielli: $totHalfPizzeSalsicce',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 2),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Ritirati: ' + totProdRitirati.toString(),
                        style: TextStyle(fontSize: 25, color: Colors.green),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Rustici: $totRusticiRitirati',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Tortani: $totTortaniRitirati',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Mezzi tortani: $totMezziTortaniRitirati',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Pizze ripiene: $totPizzeRipieneRitirate',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Pizze scarole: $totPizzeScaroleRitirate',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Mezze pizze scarole: $totHalfPizzeScaroleRitirate',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              'Pizze salsicce e friarielli: $totPizzeSalsicceRitirate',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              'Mezze pizze salsicce e friarielli: $totHalfPizzeSalsicceRitirate',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 2),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Non ritirati: ' + totProdNonRitirati.toString(),
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              'Rustici: ' +
                                  (totRustici - totRusticiRitirati).toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              'Tortani: ' +
                                  (totTortani - totTortaniRitirati).toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              'Mezzi tortani: ' +
                                  (totMezziTortani - totMezziTortaniRitirati)
                                      .toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              'Pizze ripiene: ' +
                                  (totPizzeRipiene - totPizzeRipieneRitirate)
                                      .toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              'Pizze scarole: ' +
                                  (totPizzeScarole - totPizzeScaroleRitirate)
                                      .toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              'Mezze pizze scarole: ' +
                                  (totHalfPizzeScarole - totHalfPizzeScaroleRitirate)
                                      .toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              'Pizze salsicce e friarielli: ' +
                                  (totPizzeSalsicce - totPizzeSalsicceRitirate)
                                      .toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              'Mezze pizze salsicce e friarielli: ' +
                                  (totHalfPizzeSalsicce - totHalfPizzeSalsicceRitirate)
                                      .toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
