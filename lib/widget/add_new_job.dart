import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungaicapp/models/job_model.dart';
import 'package:ungaicapp/models/usermodel.dart';
import 'package:ungaicapp/utility/dialog.dart';
import 'package:ungaicapp/utility/myconstant.dart';
import 'package:ungaicapp/utility/mystyle.dart';

class AddNewJob extends StatefulWidget {
  @override
  _AddNewJobState createState() => _AddNewJobState();
}

class _AddNewJobState extends State<AddNewJob> {
  List<UserModel> userModels = List();
  List<bool> chooseUsers = List();
  String title, todo, idofficer, nameofficer;

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
        onChanged: (value) => title = value.trim(),
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
        onChanged: (value) => todo = value.trim(),
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
        actions: [
          buildIconButton(),
        ],
        title: Text('Add New Job'),
      ),
      body: Center(
        child: Column(
          children: [buildTitle(), buildToDo(), buildListUser()],
        ),
      ),
    );
  }

  IconButton buildIconButton() => IconButton(
        icon: Icon(Icons.cloud_upload),
        onPressed: () {
          if ((title?.isEmpty ?? true) || (todo?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else if (checkChooseUser()) {
            addNewJobThread();
          } else {
            normalDialog(context, 'Non Assign User ? Please Choose User');
          }
        },
      );

  Widget buildListUser() {
    return Expanded(
      child: userModels.length == 0
          ? MyStyle().showProgress()
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView.builder(
                itemCount: userModels.length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color:
                          index % 2 == 0 ? Colors.grey.shade300 : Colors.white),
                  child: CheckboxListTile(
                    value: chooseUsers[index],
                    subtitle: Text('Position : ${userModels[index].user}'),
                    title: Text(userModels[index].name),
                    onChanged: (value) {
                      setState(() {
                        chooseUsers[index] = !chooseUsers[index];
                      });
                    },
                  ),
                ),
              ),
            ),
    );
  }

  bool checkChooseUser() {
    bool result = false;
    for (var item in chooseUsers) {
      if (item) {
        result = true;
      }
    }
    return result;
  }

  Future<Null> addNewJobThread() async {
    String status = 'assign';

    SharedPreferences preferences = await SharedPreferences.getInstance();
    idofficer = preferences.getString('id');
    nameofficer = preferences.getString(MyConstant().keyName);
    print('idofficer = $idofficer, nameofficer = $nameofficer');
    print('chooseUser = $chooseUsers');

    List<JobModel> jobModels = List();
    int index = 0;
    for (var item in chooseUsers) {
      if (item) {
        JobModel model = JobModel(
            idofficer: idofficer,
            nameofficer: nameofficer,
            iduser: userModels[index].id,
            nameuser: userModels[index].name,
            title: title,
            todo: todo,
            status: status);
        jobModels.add(model);
      }
      index++;
    }

    int index2 = 0;
    for (var item in jobModels) {
      String path =
          '${MyConstant().domain}/aic/addJob.php?isAdd=true&idofficer=$idofficer&nameofficer=$nameofficer&iduser=${item.iduser}&nameuser=${item.nameuser}&title=$title&todo=$todo';
      await Dio().get(path).then((value) {
        if (index2 >= jobModels.length - 1) {
          Navigator.pop(context);
        }
      });
      index2++;
    }
  }
}
