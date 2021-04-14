class Complaint {

  String _uid;
  String _complaintNo;
  String _details;
  DateTime _complaintDate;
  bool _isRespond;
  String _requestNo;
  String _status;
  String _type;
  String _response;

  Complaint(this._uid, this._complaintNo, this._details,this._complaintDate,this._isRespond,
      this._requestNo, this._status, this._type, this._response);

  // getter and setter

  String get response => _response;

  set response(String value) {
    _response = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get requestNo => _requestNo;

  set requestNo(String value) {
    _requestNo = value;
  }

  bool get isRespond => _isRespond;

  set isRespond(bool value) {
    _isRespond = value;
  }

  String get details => _details;

  set details(String value) {
    _details = value;
  }

  String get complaintNo => _complaintNo;

  set complaintNo(String value) {
    _complaintNo = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  DateTime get complaintDate => _complaintDate;

  set complaintDate(DateTime value) {
    _complaintDate = value;
  }
}
