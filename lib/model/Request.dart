import 'Bill.dart';
import 'Customer.dart';

class Request {
  String _uid;
  String _requestNo;
  Bill _bill;
  String _car;
  Customer _customer;
  String _details;
  bool _isAccepted;
  String _progress;
  DateTime _requestDate;
  String _status;
  var latitude;
  var longitude;

  Request(
      this._uid,
      this._requestNo,
      this._car,
      this._details,
      this._isAccepted,
      this._progress,
      this._requestDate,
      this._status,
      this.latitude,
      this.longitude);

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  DateTime get requestDate => _requestDate;

  set requestDate(DateTime value) {
    _requestDate = value;
  }

  String get progress => _progress;

  set progress(String value) {
    _progress = value;
  }

  bool get isAccepted => _isAccepted;

  set isAccepted(bool value) {
    _isAccepted = value;
  }

  String get details => _details;

  set details(String value) {
    _details = value;
  }

  Customer get customer => _customer;

  set customer(Customer value) {
    _customer = value;
  }

  String get car => _car;

  set car(String value) {
    _car = value;
  }

  Bill get bill => _bill;

  set bill(Bill value) {
    _bill = value;
  }

  String get requestNo => _requestNo;

  set requestNo(String value) {
    _requestNo = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

// getter and setter

}
