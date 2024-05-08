import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ApiDemoApp());
}

class ApiDemoApp extends StatefulWidget {
  @override
  _ApiDemoAppState createState() => _ApiDemoAppState();
}

class _ApiDemoAppState extends State<ApiDemoApp> {
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchPosts() async {
    final response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', '/posts'));

    if (response.statusCode == 200) {
      setState(() {
        _posts = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                fetchPosts(); // Trigger API data loading
              },
              child: Text('Load Posts'),
            ),
            SizedBox(height: 20),
            _posts.isEmpty
                ? Center(child: Text('Press the button to load posts.'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        final post = _posts[index];
                        return ListTile(
                          title: Text(post['title']),
                          subtitle: Text(post['body']),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
