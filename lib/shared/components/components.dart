import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wep_project/models/BusinessNewsModel.dart';
import 'package:wep_project/models/SportsModel.dart';
import '../../modules/FollowPage.dart';
import '../../modules/ParlimentFollowPage.dart';
import '../../modules/ParlimentVoice.dart';
import '../cubit/cubit.dart';
import 'constants.dart';

Widget buildBusinessNewsCart(BuildContext context,NewsModel? model){
  return Container(
    width: MediaQuery.of (context).size.width > 500 ?MediaQuery.of(context).size.height/4 : MediaQuery.of (context).size.width > 300 ?MediaQuery.of(context).size.height/5:MediaQuery.of(context).size.height/6,
    height: MediaQuery.of(context).size.height/6,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20)
    ),
    child: ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FollowPage(model: model,)));
      },
      title: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image:AssetImage('assets/download.png'),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/11,fit: BoxFit.fill ,),
          ),
          SizedBox(height: 4,),
          Text('${model?.title??''}',textAlign: TextAlign.right,overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: Colors.brown),)
        ],
      ),
    ),
  );
}
Widget buildSportsNewsCart(BuildContext context,SportsNewsModel? model){
  return Container(
    width: MediaQuery.of (context).size.width > 500 ?MediaQuery.of(context).size.height/4 : MediaQuery.of (context).size.width > 300 ?MediaQuery.of(context).size.height/5:MediaQuery.of(context).size.height/6,
    height: MediaQuery.of(context).size.height/6,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
    ),
    child: ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FollowPage(model: model,)));
      },
      title: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image:AssetImage('assets/download.png'),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/11,fit: BoxFit.fill ,),
          ),
          SizedBox(height: 4,),
          Text('${model?.title}',overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: Colors.brown),)
        ],
      ),
    ),
  );
}

Widget footerSection(BuildContext context)=>Container(
  color: Colors.black45,
  child: Center(child: Text('كيفيه الاتصال بنا',style: TextStyle(color: Colors.white,fontSize:MediaQuery.of (context).size.width > 500 ?35 : MediaQuery.of (context).size.width < 300 ?25:15 ),)),
);

Widget buildParlimentVoiceCart(BuildContext context,snapshot){
  return Container(
    height: MediaQuery.of(context).size.height>500?MediaQuery.of(context).size.height:MediaQuery.of(context).size.height/3,
    width: MediaQuery.of(context).size.width>500?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width/5,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
    ),
    child: ListTile(
      onTap: (){
        Gid=snapshot.id;
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ParlimentDetailsPage(id:snapshot.id,)));
      },
      title: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image:NetworkImage('${snapshot.imgURL}'),height: MediaQuery.of(context).size.height/9,width: MediaQuery.of(context).size.width,fit: BoxFit.fill ,),
          ),
          SizedBox(height: 2,),
          snapshot.male==true?Text(
            ' النائب : ${snapshot.Name}',overflow: TextOverflow.ellipsis,maxLines: 2,
            style: TextStyle(color: Colors.brown,fontSize: MediaQuery.of(context).size.width>500?25:14),)
              :Text(
            ' النائبه : ${snapshot.Name}',overflow: TextOverflow.ellipsis,maxLines: 2,
            style: TextStyle(color: Colors.brown,fontSize: MediaQuery.of(context).size.width>500?25:14),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('رمز : غير معروف',overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: Colors.brown,fontSize: MediaQuery.of(context).size.width>500?25:14),),
              SizedBox(width: 2,),
              Icon(Icons.question_mark,color: Colors.brown,size:MediaQuery.of(context).size.width>500?25:10,)
            ],
          ),
          Text(' المحافظه : ${snapshot.state}',style: TextStyle(color: Colors.grey,fontSize: MediaQuery.of(context).size.width>500?25:14),)

        ],
      ),
    ),
  );
}

Widget stateParlimentBuilder(BuildContext context,snapshot){
  return Container(
    height: MediaQuery.of(context).size.height/6,
    width: MediaQuery.of(context).size.width/5,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
    ),
    child: ListTile(
      onTap: (){
        GState=snapshot.Name;
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PalimentVoice(state:snapshot.Name,)));
      },
      title: Center(child:Text(' محافظه : ${snapshot.Name}',style: TextStyle(color: Colors.brown,fontSize:MediaQuery.of (context).size.width > 500 ?20 : MediaQuery.of (context).size.width > 300 ?15:10),)
        ,),
    ),
  );
}

Widget buildCrousalBusiness(BuildContext context){
  return  CarouselSlider(
    items:WebsiteCubit.get(context).businessArticles?.articles?.map((e)=>Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height/2 ,
      child: Column(
        children: [
          Image(
            image: NetworkImage('assets/download.png'),
            width:MediaQuery.of(context).size.width/3,
            height: MediaQuery.of(context).size.height /9,
            fit: BoxFit.fill,
          ),
          Text('${e.title}',textAlign: TextAlign.right,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of (context).size.width > 500 ?25 : MediaQuery.of (context).size.width > 300 ?15:10))
        ],
      ),
    )).toList(),
    options: CarouselOptions(
        height:MediaQuery.of(context).size.height ,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        viewportFraction: 1.0,
        autoPlayInterval: Duration(seconds: 6),
        autoPlayAnimationDuration: Duration(seconds:1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal
    ),
  );
}
Widget buildCrousalSports(BuildContext context){
  return  CarouselSlider(
    items:WebsiteCubit.get(context).sportsArticles?.articles?.map((e)=>Container(
      color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height/2 ,
      child: Column(
        children: [
          Image(
            image: NetworkImage('assets/download.png'),
            width:MediaQuery.of(context).size.width/3,
            height: MediaQuery.of(context).size.height /9,
            fit: BoxFit.fill,
          ),
          Text('${e.title}',textAlign: TextAlign.right,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of (context).size.width > 500 ?25 : MediaQuery.of (context).size.width > 300 ?15:10),)
        ],
      ),
    )).toList(),
    options: CarouselOptions(
        height: MediaQuery.of(context).size.height ,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        viewportFraction: 1.0,
        autoPlayInterval: Duration(seconds: 6),
        autoPlayAnimationDuration: Duration(seconds:1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal
    ),
  );
}

