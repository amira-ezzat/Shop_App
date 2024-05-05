import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text('Sign in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: HexColor('#F0630B')
                ),),
                SizedBox(
                  height: 40.0,
                ),
                CircleAvatar(
                  radius: 70.0,
                  backgroundImage: NetworkImage(''
                      'https://img.freepik.com/free-photo/view-3d-geek-with-tablet_23-2150709940.jpg'),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText:'Email Adderss' ,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  )
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText:'Passward' ,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    )
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  width: double.infinity,
                  color: HexColor('#F0630B'),
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(color: Colors.white, width: 2.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                    ),
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don \'t have an account ?'),
                    TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(  color:  HexColor('#F0630B'),),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
