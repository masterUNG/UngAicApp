import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungaicapp/models/usermodel.dart';
import 'package:ungaicapp/utility/myconstant.dart';
import 'package:ungaicapp/utility/mystyle.dart';

class AddNewJob extends StatefulWidget {
  @override
  _AddNewJobState createState() => _AddNewJobState();
}

class _AddNewJobState extends State<AddNewJob> {
  List<UserModel> userModels = List();
  List<bool> chooseUsers = List();

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    String path = '${MyConstant().domain}/aic/getUserWhereType.php';
    await Dio().get(path).then((value) {
      print('value = $value');
      var result = json.decode(value.data);
      print('result = $result');
      for (var map in result) {
        UserModel model = UserModel.fromMap(map);
        chooseUsers.add(false);
        setState(() {
          userModels.add(model);
        });
      }
    });
  }

  Container buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.rowing),
          hintText: 'Title:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildToDo() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.work),
          hintText: 'ToDo :',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Job'),
      ),
      body: Center(
        child: Column(
          children: [buildTitle(), buildToDo(), buildListUser()],
        ),
      ),
    );
  }

  Widget buildListUser() {
    return Expanded(
      child: userModels.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
              itemCount: userModels.length,
              itemBuilder: (context, index) => CheckboxListTile(
                value: chooseUsers[index],
                subtitle: Text('Position : ${userModels[index].user}'),
                title: Text(userModels[index].name),
                onChanged: (value) {
                  setState(() {
                    chooseUsers[index] = true;
                  });
                },
              ),
            ),
    );
  }
}
