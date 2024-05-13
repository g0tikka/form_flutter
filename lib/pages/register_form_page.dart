import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_interaction/model/user.dart';
import 'user_info_page.dart';

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

  User newUser = User();

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
                  onSaved: (newValue) => newUser.name = newValue!,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: _validateAge,
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
                  validator: _validateEmailAddress,
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
                  validator: _validateStory,
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
                  validator: _validatePhone,
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
                  validator: _validatePassword,
                  controller: ObscuringTextEditingController(),
                  focusNode: _passFocus,
                  enableSuggestions: false,
                  autocorrect: false,
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
                  validator: _validatePassword,
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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // UserCredential user = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(
      //         email: _emailController.text, password: _passController.text);

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

  String? _validateAge(String? value) {
    if (value == null || int.tryParse(value) == false || value.isEmpty) {
      return 'Wrong format. Please use numeric symbols.';
    } else {
      return null;
    }
  }

  String? _validateEmailAddress(String? value) {
    final _emailExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null || value.isEmpty) {
      return 'Please fill the missing space.';
    } else if (_emailExp.hasMatch(value)) {
      return null;
    }
  }

  String? _validateStory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wrong format. Please use alphabetic symbols.';
    } else {
      return null;
    }
  }

  String? _validatePhone(String? value) {
    final _phoneExp =
        RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');

    if (value == null || value.isEmpty) {
      return 'Format: (XXX)-XXX-XXXX';
    } else if (_phoneExp.hasMatch(value)) {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wrong format. Please use alphabetic symbols.';
    } else {
      return null;
    }
  }

  void _showDialog(String name) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration successful'),
            content: Padding(
              padding: EdgeInsets.only(left: 22.0),
              child: Text('$name is now a verified user'),
            ),
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
}

class ObscuringTextEditingController extends TextEditingController {
  bool isObscured = true;

  void changeFieldVisibility({required bool isVisible}) {
    isObscured = !isVisible;
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    required bool withComposing,
    TextStyle? style,
  }) {
    final displayValue = isObscured
        ? ('•' * (value.text.length - 1)) +
            (value.text.characters.lastOrNull ?? '')
        : value.text;
    if (!value.composing.isValid || !withComposing) {
      return TextSpan(style: style, text: displayValue);
    }
    final composingStyle = style?.merge(
      const TextStyle(decoration: TextDecoration.underline),
    );

    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(displayValue)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(displayValue),
        ),
        TextSpan(text: value.composing.textAfter(displayValue)),
      ],
    );
  }
}
