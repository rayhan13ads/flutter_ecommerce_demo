import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  String _name, _mail, _pass;
  bool isSubmitted;

  Widget _username() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _name = val,
        validator: (val) => val.length < 6 ? "Username too short" : null,
        decoration: InputDecoration(
            labelText: 'Username',
            hintText: 'Enter username min length 6',
            icon: Icon(
              Icons.face,
              color: Colors.grey,
            ),
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget _email() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _mail = val,
        validator: (val) => !val.contains('@') ? "Invalid email" : null,
        decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter valid email',
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            ),
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget _password() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _pass = val,
        validator: (val) => val.length < 6 ? "Username too short" : null,
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter password min length 6',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget _submitBtn() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: isSubmitted == true
          ? CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            )
          : RaisedButton(
              onPressed: null,
              child: Text("Submit",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.black)),
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              color: Theme.of(context).primaryColor,
            ),
    );
  }

  Widget _goToLoginPage() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: FlatButton(
        onPressed: () => {Navigator.of(context).pushReplacementNamed('/login')},
        child: Text("Existing user?, Login"),
      ),
    );
  }

  Widget _showTitle() {
    return Text("Register", style: Theme.of(context).textTheme.headline);
  }

  void _submit() {
    final form = _formkey.currentState;

    if (form.validate()) {
      form.save();
      print("$_name $_mail $_pass");
    } else {
      print('no valid');
    }
  }

  void _registertionUser() async {
    setState(() {
      isSubmitted = true;
    });

    http.Response response = await http.post(
        "http://localhost:1337/auth/local/register",
        body: {"username": _name, "email": _mail, "passwrod": _pass});

    final resData = json.decode(response.body);
    setState(() {
      isSubmitted = false;
    });
    print(resData);
    _showSuccessSnackbar();
    _goToProductsPage();
  }

  void _showSuccessSnackbar() {
    final snackbar = SnackBar(
      content: Text(
        " User $_name successful created!",
        style: TextStyle(color: Colors.green),
      ),
    );

    _scaffoldStateKey.currentState.showSnackBar(snackbar);
    _formkey.currentState.reset();
  }

  void _goToProductsPage() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/products');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    _showTitle(),
                    _username(),
                    _email(),
                    _password(),
                    _submitBtn(),
                    _goToLoginPage()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
