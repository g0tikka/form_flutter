import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _passwordVisible = false;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _nameFocus = FocusNode();
  final _ageFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _storyFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmPassFocus = FocusNode();

  List<String> _countries = [
    'Albania',
    'Belgium',
    'Canada',
    'Denmark',
    'Ethiopia',
    'France',
    'Germany',
  ];

  String? _selectedCountry;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _phoneNumberController.dispose();
    _passController.dispose();
    _nameFocus.dispose();
    _ageFocus.dispose();
    _emailFocus.dispose();
    _storyFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    _confirmPassFocus.dispose();
    super.dispose();
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Register Form',
          style: TextStyle(
              color: Colors.white, fontFamily: AutofillHints.organizationName),
        ),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: SizedBox(
            child: ListView(
              padding: const EdgeInsets.all(18.0),
              children: [
                TextFormField(
                  focusNode: _nameFocus,
                  autofocus: true,
                  onFieldSubmitted: (_) {
                    fieldFocusChange(context, _nameFocus, _ageFocus);
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name *',
                    hintText: 'Ivan Ivanov',
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            _nameController.clear();
                          });
                        }),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.purple,
                        )),
                  ),
                  validator: _validateName,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  //validator: _validateAge,
                  controller: _ageController,

                  focusNode: _ageFocus,
                  autofocus: false,
                  onFieldSubmitted: (_) {
                    fieldFocusChange(context, _ageFocus, _emailFocus);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.child_care),
                    labelText: 'Age *',
                    hintText: '18',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            _ageController.clear();
                          });
                        }),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail address *',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            _emailController.clear();
                          });
                        }),
                    prefixIcon: Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _storyController,
                  decoration: InputDecoration(
                    labelText: 'Your story *',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            _storyController.clear();
                          });
                        }),
                    prefixIcon: Icon(Icons.text_increase_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  maxLength: 200,
                  inputFormatters: [LengthLimitingTextInputFormatter(200)],
                ),
                SizedBox(
                  height: 10.0,
                ),
                DropdownButtonFormField(
                  items: _countries.map((country) {
                    return DropdownMenuItem(
                      child: Text(country),
                      value: country,
                    );
                  }).toList(),
                  onChanged: (data) {
                    print(data);
                    setState(() {
                      _selectedCountry = data;
                    });
                  },
                  value: _selectedCountry,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a country';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.purple,
                      ),
                    ),
                    labelText: 'Your country',
                    prefixIcon: Icon(Icons.map),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  focusNode: _phoneFocus,
                  onFieldSubmitted: (_) {
                    fieldFocusChange(context, _phoneFocus, _passFocus);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the blank with your phone number';
                    }
                    return null;
                  },
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone number *',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            _phoneNumberController.clear();
                          });
                        }),
                    prefixIcon: Icon(Icons.phone),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  // inputFormatters: [
                  //   FilteringTextInputFormatter(RegExp(r'^[()\d - ]{1, 15}$'),
                  //       allow: true),
                  // ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _passController,
                  focusNode: _passFocus,
                  obscureText: _passwordVisible,
                  maxLength: 16,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    prefixIcon: Icon(Icons.password),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.purple,
                      ),
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        }),
                  ),
                ),
                TextFormField(
                  controller: _passController,
                  maxLength: 16,
                  decoration: InputDecoration(
                    labelText: 'Confirm password *',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  obscureText: _passwordVisible,
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    child: Text(
                      'Submit Form',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          )),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _showDialog(_nameController.text);
      print('${_nameController.text}, your form has been submitted!');
    } else {
      _showMessage('Form is invalid. Please fill in missing data.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.deepPurple.shade500,
    ));
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');

    if (value == null || value.isEmpty) {
      return 'Please fill the blank with alphabetic characters';
    } else if (_nameExp.hasMatch(value)) {
      return null;
    }
  }

  //_validateAge
  //_validateEmail
  //_validateStory
  //_validatePhoneNumber
  //_validatePassword

  void _showDialog(String name) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration successful'),
            content: Text('$name is now a verified register form'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Verified')),
            ],
          );
        });
  }

  // bool? _validatePhoneNumber(String input) {
  //   final _phoneExp = RegExp(r'^(\d\d\d)-\d\d\d-\d\d\d\d$');
  //  return _phoneExp.hasMatch(input);
  // }
}
