import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/screens/widgets/article_item.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
class Sports extends StatelessWidget {
  const Sports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state){

      },
      builder: (context,state){
        List sports = NewsCubit.get(context).sports;
        return ConditionalBuilder(
          condition:sports.length > 0,
          builder:(context)=> ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index) => buildArticleItem(sports[index],context),
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: 10,
          ),
          fallback:(context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
