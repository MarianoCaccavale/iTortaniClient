class SpeseOrder {
  int id = 0;
  String cliente = '';
  int cell_num = 5555555555;
  String descrizione = '';
  String luogo = '';
  bool check_tortani = false;
  DateTime? data_ritiro;
  DateTime? ritirato;

  SpeseOrder(this.id, this.cliente, this.cell_num, this.descrizione, this.luogo,
      this.check_tortani, this.data_ritiro,
      {this.ritirato});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'cliente': this.cliente,
      'cell_num': this.cell_num,
      'descrizione': this.descrizione,
      'luogo': this.luogo,
      'check_tortani': this.check_tortani ? 1 : 0,
      'data_ritiro': this.data_ritiro.toString(),
      'ritirato': this.ritirato.toString(),
    };
  }

  factory SpeseOrder.FromJson(Map<String, dynamic> json) {
    return SpeseOrder(
      json['id'] ?? 0,
      json['cliente'],
      json['cell_num'],
      json['descrizione'],
      json['luogo'],
      json['check_tortani'] == 0 ? false : true,
      DateTime.parse(json['data_ritiro']),
      ritirato: json['ritirato'] == "" || json['ritirato'] == "null"
          ? null
          : DateTime.parse(json['ritirato']),
    );
  }
}
