import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStyle {
  Widget showProgress() => Center(child: CircularProgressIndicator());

  TextStyle whiteStyle() => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );


  Widget buildSignOut(BuildContext context)  {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListTile(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/authen', (route) => false);
            },
            tileColor: Colors.red.shade700,
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 36,
            ),
            title: Text(
              'SignOut',
              style: MyStyle().whiteStyle(),
            ),
          ),
        ],
      );
  } // buildSingout

  MyStyle();
}
