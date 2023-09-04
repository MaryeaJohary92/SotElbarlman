import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wep_project/models/ParlimentFollowData.dart';
import 'package:wep_project/models/SportsModel.dart';
import 'package:wep_project/shared/components/constants.dart';
import 'package:wep_project/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/BusinessNewsModel.dart';
import '../../models/ParlimentCardModel.dart';
import '../../models/StatesModel.dart';
import '../../modules/FirstPage.dart';
import '../../modules/MainPage.dart';
import '../../modules/SecondPage.dart';
import '../../modules/StatesPage.dart';
import '../network/remote/dio_helper.dart';

class WebsiteCubit extends Cubit<WebsiteStates>{
  WebsiteCubit():super(WebsiteInitialState());
 static WebsiteCubit get(context)=>BlocProvider.of(context);
 //going through pages of app
  int selectedIndex = 1;
  //cubit main outside lists access
  List<Widget> widgets=[
    MainPage(),
    StatePage(),
    FirstPage(),
    SecondPage(),
  ];
  List<States> states=[];
  List<ParlimentCard> parlimentCards=[];
  ParlimentCard? parlirmentData;
  List<ParlimentCardFollowData> parlimentCardFollowData=[];
  //cubit inside access models
  BusinessDataModel? businessArticles;
  SportsDataModel? sportsArticles;
  List<States>? statesStore;
  List<ParlimentCard>? parlimentStore;
  List<ParlimentCardFollowData>? parlimentFollowDataStore;
  //cubit main methods
    //change page method
  void changeIndex(int index,BuildContext context){
    selectedIndex=index;
    Navigator.pop(context);
    emit(WebsiteChangeNavigationOfPagesState());
  }
    //get news from api
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
  /*List<dynamic> search=[];
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
  }*/
    //get news from firebase
  Future<List<States>> getStates()async {
    emit(GetWebsiteNewsParlimentStatesLoadingState());
    await FirebaseFirestore.instance.collection('states').snapshots().forEach((element) {
      statesStore= element.docs.map((e) {
        final state = States.fromMap(e.data());
        return state;
      }).toList();
      states=statesStore!;
      emit(GetWebsiteNewsParlimentStatesSuccessState());
    }).catchError((onError){emit(GetWebsiteNewsParlimentStatesErrorState());
    });
    return states;
  }
  Future<List<ParlimentCard>> getParlimentCards(String state)async {
    emit(GetWebsiteNewsParlimentLoadingState());
    await FirebaseFirestore.instance.collection('persons').where("state",isEqualTo: state).snapshots().forEach((element) {
      parlimentStore= element.docs.map((e) {
        final parliment = ParlimentCard.fromMap(e.data());
        return parliment;
      }).toList();
      parlimentCards=parlimentStore!;
      emit(GetWebsiteNewsParlimentSuccessState());
    }).catchError((onError){emit(GetWebsiteNewsParlimentErrorState());
    });
    return parlimentCards;
  }
  Future<ParlimentCard?> getParliment(String id)async {
    emit(GetWebsiteParlimentLoadingState());
    await FirebaseFirestore.instance.collection('persons').doc(id).get().then((value) {
      dynamic parliment=ParlimentCard.fromMap(value.data() as Map<String,dynamic>);
      parlirmentData=parliment;
      emit(GetWebsiteParlimentSuccessState());
    }).catchError((onError){emit(GetWebsiteParlimentErrorState());});
    return parlirmentData;
  }
  Future<List<ParlimentCardFollowData>> getParlimentFollowData(String id)async {
    emit(GetWebsiteParlimentPostsLoadingState());
    await FirebaseFirestore.instance.collection('البيانات').where('id', isEqualTo:id).orderBy('time').snapshots().forEach((element) {
      parlimentFollowDataStore= element.docs.map((e) {
        final parlimentData = ParlimentCardFollowData.fromMap(e.data());
        return parlimentData;
      }).toList();
      parlimentCardFollowData=parlimentFollowDataStore!;
      emit(GetWebsiteParlimentPostsSuccessState());
    }).catchError((onError){emit(GetWebsiteParlimentPostsErrorState());
    });
    return parlimentCardFollowData;
  }
}