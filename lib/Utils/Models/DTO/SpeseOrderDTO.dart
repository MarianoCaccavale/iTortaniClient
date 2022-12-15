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
      'CheckTortani': this.check_tortani,
      'DataRitiro': this.data_ritiro.toString().split(" ").first,
      "Ritirato": this.ritirato != null ? this.ritirato.toString().split(" ").first : null,
    };
  }

  factory SpeseOrderDTO.FromJson(Map<String, dynamic> json) {
    return SpeseOrderDTO(
      json['id'] ?? 0,
      json['cliente'],
      json['cellNum'],
      json['descrizione'],
      json['luogo'],
      json['checkTortani'],
      DateTime.parse(json['dataRitiro']),
      ritirato: json['ritirato'] == "" || json['ritirato'] == "null" || json['ritirato'] == null
          ? null
          : DateTime.parse(json['ritirato']),
    );
  }
}