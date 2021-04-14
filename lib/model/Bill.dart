class Bill {
  String _uid;
  var _billNo;
  String _describtion;
  var _amount;
  bool _isPaid;
  DateTime _payDate;

  Bill(this._uid, this._billNo, this._describtion, this._amount, this._isPaid,
      this._payDate);

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  } // getters and setters

  DateTime get payDate => _payDate;

  set payDate(DateTime value) {
    _payDate = value;
  }

  bool get isPaid => _isPaid;

  set isPaid(bool value) {
    _isPaid = value;
  }

  get amount => _amount;

  set amount(value) {
    _amount = value;
  }

  String get describtion => _describtion;

  set describtion(String value) {
    _describtion = value;
  }

  get billNo => _billNo;

  set billNo(value) {
    _billNo = value;
  }

  @override
  String toString() {
    return 'Bill{_uid: $_uid, _billNo: $_billNo, _describtion: $_describtion, _amount: $_amount, _isPaid: $_isPaid, _payDate: $_payDate}';
  }
}
