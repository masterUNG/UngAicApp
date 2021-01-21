import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungaicapp/models/usermodel.dart';
import 'package:ungaicapp/utility/dialog.dart';
import 'package:ungaicapp/utility/myconstant.dart';
import 'package:ungaicapp/utility/mystyle.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true, statusProgress = true;
  String user, password;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 0.8,
            colors: <Color>[Colors.white, Colors.lime],
          ),
        ),
        child: Stack(
          children: [
            buildContent(),
            statusProgress ? SizedBox() : MyStyle().showProgress(),
          ],
        ),
      ),
    );
  }

  Center buildContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLogo(),
            buildAppName(),
            buildUser(),
            buildPassword(),
            buildLogin(),
            buildRegister()
          ],
        ),
      ),
    );
  }

  TextButton buildRegister() => TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        child: Text('New Register'),
      );

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'มีช่องว่าง ? กรุณากรอกทุกช่อง คะ');
          } else {
            setState(() {
              statusProgress = false;
            });
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.rowing),
          hintText: 'User:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              setState(() {
                statusRedEye = !statusRedEye;
              });
              print('You Click RedEye statusRedEye = $statusRedEye');
            },
          ),
          prefixIcon: Icon(Icons.lock),
          hintText: 'Password:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Text buildAppName() => Text(
        'Ung AIC App',
        style: GoogleFonts.abrilFatface(
            textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.pink.shade900,
          fontStyle: FontStyle.italic,
        )),
      );

  Container buildLogo() {
    return Container(
      width: 150,
      child: Image.asset('images/logo.png'),
    );
  }

  Future<Null> checkAuthen() async {
    String path =
        '${MyConstant().domain}/aic/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      if (value.toString() == 'null') {
        setState(() {
          statusProgress = true;
        });
        normalDialog(context, 'ไม่มี $user ในฐานข้อมูลของเราเลย');
        count++;
        checkCount();
      } else {
        print('value = $value');
        var result = json.decode(value.data);
        print('result = $result');
        for (var item in result) {
          print('item = $item');
          UserModel model = UserModel.fromMap(item);
          if (password == model.password) {
            print('Login Success');

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString(MyConstant().keyName, model.name);
            preferences.setString(MyConstant().keyType, model.typeuser);
            preferences.setString('id', model.id);

            switch (model.typeuser) {
              case 'User':
                Navigator.pushNamedAndRemoveUntil(
                    context, '/serviceuser', (route) => false);
                break;
              case 'Officer':
                Navigator.pushNamedAndRemoveUntil(
                    context, '/serviceofficer', (route) => false);
                break;
              default:
            }
          } else {
            setState(() {
              statusProgress = true;
            });
            normalDialog(context, 'Password False ? Please Try Again');
            count++;
            checkCount();
          }
        }
      }
    });
  }

  void checkCount() {
    if (count >= 4) {
      normalDialog(context, 'คุณ login เกินไปละ Count ==> $count');
    }
  }
}
