import 'package:firebase_database/firebase_database.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

class Workshop extends ServiceProvider {

  Workshop(
      String uid,
      DatabaseReference providerRef,
      String name,
      String phone,
      String email,
      String status,
      String IBAN,
      totalPayment,
      rating,
      numRequests,
      DateTime registDate,
      String serviceType,
      commercial,
      String appActivity)
      : super(
            uid,
            providerRef,
            name,
            phone,
            email,
            status,
            IBAN,
            totalPayment,
            rating,
            numRequests,
            registDate,
            serviceType,
            commercial,
            appActivity);
}
