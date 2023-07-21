import 'dart:convert';
import 'package:application/Auth/Login.dart';
import 'package:application/Auth/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final token;

  const Profile({@required this.token, Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> logOut() async {
    await Users.removeToken();
    await Users.setsignin(false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  late String name;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    name = jwtDecodedToken['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.supervised_user_circle),
        backgroundColor: const Color.fromARGB(255, 92, 36, 212),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        title: Text('$name 👋'),
        shadowColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F60A0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  logOut();
                },
                child: const Text("Sign out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
