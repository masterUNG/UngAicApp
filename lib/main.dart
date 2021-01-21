import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungaicapp/router.dart';
import 'package:ungaicapp/utility/myconstant.dart';

var myInitial;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String type = preferences.getString(MyConstant().keyType);
  print('type ==> $type');

  if (type != null) {
    switch (type) {
      case 'User':
        myInitial = '/serviceuser';
        break;
      case 'Officer':
        myInitial = '/serviceofficer';
        break;
      default:
    }
  } else {
    myInitial = '/authen';
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: myInitial,
      // home: Authen(),
    );
  }
}
