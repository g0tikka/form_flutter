import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Name'),
              subtitle: Text('Story'),
              trailing: Text('Country'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Phone'),
              leading: Icon(Icons.phone),
            ),
            ListTile(
              title: Text('E-mail'),
              leading: Icon(Icons.email),
            ),
          ],
        ),
      ),
    );
  }
}
