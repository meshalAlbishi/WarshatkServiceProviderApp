import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider_app/model/Workshop.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/constant/ProgressDialog.dart';
import 'package:service_provider_app/screen/mainPage/main_screen.dart';

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  ServiceProvider sp;

  // controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // to give space between fields
          SizedBox(
            height: size.height * 0.01,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              "Please Login",
              style: TextStyle(fontSize: 24),
            ),
          ),

          // to give space between fields
          SizedBox(
            height: size.height * 0.03,
          ),

          // email text filed
          createTextField(
              Icons.email_outlined, "Email", _emailController, false),

          // to give space between fields
          SizedBox(
            height: size.height * 0.04,
          ),

          // password filed
          createTextField(
              Icons.lock_outline, "Password", _passwordController, true),

          // to give space between fields
          SizedBox(
            height: size.height * 0.02,
          ),

          InkWell(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "Forget Password?",
                    style: linkStyle(),
                  ),
                ],
              ),
            ),
            onTap: () {
              if (_emailController.text.isEmpty) {
                showSnackBar("Please enter your email and press again", context,
                    Colors.lightBlue);
              } else {
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: _emailController.text.trim())
                    .then((value) {
                  showSnackBar(
                      "Check your email please", context, Colors.green);
                });
              }
            },
          ),

          // to give space between fields
          // to give space between fields
          SizedBox(
            height: size.height * 0.03,
          ),

          InkWell(
            onTap: () async {
              _loginButton(context);
            },
            child: Material(
              elevation: 10.0,
              color: mainBtnColor,
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                width: size.height,
                height: size.height * 0.07,
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // create the text field
  Material createTextField(IconData icon, String placeholder,
      TextEditingController controller, bool isPassword) {
    return Material(
      elevation: 10.0,
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        // autofocus: true,
        decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(
                vertical: appPadding * 0.75, horizontal: appPadding),
            fillColor: Colors.white,
            hintText: placeholder,
            suffixIcon: Icon(
              icon,
              size: 25.0,
              color: Colors.black.withOpacity(0.4),
            )),
      ),
    );
  }

  // styling text for (forget pass, not register
  TextStyle linkStyle() {
    return TextStyle(
      fontSize: 18,
      color: Colors.black.withOpacity(0.5),
    );
  }

  void _loginButton(context) async {
    // check internet connection
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.mobile &&
        connectivity != ConnectivityResult.wifi) {
      showSnackBar("No internet connectivity!", context, mainBackGround);
      return;
    }

    // check fields if empty
    if (!_checkFields(context)) {
      showSnackBar(
          "email or password can not be empty!", context, mainBackGround);
      return;
    }

    // check if register before or not
    _loginFirebase();
  }

  void clearFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  bool _checkFields(BuildContext context) {
    return !(_emailController.text.isEmpty || _passwordController.text.isEmpty);
  }

  _loginFirebase() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "LOGIN",
          );
        });

    try {
      FirebaseAuth _auth = FirebaseAuth.instance;

      final UserCredential user = (await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()));

      getProvider(user.user.uid);
    } catch (e) {
      showSnackBar("email or password is wrong!", context, mainBackGround);
    }
  }

  void getProvider(String uid) {
    DatabaseReference providerRef = FirebaseDatabase.instance
        .reference()
        .child("users/ApplicationUsers/CarServiceProvider/$uid");

    createProvider(providerRef);
  }

  void createProvider(DatabaseReference providerRef) {
    providerRef.once().then((DataSnapshot dataSnapshot) {
      sp = _initServiceProvider(providerRef, dataSnapshot);
    }).then((_) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                  provider: sp,
                )),
      );
    });
  }

  ServiceProvider _initServiceProvider(
      DatabaseReference providerRef, DataSnapshot dataSnapshot) {
    ServiceProvider sp = new ServiceProvider(
        providerRef.key,
        providerRef,
        dataSnapshot.value['storeName'],
        dataSnapshot.value['phone'],
        dataSnapshot.value['email'],
        dataSnapshot.value['status'],
        dataSnapshot.value['IBAN'],
        dataSnapshot.value['totalPayment'],
        dataSnapshot.value['rating'],
        dataSnapshot.value['numOrders'],
        new DateTime.fromMillisecondsSinceEpoch(
            dataSnapshot.value['registDate']),
        dataSnapshot.value['serviceType'],
        dataSnapshot.value['commercial'],
        dataSnapshot.value['appActivity']);

    if (dataSnapshot.value['serviceType'] == "workshop") {
      Workshop workshop = new Workshop(
          providerRef.key,
          providerRef,
          dataSnapshot.value['storeName'],
          dataSnapshot.value['phone'],
          dataSnapshot.value['email'],
          dataSnapshot.value['status'],
          dataSnapshot.value['IBAN'],
          dataSnapshot.value['totalPayment'],
          dataSnapshot.value['rating'],
          dataSnapshot.value['numOrders'],
          new DateTime.fromMillisecondsSinceEpoch(
              dataSnapshot.value['registDate']),
          dataSnapshot.value['serviceType'],
          dataSnapshot.value['commercial'],
          dataSnapshot.value['appActivity']);
      return workshop;
    }

    return sp;
  }
}
