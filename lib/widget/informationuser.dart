import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungaicapp/models/usermodel.dart';
import 'package:ungaicapp/utility/myconstant.dart';
import 'package:ungaicapp/utility/mystyle.dart';
import 'package:ungaicapp/widget/edit_information.dart';

class InformationUser extends StatefulWidget {
  @override
  _InformationUserState createState() => _InformationUserState();
}

class _InformationUserState extends State<InformationUser> {
  String idLogin;
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findInfomation();
  }

  Future<Null> findInfomation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idLogin = preferences.getString('id');
    print('idLogin = $idLogin');

    String path =
        '${MyConstant().domain}/aic/getUserWhereId.php?isAdd=true&id=$idLogin';
    await Dio().get(path).then((value) {
      print('value ==> $value');
      var result = json.decode(value.data);
      print('resulte = $result');
      for (var item in result) {
        setState(() {
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditInformation(
              userModel: userModel,
            ),
          ),
        ).then((value) => findInfomation()),
        child: Text('Edit'),
      ),
      body: userModel == null
          ? MyStyle().showProgress()
          : userModel.address.isEmpty
              ? Center(child: Text('ข้อมูลไม่ครบ กรุณาคลิก Edit'))
              : Text('have data'),
    );
  }
}
