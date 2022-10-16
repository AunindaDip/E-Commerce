import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:symbexecommerce/SignUp.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text("E-Commerce"),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.whatshot,
                  size: 70,
                  color: Colors.deepPurple,
                ),

                const Text(
                  " Welcome Back !!!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text("You Have been Missed", style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 30,
                ),
                //PasswordTextfield

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12.00)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(

                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12.00)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(

                        obscureText: _isHidden,
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_rounded),
                          border: InputBorder.none,
                          hintText: "Password",
                          suffix: InkWell(
                            onTap: _togglePasswordView,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                _isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                InkWell(
                  onTap: ()async {
                    var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi)
                    { SignIn(emailController.text.toString(),
                        passwordController.text.toString());
                      // I am connected to a mobile or Wifi network.
                    } else if (connectivityResult==ConnectivityResult.none) {

                      Fluttertoast.showToast(
                          msg: "Check Your Internet Connection",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      // No Internet
                    }







                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.00),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: const Center(
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a Member ?'),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyRegister()),
                        );
                      },
                      child: const Text(
                        " Sign Up Now ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );





  }

  SignIn(String email, String password) async {







    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {

      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });




      Map data = {'email': email, 'password': password};

      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      var url = Uri.parse("https://www.ecommerce.symbexit.com/api/login");
      var response = await http.post(url, body: data);
      if (response.statusCode == 201) {

        var body = json.decode(response.body);
        setState(() {
          sharedPreferences.setString('token', body['token']);
          sharedPreferences.setString('user', jsonEncode(body['user']));
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const homepage()),
          );


        });
      } else if(response.statusCode!=201){

        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: response.body.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);

      }
    }
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "You Have to enter Both Email and Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }



  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}





