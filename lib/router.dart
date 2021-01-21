import 'package:flutter/material.dart';
import 'package:ungaicapp/widget/add_new_job.dart';
import 'package:ungaicapp/widget/authen.dart';
import 'package:ungaicapp/widget/edit_information.dart';
import 'package:ungaicapp/widget/my_service_office.dart';
import 'package:ungaicapp/widget/my_service_user.dart';
import 'package:ungaicapp/widget/register.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/serviceuser':(BuildContext context)=> MyServiceUser(),
  '/serviceofficer':(BuildContext context)=> MyServiceOfficer(),
  '/editinformation':(BuildContext context)=> EditInformation(),
  '/addNewJob':(BuildContext context)=>AddNewJob(),
};
