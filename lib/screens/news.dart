import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/screens/search_screen.dart';
import 'package:news/screens/widgets/article_item.dart';


class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, states) {},
      builder: (BuildContext context, Object? state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('news App'),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());
              }, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {
                cubit.changeModeApp();
              }, icon: const Icon(Icons.brightness_4_outlined)),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {

            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeIndexNavBar(index);
            },
          ),
        );
      },
    );
  }
}
