import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/states.dart';
import 'package:news/network/local/cashed_helper.dart';
import 'package:news/screens/business.dart';
import 'package:news/screens/science.dart';
import 'package:news/screens/sports.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeModeApp({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(ChangeModeAppTheme());
    }else{
      isDark = !isDark;
      CashedHelper.putData(key: 'isDark', value: isDark).then((value){emit(ChangeModeAppTheme());});
    }
  }

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
  ];

  List<Widget> screens = const [
    Business(),
    Sports(),
    Science(),
  ];

  void changeIndexNavBar(int index) {
    currentIndex = index;
    if(index == 0){
      getBusiness();
    }
    if(index == 1){
      getSports();
    }if(index == 2){
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {

    emit(NewsGetBusinessLoadingState());
    if(business.length == 0){
      DioHelper().getData(url: 'v2/top-headlines', query: {
        "country": 'eg',
        "category": 'business',
        'apiKey': '399f3da4b2b1489389ad5a7a11783c9f'
      }).then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }else{
      emit(NewsGetBusinessSuccessState());

    }

  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0){
      DioHelper().getData(url: 'v2/top-headlines', query: {
        "country": 'eg',
        "category": 'sports',
        'apiKey': '399f3da4b2b1489389ad5a7a11783c9f'
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }


  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if(science.length == 0){
      DioHelper().getData(url: 'v2/top-headlines', query: {
        "country": 'eg',
        "category": 'science',
        'apiKey': '399f3da4b2b1489389ad5a7a11783c9f'
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }


  List<dynamic> search = [];
  void getSearch(String val){
    emit(NewsGetSearchLoadingState());
      DioHelper().getData(url: 'v2/everything', query: {
        "q": val,
        'apiKey': '399f3da4b2b1489389ad5a7a11783c9f'
      }).then((value) {
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        emit(NewsGetSearchErrorState(error.toString()));
      });
    }

  }


