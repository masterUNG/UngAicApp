import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungaicapp/utility/mystyle.dart';
import 'package:ungaicapp/widget/informationuser.dart';
import 'package:ungaicapp/widget/list_job_for_user.dart';

class MyServiceUser extends StatefulWidget {
  @override
  _MyServiceUserState createState() => _MyServiceUserState();
}

class _MyServiceUserState extends State<MyServiceUser> {
  Widget currentWidget = ListJobForUser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null> readInformation() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User: '),
      ),
      drawer: Drawer(
        child: MyStyle().buildSignOut(context),
      ),body: currentWidget,
    );
  }
}
