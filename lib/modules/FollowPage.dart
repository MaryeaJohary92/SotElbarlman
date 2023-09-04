import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wep_project/models/BusinessNewsModel.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';

class FollowPage extends StatelessWidget {
  final dynamic? model;
  const FollowPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Center(child: Text('المزيد من التفاصيل',style: TextStyle(color: Colors.white,fontSize: 25),),),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding:MediaQuery.of (context).padding,
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.all(MediaQuery.of (context).size.width > 500 ?20 : MediaQuery.of (context).size.width > 300 ?15:8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(borderRadius:BorderRadius.circular(20),
                        child: Image(image: AssetImage('assets/download.png'),width:MediaQuery.of (context).size.width/3,height: MediaQuery.of (context).size.height/3,fit: BoxFit.fill,)),
                    SizedBox(width: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width/2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('${model?.description}',textAlign: TextAlign.right,maxLines: 10,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize:MediaQuery.of (context).size.width > 500 ?28 : MediaQuery.of (context).size.width > 300 ?20:10,),),
                          Text('Published At : ${model?.publishedAt}',style: TextStyle(color: Colors.grey,fontSize:MediaQuery.of (context).size.width > 500 ?15 : MediaQuery.of (context).size.width > 300 ?10:8),),
                          Text('Author : ${model?.author}',style: TextStyle(color: Colors.grey,fontSize:MediaQuery.of (context).size.width > 500 ?15 : MediaQuery.of (context).size.width < 300 ?10:8),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child:ListView(
                children: [
                  Padding(
                    padding:EdgeInsets.all(15.0),
                    child: Text('${model.content??' '}',textAlign: TextAlign.right,maxLines: 10,style: TextStyle(color: Colors.white70,fontSize: 20),),
                  ),
                  TextButton(
                      onPressed: ()async{
                    final Uri url = Uri.parse('${model.url}');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  }, child:Text('لمتابعة الخبر , اضغط هنا ..',style: TextStyle(color: Colors.lightBlueAccent,decoration: TextDecoration.underline),))
                ],
              ),
            ),
            footerSection(context)
          ],
        ),
      ),
    );
  }

}
