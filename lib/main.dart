import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/network/local/cashed_helper.dart';
import 'package:news/network/remote/dio_helper.dart';
import 'package:news/screens/news.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashedHelper.init();

  bool isDark = CashedHelper.getData(key: 'isDark') ?? NewsCubit().isDark;
  runApp(NewsApp(isDark: isDark,));
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key, required this.isDark});
  
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..getScience()..getSports()),
        BlocProvider(create: (context) => NewsCubit()..changeModeApp(fromShared: isDark),)
      ],
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (BuildContext context, state) {
          return MaterialApp(
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18)),
                  appBarTheme: const AppBarTheme(
                    titleSpacing:20,
                      iconTheme: IconThemeData(color: Colors.black),
                      titleTextStyle: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      )
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Colors.white,
                      elevation: 15.0
                  ),
                  floatingActionButtonTheme:const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange)
              ),
              themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              darkTheme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: const Color(0xff333739),
                  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white,fontSize: 18)),
                  appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.white),
                      titleTextStyle: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
                      backgroundColor: Color(0xff333739),
                      elevation: 0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xff333739),
                        statusBarIconBrightness: Brightness.light,
                      )
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Color(0xff333739),
                      elevation: 15.0
                  ),
                  floatingActionButtonTheme:const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange)
              ),
              title: 'News app',
              debugShowCheckedModeBanner: false,
              home: const Directionality(textDirection: TextDirection.rtl,child: News(),)
          );
        },

      ),
    );
  }
}

