class RestEndpoints {
  // static final _root = 'https://localhost:7023/api/';
  static final _root = 'https://192.168.1.7:7023/api/';

  static final _tortaniController = "Order/";
  static final tortaniDeleteAll = _root + _tortaniController + "delete_all";
  static final tortaniInsertOrder = _root + _tortaniController + "insert_order";
  static final tortaniUpdateOrderRitirato = _root + _tortaniController + 'update_order';
  static final tortaniUpdateOrdine = _root + _tortaniController + 'update_order';
  static final tortaniDeleteOrdine = _root + _tortaniController + 'delete_order';
  static final tortaniGetAllTortani = _root + _tortaniController + 'get_orders';
  static final tortaniSearchOrder = _root + _tortaniController + 'search_order';
  static final tortaniGetTortaniFromDate = _root + _tortaniController + 'search_order_by_date';

  static final _speseController = "Spese/";
  static final speseDeleteAll = _root + _speseController + "delete_all";
  static final speseInsertOrder = _root + _speseController + "insert_spesa";
  static final speseUpdateOrderRitirato = _root + _speseController + 'update_spesa';
  static final speseUpdateOrdine = _root + _speseController + 'update_spesa';
  static final speseDeleteOrdine = _root + _speseController + 'delete_spesa';
  static final speseGetAllSpese = _root + _speseController + 'get_spese';
  static final speseSearchOrder = _root + _speseController + 'search_spesa';
  static final speseGetTortaniFromDate = _root + _speseController + 'search_spese_by_date';
}
