class User {
  String _uid;
  String _name;
  String _phone;
  String _email;
  String _userType;
  String _status;
  String _IBAN;
  var _totalPayment;
  var _rating;
  var _numRequests;
  DateTime _registDate;

  User(
      this._uid,
      this._name,
      this._phone,
      this._email,
      this._userType,
      this._status,
      this._IBAN,
      this._totalPayment,
      this._rating,
      this._numRequests,
      this._registDate);

  // getters and setters
  DateTime get registrDate => _registDate;

  set registrDate(DateTime value) {
    _registDate = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get userType => _userType;

  set userType(String value) {
    _userType = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  get numRequests => _numRequests;

  set numRequests(value) {
    _numRequests = value;
  }

  get rating => _rating;

  set rating(value) {
    _rating = value;
  }

  get totalPayment => _totalPayment;

  set totalPayment(value) {
    _totalPayment = value;
  }

  String get IBAN => _IBAN;

  set IBAN(String value) {
    _IBAN = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }
}
