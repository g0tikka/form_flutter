import 'package:flutter/material.dart';
import 'package:form_interaction/pages/register_form_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RegisterFormPage(),
      title: 'Register Form',
      theme: ThemeData(primarySwatch: Colors.cyan),
    );
  }
}
