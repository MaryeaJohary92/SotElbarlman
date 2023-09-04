import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void printFullText(String? text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((element) {print(element.group(0));});
}
Color bgColor=Colors.red.shade800;

double drawerTextSizeMoreThan300=15;
double drawerTextSizeLessThan300=10;
double drawerTextSizeMoreThan500=22;
var scaffKeyHomePage=GlobalKey<ScaffoldState>();
String apiKey='pub_2800687c1f66d0a2114eed03ca86f1a201d5d';
String GState='';
String Gid='10058';
late final Future<FirebaseApp> intialization;