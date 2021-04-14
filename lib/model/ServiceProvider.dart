
import 'package:firebase_database/firebase_database.dart';
import 'package:service_provider_app/model/User.dart';

class ServiceProvider extends User {
  String _serviceType;
  var _commercial;
  String _appActivity = "inactive";
  DatabaseReference _providerRef;

  ServiceProvider(
      String uid,
      this._providerRef,
      String name,
      String phone,
      String email,
      String status,
      String IBAN,
      totalPayment,
      rating,
      numRequests,
      DateTime registDate,
      this._serviceType,
      this._commercial, this._appActivity)
      : super(uid, name, phone, email, "Service Provider", status, IBAN,
            totalPayment, rating, numRequests, registDate);

  updateAppActivity(var newActivity) {
    this._providerRef.update({_appActivity: newActivity});
  }

  updateProvider(var phone, var email, var iban, var commercial) {
    this.phone = phone;
    this.email = email;
    this.IBAN = iban;
    this._commercial = commercial;
    return _updateRef();
  }

  bool _updateRef() {
    try {

      providerRef.update({
        'phone': this.phone,
        'email': this.email,
        'IBAN': this.IBAN,
        'commercial': this.commercial
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // getters and setters
  DatabaseReference get providerRef => _providerRef;

  set providerRef(DatabaseReference value) {
    _providerRef = value;
  }

  String get appActivity => _appActivity;

  set appActivity(String value) {
    _appActivity = value;
  }

  get commercial => _commercial;

  set commercial(value) {
    _commercial = value;
  }

  String get serviceType => _serviceType;

  set serviceType(String value) {
    _serviceType = value;
  }
}
