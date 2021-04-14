class Customer {
  String _uid;
  String _name;
  String _phone;
  String _city;
  var _rating;

  Customer(this._uid, this._name, this._phone, this._city, this._rating);

  get rating => _rating;

  set rating(value) {
    _rating = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

// getter and setter


}
