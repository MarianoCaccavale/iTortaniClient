import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:i_tortani_v_2_0/Screens/Tortani/TortaniUpdateScreen.dart';
import 'package:i_tortani_v_2_0/Utils/Models/TortaniOrder.dart';

import '../../Utils/API/Tortani/TortaniAPIUser.dart';

class TortaniDetailsScreen extends StatefulWidget {
  final TortaniOrder ordine;

  TortaniDetailsScreen(this.ordine);

  @override
  State<StatefulWidget> createState() {
    return _TortaniDetailsScreenState();
  }
}

class _TortaniDetailsScreenState extends State<TortaniDetailsScreen> {
  _marcaRitiro(TortaniOrder ordine) async {

    try{
      await TortaniAPIUser.updateOrdineRitirato(ordine);
    }catch(e){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('C\'è stato un problema nel marcare il ritiro dell\'ordine, controlla la connessione internet e riprova.\n Errore: ${e.toString()}'),
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

  @override
  Widget build(BuildContext context) {
    final String htmlData = """<style>
        div {
      font-size: 1.75em;
      width: 100vw;
      font-family: sans-serif;
    text-align: center;
    }
    table {
    width: 100%;
    }
    tbody, thead {
    width: 100%;
    }
    tr {
    width: 100%;
    }
    td {
    width: 80%;
    }
    tr td:first-of-type{
    text-align: right;
    }
    tr td:first-of-type::after{
    content: ':';
    }
    tr td:last-of-type{
    text-align: left;
    }
    </style>
    <div>
    <table>
    <thead>
    <h3>Dettagli ordine</h3>
    </thead>
    <tbody>
    <tr>
    <td>Rustici</td>
    <td>""" +
        widget.ordine.num_rustici.toString() +
        """</td>
    </tr>
    <tr>
    <tr>
    <td>Mezzi Tortani</td>
    <td>""" +
        widget.ordine.num_half_tortani.toString() +
        """</td>
    </tr>
    <tr>
    <td>Tortani interi</td>
    <td>""" +
        widget.ordine.num_tortani.toString() +
        """</td>
    </tr>
    <tr>
    <td>Pizze ripiene</td>
    <td>""" +
        widget.ordine.num_pizze_ripiene.toString() +
        """</td>
    </tr>
    <tr>
    <td>Pizze di scarole</td>
    <td>""" +
        widget.ordine.num_pizze_scarole.toString() +
        """</td>
    </tr>
    <tr>
    <td>Mezze pizze di scarole</td>
    <td>""" +
        widget.ordine.num_half_pizze_scarole.toString() +
        """</td>
    </tr>
    <tr>
    <td>Pizza salsicce e friarelli</td>
    <td>""" +
        widget.ordine.num_pizze_salsiccie.toString() +
        """</td>
    </tr>
    <tr>
    <td>Mezze pizza salsicce e friarelli&nbsp&nbsp&nbsp&nbsp</td>
    <td>""" +
        widget.ordine.num_half_pizze_salsiccie.toString() +
        """</td>
    </tr>
    </tbody>
    </table>""";
    /*final String htmlData = """<div><table>
                <tr><td colspan=3><i>Dettagli ordine</i></td></tr>
                <tr><td>Rustici</td><td>:&nbsp;</td>
                                                <td style = 'text-align:right'>""" +
        widget.ordine.num_rustici.toString() +
        """</td></tr>
                                              <tr>
                                                <td style = 'text-align:left'>Mezzi Tortani </td>
                                                <td>:&nbsp;</td>
                                                <td style = 'text-align:right'>""" +
        widget.ordine.num_half_tortani.toString() +
        """</td>
                                              </tr>
                                              <tr>
                                                <td style = 'text-align:left'>Tortani interi</td>
                                                <td>:&nbsp;</td>
                                                <td style = 'text-align:right'>""" +
        widget.ordine.num_tortani.toString() +
        """</td>
                                              </tr>
                                              <tr>
                                                <td style = 'text-align:left'>Pizze ripiene</td>
                                                <td>:&nbsp;</td>
                                                <td style = 'text-align:right'>""" +
        widget.ordine.num_pizze_ripiene.toString() +
        """</td>
                                              </tr>
                                              <tr>
                                                <td style = 'text-align:left'>Pizze di scarole</td>
                                                <td>:&nbsp;</td>
                                                <td style = 'text-align:right'>""" +
        widget.ordine.num_pizze_scarole.toString() +
        """</td>
                                              </tr>
                                              <tr>
                                                <td style = 'text-align:left'>Mezze pizze di scarole</td>
                                                <td>:&nbsp;</td>
                                                <td style = 'text-align:right'>""" +
        widget.ordine.num_half_pizze_scarole.toString() +
        """</td>
                                              </tr>
                                              <tr>
                                                <td style = 'text-align:left'>Pizza salsicce e friarelli</td>
                                                <td>: </td>
                                                <td style = 'text-align:right'>""" +
        widget.ordine.num_pizze_salsiccie.toString() +
        """</td>
                                              </tr>
                                              <tr>
                                                <td style = 'text-align:left'>Mezze pizza salsicce e friarelli</td>
                                                <td>: </td>
                                                <td style = 'text-align:right'>""" +
        widget.ordine.num_half_pizze_salsiccie.toString() +
        """</td>
                                              </tr>
                                        </table></div>
                                     """;*/

    return Scaffold(
      appBar: AppBar(
        title: Text("Ordine"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Ordine di: " + widget.ordine.cliente,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: widget.ordine.cell_num != 5555555555
                    ? Text(
                        "Numero di Cellulare: " +
                            widget.ordine.cell_num.toString(),
                        style: TextStyle(fontSize: 20))
                    : Text("Numero di Cellulare: non presente",
                        style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("Descrizione", style: TextStyle(fontSize: 20)),
                    widget.ordine.descrizione.isNotEmpty
                        ? Text(widget.ordine.descrizione)
                        : Text("Nessuna descrizione fornita",
                            style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Html(
                    data: htmlData,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("Data ritiro", style: TextStyle(fontSize: 20)),
                    Text(
                      widget.ordine.data_ritiro!.year.toString() +
                          " - " +
                          widget.ordine.data_ritiro!.month.toString() +
                          " - " +
                          widget.ordine.data_ritiro!.day.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: widget.ordine.data_ritiro!
                                      .compareTo(DateTime.now()) <
                                  0
                              ? Colors.red
                              : Colors.green),
                    ),
                  ],
                ),
              ),
              Center(
                child: widget.ordine.ritirato != null
                    ? Text(
                        "RITIRATO il " +
                            widget.ordine.ritirato!.day.toString() +
                            " - " +
                            widget.ordine.ritirato!.month.toString() +
                            " - " +
                            widget.ordine.ritirato!.year.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green))
                    : Text("NON RITIRATO",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 10)),
              child: Text(
                "Marca ritirato",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () => setState(() {
                _marcaRitiro(widget.ordine);
              }),
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(MediaQuery.of(context).size.width / 4,
                        MediaQuery.of(context).size.height / 10)),
                child: Text(
                  "Aggiorna",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return TortaniUpdateScreen(widget.ordine);
                  }));
                  Navigator.of(context).pop();
                }),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 10)),
              child: Text(
                "Elimina",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () async {
                try {
                  await TortaniAPIUser.deleteOrdine(widget.ordine);
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Errore nell'eliminazione dell'ordine"),
                          content: Text(
                              'C\'è stato un problema nell\'eliminazione dell\'ordine. Controlla la connessione internet e riprova)'),
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
