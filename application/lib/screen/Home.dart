import 'dart:convert';
import 'package:application/components/Bottom_tap.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> cars = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomTab()))
                  },
              icon: const Icon(Icons.supervised_user_circle));
        }),
        backgroundColor: const Color.fromARGB(255, 92, 36, 212),
        titleTextStyle: const TextStyle(fontSize: 18),
        title: const Text('Home'),
        shadowColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final valuecars = cars[index];
          final name = valuecars['station'];
          final email = valuecars['number'];
          final imageUrl =
              valuecars['http://localhost:8081/getCars'];
          return ListTile(
            leading: CircleAvatar(child: Image.network(imageUrl)),
            title: Text(name),
            subtitle: Text(email),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
    );
  }

  void fetchUsers() async {
    // print('fetchUsers called');
    const url = 'http://localhost:8081/car/getCars';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      cars = json['Result'];
    });
    // print('fetchUsers completed');
  }
}
