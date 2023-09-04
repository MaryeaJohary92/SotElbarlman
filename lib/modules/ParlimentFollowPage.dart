import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:wep_project/shared/network/remote/firebase.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';

class ParlimentDetailsPage extends StatefulWidget {
  const ParlimentDetailsPage({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  State<ParlimentDetailsPage> createState() => _ParlimentDetailsPageState();
}

class _ParlimentDetailsPageState extends State<ParlimentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future:  FirebaseFirestore.instance.collection('persons').doc(widget.id.toString()).get(),
      builder:(context,upperSnapShot)=> FutureBuilder(
        future: FirebaseFirestore.instance.collection('البيانات').where('id'.toString(), isEqualTo:widget.id.toString()).orderBy('time').get(),
        builder:(context,snapshot) =>ConditionalBuilder(
          condition:snapshot.connectionState==ConnectionState.done && upperSnapShot.connectionState==ConnectionState.done ,
          builder:(context)=> Scaffold(
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
                              child: Image(image: NetworkImage('${upperSnapShot.data!['imgURL']}'),width:MediaQuery.of (context).size.width/3,height: MediaQuery.of (context).size.height/3,fit: BoxFit.fill,)),
                          SizedBox(width: 20,),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width/2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                upperSnapShot.data!['male']==true?Text(' النائب : ${upperSnapShot.data!['name']}',overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 20),):Text(' النائبه : ${upperSnapShot.data!['name']}',overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 20),),
                                Text('رمز : غير معروف',overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: Colors.white70),),
                                Text(' المحافظه : ${upperSnapShot.data!['state']}',style: TextStyle(color: Colors.grey,fontSize:MediaQuery.of (context).size.width > 500 ?20 : MediaQuery.of (context).size.width > 300 ?15:8),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ListView(
                      children:List.generate(snapshot.data!.docs.length, (index) => textList(snapshot.data!.docs[index])),
                    ),
                  ),
                  footerSection(context)
                ],
              ),
            ),
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator(color: Colors.red,),) ,
        ),
      ),
    );
  }
  Widget textList(text){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:Text('${text['post']??' '}',textAlign: TextAlign.right,maxLines: 12,style: TextStyle(color: Colors.white70,fontSize: 20,overflow: TextOverflow.visible),),

    );
  }
}
