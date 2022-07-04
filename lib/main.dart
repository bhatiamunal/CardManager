import 'package:flutter/material.dart';
import 'package:cardmanager/Pages/home.dart';
import 'package:cardmanager/Pages/ChooseLocation.dart';
void main() => runApp(MaterialApp(
   //home: Welcome(),
  routes: {
    '/': (context) => Home(),
    '/detail':(context)=>ChooseLocation()

  },

));

