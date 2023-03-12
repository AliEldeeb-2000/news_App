import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/screens/widgets/article_item.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state){

      },
      builder: (context,state){
        List business = NewsCubit.get(context).business;
        return ConditionalBuilder(
          condition: business.length > 0,
          builder:(context)=> ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index) => buildArticleItem(business[index],context),
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: 10,
          ),
          fallback:(context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}
