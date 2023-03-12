import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/screens/widgets/article_item.dart';
class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
    listener: (context,state){},
      builder: (BuildContext context, state) {
      List list = NewsCubit.get(context).search;
        return Scaffold(
          appBar:AppBar(
            title: TextFormField(
              onChanged: (search){
                NewsCubit.get(context).getSearch(search);
              },
              decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.search),
                  label: const Text('search')
              ),
              controller: searchController,
              keyboardType: TextInputType.text,
              validator: (val){
                if(val!.isEmpty){
                  return 'search must not be empty';
                }
                return null;
              },
              maxLines: 2,
            ),
          ),
          body:list.isEmpty ? const Center(child: Text('No search'),) : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index) => buildArticleItem(list[index],context),
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: 10,
          ));
    
      },);

  }

}
    
