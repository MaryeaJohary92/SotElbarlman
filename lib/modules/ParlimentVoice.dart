import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wep_project/shared/network/remote/firebase.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import 'ParlimentFollowPage.dart';
late FireBase db= new FireBase();
String id='';
class PalimentVoice extends StatefulWidget {
  const PalimentVoice({Key? key, this.state}) : super(key: key);
  final state;

  @override
  State<PalimentVoice> createState() => _PalimentVoiceState();
}

class _PalimentVoiceState extends State<PalimentVoice> {
  List? dataList=db.personsData;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WebsiteCubit,WebsiteStates>(
      listener:(BuildContext context,WebsiteStates state){},
      builder:(BuildContext context,WebsiteStates state){
        return  FutureBuilder(
          future:FirebaseFirestore.instance.collection('persons').where("state",isEqualTo: widget.state.toString()).get(),
          builder:(context,snapshot){
            if(snapshot.hasError)
              print('error with firebase');
            if(snapshot.connectionState == ConnectionState.done)
            {
              return ConditionalBuilder(
                condition: snapshot.hasData,
                builder:(context)=> Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black45,
                    title: Center(child: Text('عالم البرلمان',style: TextStyle(color: Colors.white,fontSize: 25),),),
                  ),
                  backgroundColor: bgColor,
                  body: Padding(
                    padding:EdgeInsets.symmetric(horizontal:20),
                    child: Column(
                      children: [
                        Expanded(
                          flex:10,
                          child:GridView.count(
                            crossAxisCount: MediaQuery.of (context).size.width > 500 ? 7 : 2,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                            children:List.generate(
                                snapshot.data?.docs.length as int
                                , (index)=>buildParlimentVoiceCart(context,snapshot.data?.docs[index])
                            ),
                          ) ,
                        ),
                        footerSection(context)
                      ],
                    ),
                  ),
                ),
                fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.red,),) ,
              ) ;
            }
            return Center(child: CircularProgressIndicator(color: Colors.red,),);
          },
        );
      }
    );
  }
}

/*GridView.count(
                crossAxisCount: MediaQuery.of (context).size.width > 500 ?7 : MediaQuery.of (context).size.width < 300 ?3:2,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,
                children:List.generate(cubit.sportsArticles.length, (index) => buildNewsCart(context,cubit.sportsArticles[index])
                ),
              )*/