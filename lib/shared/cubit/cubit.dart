import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wep_project/models/SportsModel.dart';
import 'package:wep_project/shared/components/constants.dart';
import 'package:wep_project/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/BusinessNewsModel.dart';
import '../../modules/FirstPage.dart';
import '../../modules/MainPage.dart';
import '../../modules/SecondPage.dart';
import '../../modules/StatesPage.dart';
import '../network/remote/dio_helper.dart';

class WebsiteCubit extends Cubit<WebsiteStates>{
  WebsiteCubit():super(WebsiteInitialState());
 static WebsiteCubit get(context)=>BlocProvider.of(context);
  int selectedIndex = 1;

  List<Widget> widgets=[
    MainPage(),
    StatePage(),
    FirstPage(),
    SecondPage(),
  ];


  void changeIndex(int index,BuildContext context){
    selectedIndex=index;
    Navigator.pop(context);
    emit(WebsiteChangeNavigationOfPagesState());
  }

  BusinessDataModel? businessArticles;
  void getBusinessArticles(){
    if(businessArticles?.articles.length!=0)
    {
      emit(GetWebsiteNewsBusinessLoadingState());
      DioHelper.getData(url:'api/1/news',query: {"country":"eg","category":"science","apikey":apiKey})?.then((value) {
        businessArticles=BusinessDataModel.fromJson(json:value?.data['results']);
        emit(GetWebsiteNewsBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetWebsiteNewsBusinessErrorState());
      });
    }
    else
    {
      emit(GetWebsiteNewsBusinessSuccessState());
    }
  }
  SportsDataModel? sportsArticles;
  void getSportsArticles(){
    if(sportsArticles?.articles.length!=0)
    {
      emit(GetWebsiteNewsSportsLoadingState());
      DioHelper.getData(url:'api/1/news',query: {"country":"eg","category":"sports","apiKey":apiKey})?.then((value) {
        sportsArticles=SportsDataModel.fromJson(json:value?.data['results']);
        emit(GetWebsiteNewsSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetWebsiteNewsSportsErrorState());
      });
    }
    else
    {
      emit(GetWebsiteNewsSportsSuccessState());
    }
  }


  List<dynamic> search=[];
  void getSearch(String value){
    emit(GetWebsiteSearchNewsLoadingState());
    search=[];
    DioHelper.getData(url:'v2/top-headlines',query: {"q":"$value","apiKey":apiKey})?.then((value) {
      search=value?.data['articles'];
      emit(GetWebsiteSearchNewsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetWebsiteSearchNewsErrorState());
    });
  }

}