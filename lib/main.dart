import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wep_project/modules/SecondPage.dart';
import 'package:wep_project/shared/bloc_observer.dart';
import 'package:wep_project/shared/components/constants.dart';
import 'package:wep_project/shared/cubit/cubit.dart';
import 'package:wep_project/shared/network/remote/dio_helper.dart';
import 'layout/HomePage.dart';
import 'modules/FirstPage.dart';
import 'modules/MainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAQV1pPuIL9JROTkpYmCN64WPac620MDos",
        authDomain: "web-news-app.firebaseapp.com",
        projectId: "web-news-app",
        storageBucket: "web-news-app.appspot.com",
        messagingSenderId: "227053175936",
        appId: "1:227053175936:web:ef179ffa4179ee6684d265",
        measurementId: "G-0RMRT5N36X"    )
  );
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    print(DateTime.now().millisecondsSinceEpoch.remainder(100000).toString());
    scaffKeyHomePage.currentState?.openDrawer();
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context)=>WebsiteCubit()..getBusinessArticles()..getSportsArticles()..getStates()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'جريدة صوت البرلمان',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:MyHomePage(),
          initialRoute: '/',
          routes:{
            '//': (context) => MyHomePage(),
            '//homePage':(context)=>MainPage(),
            '//businessNews':(context)=>SecondPage(),
            '//sportsNews':(context)=>FirstPage()
          },
        ),
      ),
    );
  }
}


