import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/StatesModel.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class StatePage extends StatefulWidget {
  const StatePage({Key? key}) : super(key: key);

  @override
  State<StatePage> createState() => _StatePageState();
}
List<States> states=[];
class _StatePageState extends State<StatePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WebsiteCubit,WebsiteStates>(
        listener:(BuildContext context,WebsiteStates state){},
      builder: (BuildContext context,WebsiteStates state){
          WebsiteCubit cubit=WebsiteCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.states.isNotEmpty,
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
                    flex: 8,
                    child:Padding(
                      padding:EdgeInsets.symmetric(vertical: 10),
                      child: GridView.count(
                        crossAxisCount: MediaQuery.of (context).size.width > 500 ? 7 : 2,
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 7,
                        children:List.generate(
                            cubit.states.length
                            , (index)=>stateParlimentBuilder(context,cubit.states[index])
                        ),
                      ),
                    ) ,
                  ),
                  footerSection(context)
                ],
              ),
            ),
          ),
          fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.red,),) ,
        );
      },
    );
  }
}
