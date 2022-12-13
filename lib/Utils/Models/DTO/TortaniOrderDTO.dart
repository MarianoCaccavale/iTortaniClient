class TortaniOrderDTO{
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

  TortaniOrderDTO(
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
      "Cliente": this.cliente,
      "NumHalfTortani": this.num_half_tortani,
      "NumTortani": this.num_tortani,
      "NumPizzeRipiene": this.num_pizze_ripiene,
      "NumPizzeScarole": this.num_pizze_scarole,
      "NumHalfPizzeScarole": this.num_half_pizze_scarole,
      "NumPizzeSalsiccie": this.num_pizze_salsiccie,
      "NumHalfPizzeSalsiccie": this.num_half_pizze_salsiccie,
      "NumRustici": this.num_rustici,
      "Description": this.descrizione,
      "CellNum": this.cell_num,
      "DataRitiro": this.data_ritiro.toString().split(" ").first,
      "Ritirato": this.ritirato != null ? this.ritirato.toString() : '',
    };
  }

  factory TortaniOrderDTO.fromJson(Map<String, dynamic> json) {
    return TortaniOrderDTO(
      json['id'] ?? 0,
      json['cliente'],
      json['numHalfTortani'],
      json['numTortani'],
      json['numPizzeRipiene'],
      json['numPizzeScarole'],
      json['numHalfPizzeScarole'],
      json['numPizzeSalsiccie'],
      json['numHalfPizzeSalsiccie'],
      json['numRustici'],
      json['description'],
      DateTime.parse(json['dataRitiro']),
      cell_num: json['cellNum'],
      ritirato:
      json['ritirato'] == "" ? null : DateTime.parse(json['ritirato']),
    );
  }
}