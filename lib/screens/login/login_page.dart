import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../product/ProductPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var sharedPref;
  bool isRemember = false;

  @override
  void initState() {
    super.initState();
    prepareSharedInstance();
  }

  Future<void> prepareSharedInstance() async {
    sharedPref = await SharedPreferences.getInstance();
    setState(() {
      isRemember = sharedPref.getBool("remember") ?? false;
      if (isRemember) {
        txtUserName.text = sharedPref.getString("username") ?? "";
        txtPassword.text = sharedPref.getString("pass") ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Kullanıcı Giriş',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 20, 30),
              alignment: Alignment.center,
              child: TextField(
                controller: txtUserName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 5, 20, 30),
              alignment: Alignment.center,
              child: TextField(
                obscureText: true,
                controller: txtPassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 20),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.blueGrey,
                onChanged: (newValue) {
                  setState(() {
                    isRemember = newValue!;
                    sharedPref.setBool("remember", newValue);
                  });
                },
                title: const Text(
                  "Remember me",
                  style: TextStyle(color: Colors.black),
                ),
                value: false,
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  login();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  login() {
    if (isRemember) {
      sharedPref.setString("username", txtUserName.text.toString());
      sharedPref.setString("pass", txtPassword.text.toString());
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProductPage()));
  }
}
