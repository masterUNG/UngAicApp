import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungaicapp/utility/dialog.dart';
import 'package:ungaicapp/utility/myconstant.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String typeUser, name, user, password;

  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  Future<Null> checkInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if ((result.isNotEmpty) && (result[0].rawAddress.isNotEmpty)) {
        print('Internet Connected');
      }
    } catch (e) {
      print('error Internet ==> ${e.toString()}');
      normalDialog(context, 'Cannot Connected Internet ? Please Try Again');
    }
  }

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.fingerprint),
          hintText: 'Name:',
          border: OutlineInputBorder(),
        ),
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
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: 'Password:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('name = $name, user = $user, password = $password');
          if (name == null ||
              name.isEmpty ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            print('Have Space');
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else if (typeUser == null) {
            normalDialog(context, 'No TypeUser ? Please Choose TypeUser');
          } else {
            checkUser();
          }
        },
        child: Icon(Icons.cloud_upload),
      ),
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildName(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildRadioListTileUser(),
                  buildRadioListTileOfficer(),
                ],
              ),
              buildUser(),
              buildPassword(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildRadioListTileUser() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: RadioListTile(
        subtitle: Text('for Register Type User'),
        title: Text('User'),
        value: 'User',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
          });
        },
      ),
    );
  }

  Container buildRadioListTileOfficer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: RadioListTile(
        subtitle: Text('for Register Type Officer'),
        title: Text('Officer'),
        value: 'Officer',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
          });
        },
      ),
    );
  }

  Future<Null> checkUser() async {
    String path =
        '${MyConstant().domain}/aic/getUserWhereUser.php?isAdd=true&user=$user';

    await Dio().get(path).then((value) {
      print('value = $value');
      if (value.toString() == 'null') {
        insertUser();
      } else {
        normalDialog(
            context, '$user มีคนอื่นใช้ไปแล้วคะ ? กรุณาเปลี่ยน User ใหม่');
      }
    });
  }

  Future<Null> insertUser() async {
    String path =
        '${MyConstant().domain}/aic/addUserUng.php?isAdd=true&name=$name&user=$user&password=$password&typeuser=$typeUser';
    await Dio().get(path).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'Please Try Again');
      }
    });
  }
}
