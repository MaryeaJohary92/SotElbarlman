import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wep_project/shared/cubit/cubit.dart';
import 'package:wep_project/shared/cubit/states.dart';
import '../shared/components/constants.dart';


class MyHomePage extends StatefulWidget{
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  int index=0;

@override
  void initState() {
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>WebsiteCubit()..getBusinessArticles()..getSportsArticles()..getStates(),
    child: BlocConsumer<WebsiteCubit,WebsiteStates>(
      listener: (BuildContext context,WebsiteStates state){},
      builder: (BuildContext context,WebsiteStates state){
        WebsiteCubit cubit=WebsiteCubit.get(context);
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).padding.horizontal),
          color: Colors.white,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: scaffKeyHomePage,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 10,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(backgroundImage: AssetImage('assets/logoBig.png'),radius: MediaQuery.of (context).size.width > 500 ?15 : MediaQuery.of (context).size.width < 300 ?8:10,),
                    SizedBox(width: MediaQuery.of (context).size.width > 500 ?10 : MediaQuery.of (context).size.width < 300 ?5:8,),
                    Text('صوت البرلمان',style: TextStyle(color:Colors.brown,fontSize:MediaQuery.of (context).size.width > 500 ?30 : MediaQuery.of (context).size.width < 300 ?10:15),),
                  ],
                ),
                iconTheme: IconThemeData(size:MediaQuery.of (context).size.width > 500 ?25 : MediaQuery.of (context).size.width < 300 ?15:20,color: Colors.brown),
                actions: [
                  CircleAvatar(
                    backgroundColor: Colors.indigo,
                    backgroundImage: AssetImage('assets/facebook.png',),
                    radius: MediaQuery.of(context).size.width>500?25:MediaQuery.of(context).size.width<300?10:15,
                  ),
                  SizedBox(width: 5,),
                  CircleAvatar(
                    backgroundColor: Colors.purple,
                    backgroundImage: AssetImage('assets/instagram.jpg',),
                    radius: MediaQuery.of(context).size.width>500?25:MediaQuery.of(context).size.width<300?10:15,
                  ),
                  SizedBox(width: 5,),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage('assets/whatsapp.jpg',),
                    radius: MediaQuery.of(context).size.width>500?25:MediaQuery.of(context).size.width<300?10:15,
                  ),
                ],
              ),
              drawer: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width/2,
                color: Colors.grey.shade800,
                child:Column(
                  children: [
                    Padding(padding:EdgeInsets.symmetric(horizontal: 10),child: Divider(color: Colors.white,thickness: 1,), ),
                    ListTile(
                      onTap: (){
                        cubit.changeIndex(0,context);
                      },
                      title: Row(
                        children: [
                          Icon(Icons.home,color: Colors.white,size:MediaQuery.of (context).size.width > 500 ?30 : MediaQuery.of (context).size.width < 300 ?20:10,),
                          SizedBox(width: 5,),
                          Text('الصفحه الرئيسيه',style: TextStyle(color: Colors.white,fontSize:MediaQuery.of (context).size.width > 500 ?drawerTextSizeMoreThan500 : MediaQuery.of (context).size.width < 300 ?drawerTextSizeLessThan300:drawerTextSizeMoreThan300),)
                        ],
                      ),
                    ),
                    Padding(padding:EdgeInsets.symmetric(horizontal: 10),child: Divider(color: Colors.white,thickness: 1,), ),
                    ListTile(
                      onTap: (){
                        cubit.changeIndex(1,context);
                      },
                      title: Row(
                        children: [
                          Icon(Icons.speaker_phone,color: Colors.white,size:MediaQuery.of (context).size.width > 500 ?30 : MediaQuery.of (context).size.width < 300 ?20:10,),
                          SizedBox(width: 10,),
                          Text('عالم البرلمان',style: TextStyle(color: Colors.white,fontSize:MediaQuery.of (context).size.width > 500 ?drawerTextSizeMoreThan500 : MediaQuery.of (context).size.width < 300 ?drawerTextSizeLessThan300:drawerTextSizeMoreThan300),)
                        ],
                      ),

                          ),
                          Padding(padding:EdgeInsets.symmetric(horizontal: 10),child: Divider(color: Colors.white,thickness: 1,), ),
                          ListTile(
                            onTap: (){
                              cubit.changeIndex(2,context);
                            },
                            title: Row(
                              children: [
                                Icon(Icons.sports_basketball,color: Colors.white,size:MediaQuery.of (context).size.width > 500 ?30 : MediaQuery.of (context).size.width < 300 ?20:10,),
                                SizedBox(width: 10,),
                                Text('اخبار الرياضه',style: TextStyle(color: Colors.white,fontSize:MediaQuery.of (context).size.width > 500 ?drawerTextSizeMoreThan500 : MediaQuery.of (context).size.width < 300 ?drawerTextSizeLessThan300:drawerTextSizeMoreThan300),)
                              ],
                            ),

                          ),
                          Padding(padding:EdgeInsets.symmetric(horizontal: 10),child: Divider(color: Colors.white,thickness: 1,), ),
                          ListTile(
                            onTap: (){
                              cubit.changeIndex(3,context);
                            },
                            title: Row(
                              children: [
                                Icon(Icons.business_outlined,color: Colors.white,size:MediaQuery.of (context).size.width > 500 ?30 : MediaQuery.of (context).size.width < 300 ?20:10,),
                                SizedBox(width: 10,),
                                Text('عالم العلوم',style: TextStyle(color: Colors.white,fontSize:MediaQuery.of (context).size.width > 500 ?drawerTextSizeMoreThan500 : MediaQuery.of (context).size.width < 300 ?drawerTextSizeLessThan300:drawerTextSizeMoreThan300),)
                              ],
                            ),

                          ),
                          Padding(padding:EdgeInsets.symmetric(horizontal: 10),child: Divider(color: Colors.white,thickness: 1,), ),

                        ],
                      )
                  ),
                  body:cubit.widgets[cubit.selectedIndex]
              ) ,

          ),
        );
      },
    ),
    );
  }
}