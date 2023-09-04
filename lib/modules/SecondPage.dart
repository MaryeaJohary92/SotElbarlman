import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WebsiteCubit,WebsiteStates>(
      listener:(BuildContext context,WebsiteStates state){},
      builder:(BuildContext context,WebsiteStates state){
        WebsiteCubit cubit = WebsiteCubit.get(context);
        return ConditionalBuilder(
          condition:state is GetWebsiteNewsSportsSuccessState || state is GetWebsiteNewsBusinessSuccessState || state is WebsiteChangeNavigationOfPagesState ,
          builder:(context)=> Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black45,
              title: Center(child: Text('عالم العلوم',style: TextStyle(color: Colors.white,fontSize: 25),),),
            ),
            backgroundColor: bgColor,
            body: Padding(
              padding:EdgeInsets.symmetric(horizontal:20),
              child: Column(
                children: [
                  Expanded(child: buildCrousalBusiness(context),flex: 4,),
                  Expanded(
                    flex: 8,
                    child: GridView.count(
                      crossAxisCount: MediaQuery.of (context).size.width > 500 ?7 :2,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                      children:List.generate(cubit.businessArticles!.articles.length, (index) => buildBusinessNewsCart(context,cubit.businessArticles!.articles[index])
                      ),
                    ),
                  ),
                  footerSection(context)
                ],
              ),
            ),
          ),
          fallback: (context)=> const Center(child: CircularProgressIndicator(color: Colors.red,)),
        );
      },
    );
  }
}
