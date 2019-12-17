import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final _formkey = GlobalKey<FormState>();
  String _mail, _pass;
  bool isPass = true;

  
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
        obscureText: isPass,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            child: Icon( isPass ? Icons.visibility : Icons.visibility_off),
            onTap: ()=>{
              setState(()=>isPass = !isPass)
            },
          ),
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
      child: RaisedButton(
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
        color: Theme.of(context).accentColor,
      ),
    );
  }

  Widget _goToRegisterPage() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: FlatButton(
        onPressed: () => {
          Navigator.of(context).pushReplacementNamed('/register')
        },
        child: Text("New user?, Register"),
      ),
    );
  }

  Widget _showTitle() {
    return Text("Login", style: Theme.of(context).textTheme.headline);
  }

  void _submit() {

      final form = _formkey.currentState;

    if (form.validate()) {

      form.save();
      print("$_mail $_pass");
    } else {
      print('no valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                    _email(),
                    _password(),
                    _submitBtn(),
                    _goToRegisterPage()
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