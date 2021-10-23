



class TipoForForm {
  int id;
  String tipoSigla;
  String tipoNome;

  TipoForForm(this.id, this.tipoSigla, this.tipoNome);

  static List<String> getTipo() {
    return <String> [
      'IND', 'MOC', 'PL.', 'EME', 'MSG', 'OF.',
      'PRS', 'PDL', 'PLC', 'REQ', 'REP', 'PEC', 'RES',
    ];
  }
}