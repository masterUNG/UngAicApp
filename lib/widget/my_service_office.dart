import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungaicapp/utility/myconstant.dart';
import 'package:ungaicapp/utility/mystyle.dart';
import 'package:ungaicapp/widget/page2.dart';
import 'package:ungaicapp/widget/showlistjob.dart';

class MyServiceOfficer extends StatefulWidget {
  @override
  _MyServiceOfficerState createState() => _MyServiceOfficerState();
}

class _MyServiceOfficerState extends State<MyServiceOfficer> {
  String nameLogin;
  Widget currentWidget = ShowlistJob();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLogin();
  }

  Future<Null> findLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameLogin = preferences.getString(MyConstant().keyName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameLogin == null ? 'Officer: ' : 'Officer: $nameLogin'),
      ),
      drawer: buildDrawer(context),
      body: currentWidget,
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildMenuShowJob(),
              buildMenuPage2(),
            ],
          ),
          MyStyle().buildSignOut(context),
        ],
      ),
    );
  }

  ListTile buildMenuShowJob() {
    return ListTile(
      leading: Icon(Icons.list),
      title: Text('Show List Job'),
      subtitle: Text('แสดงรายชื่อของงานที่ รับผิดชอบ'),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowlistJob();
        });
      },
    );
  }

  ListTile buildMenuPage2() {
    return ListTile(
      leading: Icon(Icons.filter_2),
      title: Text('Page 2'),
      subtitle: Text('Display Page2'),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = Page2();
        });
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wall.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      currentAccountPicture: Image.asset('images/logo.png'),
      accountName: nameLogin == null ? Text('Name') : Text(nameLogin),
      accountEmail: Text('Logined'),
    );
  }
}
