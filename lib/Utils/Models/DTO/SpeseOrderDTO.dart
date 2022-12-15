class SpeseOrderDTO {
  int id = 0;
  String cliente = '';
  int cell_num = 5555555555;
  String descrizione = '';
  String luogo = '';
  bool check_tortani = false;
  DateTime? data_ritiro;
  DateTime? ritirato;

  SpeseOrderDTO(this.id, this.cliente, this.cell_num, this.descrizione, this.luogo,
      this.check_tortani, this.data_ritiro,
      {this.ritirato});

  Map<String, dynamic> toJson() {
    return {
      'Id': this.id,
      'Cliente': this.cliente,
      'CellNum': this.cell_num,
      'Descrizione': this.descrizione,
      'Luogo': this.luogo,
      'CheckTortani': this.check_tortani ? 1 : 0,
      'DataRitiro': this.data_ritiro.toString(),
      //'Ritirato': this.ritirato.toString(),
      "Ritirato": this.ritirato != null ? this.ritirato.toString().split(" ").first : null,
    };
  }

  factory SpeseOrderDTO.FromJson(Map<String, dynamic> json) {
    return SpeseOrderDTO(
      json['Id'] ?? 0,
      json['Cliente'],
      json['CellNum'],
      json['Descrizione'],
      json['Luogo'],
      json['CheckTortani'] == 0 ? false : true,
      DateTime.parse(json['DataRitiro']),
      ritirato: json['Ritirato'] == "" || json['Ritirato'] == "null" || json['Ritirato'] == null
          ? null
          : DateTime.parse(json['Ritirato']),
    );
  }
}