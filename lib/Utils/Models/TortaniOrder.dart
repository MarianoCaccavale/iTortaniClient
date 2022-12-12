class TortaniOrder {
  int idOrdine = 0;
  String cliente = '';
  int num_half_tortani = 0;
  int num_tortani = 0;
  int num_pizze_ripiene = 0;
  int num_pizze_scarole = 0;
  int num_half_pizze_scarole = 0;
  int num_pizze_salsiccie = 0;
  int num_half_pizze_salsiccie = 0;
  int num_rustici = 0;
  String descrizione = '';
  int cell_num = 0;
  DateTime? data_ritiro;
  DateTime? ritirato;

  TortaniOrder(
      this.idOrdine,
      this.cliente,
      this.num_half_tortani,
      this.num_tortani,
      this.num_pizze_ripiene,
      this.num_pizze_scarole,
      this.num_half_pizze_scarole,
      this.num_pizze_salsiccie,
      this.num_half_pizze_salsiccie,
      this.num_rustici,
      this.descrizione,
      this.data_ritiro,
      {int cell_num = 5555555555,
      ritirato}) {
    this.cell_num = cell_num;
    this.ritirato = ritirato;
  }

  Map<String, dynamic> toJson() {
    return {
      "cliente": this.cliente,
      "num_half_tortani": this.num_half_tortani,
      "num_tortani": this.num_tortani,
      "num_pizze_ripiene": this.num_pizze_ripiene,
      "num_pizze_scarole": this.num_pizze_scarole,
      "num_half_pizze_scarole": this.num_half_pizze_scarole,
      "num_pizze_salsicce": this.num_pizze_salsiccie,
      "num_half_pizze_salsicce": this.num_half_pizze_salsiccie,
      "num_rustici": this.num_rustici,
      "descrizione": this.descrizione,
      "cell_num": this.cell_num,
      "data_ritiro": this.data_ritiro.toString().split(" ").first,
      "ritirato": this.ritirato != null ? this.ritirato.toString() : '',
    };
  }

  factory TortaniOrder.fromJson(Map<String, dynamic> json) {
    return TortaniOrder(
      json['id'] ?? 0,
      json['cliente'],
      json['num_half_tortani'],
      json['num_tortani'],
      json['num_pizze_ripiene'],
      json['num_pizze_scarole'],
      json['num_half_pizze_scarole'],
      json['num_pizze_salsicce'],
      json['num_half_pizze_salsicce'],
      json['num_rustici'],
      json['descrizione'],
      DateTime.parse(json['data_ritiro']),
      cell_num: json['cell_num'],
      ritirato:
          json['ritirato'] == "" ? null : DateTime.parse(json['ritirato']),
    );
  }
}
