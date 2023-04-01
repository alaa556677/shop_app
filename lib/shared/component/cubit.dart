import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/categories_screen/categories.dart';
import 'package:shop_app/modules/favorite_screen/favourites.dart';
import 'package:shop_app/modules/product_screen/product_screen.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/states.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../../models/categories_model/categories_model.dart';
import '../../models/change_model/change_model.dart';
import '../../models/favorite_model/favorites_model.dart';
import '../../models/register_model/register_model.dart';
import '../../models/settings_model/settings_model.dart';
import '../constants/constants.dart';
import '../end_point/end_point.dart';

class AppCubit extends Cubit <AppStates>{
  AppCubit():super(InitialAppState());
  static AppCubit get (context) => BlocProvider.of(context);

  bool isLast = false;
  changeIsLast(int index){
    if (index == boarding.length-1){
      isLast = true;
      print('last');
      emit(MoveToLoginTrue());
    }else{
      isLast = false;
      print('not last');
      emit(MoveToLoginFalse());
    }
  }
}

class LoginCubit extends Cubit <ShopLoginStates>{
  LoginCubit():super(InitialLoginState());
  static LoginCubit get (context) => BlocProvider.of(context);

  late LoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
  }){
    emit(LoginLoadingAppState());
    DioHelper.postData(
        url: login,
        data: {
          'email' : email,
          'password' : password,
        }
    ).then((value){
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessAppState(loginModel));
    }).catchError((error){
      print(error);
      // emit(LoginErrorAppState(error));
    });
  }

  bool isPass = true;
  changePasswordMode (){
    isPass = !isPass;
    emit(ChangePasswordMode());
  }
}

class HomeLayoutCubit extends Cubit <HomeLayoutStates>{
  HomeLayoutCubit():super(InitialHomeLayoutState());
  static HomeLayoutCubit get (context) => BlocProvider.of(context);

  int bottomIndex = 0 ;
  changeBottomIndex (index){
    bottomIndex = index;
    emit(ChangeBottomIndex());
  }
  List screens = [
    Products(),
    Categories(),
    Favorites(),
    Settings(),
  ];

  signOut(String key,context,widget){
    CacheHelper.removeData(key: key).then((value){
      if(value!){
        navigateAndFinish(context, widget);
      }
    });
  }

  HomeLayoutModel? homeModel;
  Map <int?,bool?> favoritesList = {};
  void getDataHome(){
    emit(HomeLoadingAppState());
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value){
      homeModel = HomeLayoutModel.fromJson(value.data);
      homeModel?.data?.products.forEach((e){
        favoritesList.addAll({
          e.id : e.inFavorites,
        });
      });
      emit(HomeSuccessAppState(homeModel!));
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorAppState(error.toString()));
    });
  }

  late CategoriesModel categoriesModel;
  void getDataCategories(){
    DioHelper.getData(
      url: categories,
      token: token,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessAppState());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesErrorAppState(error));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites (int? id){
    favoritesList[id] =!favoritesList[id]!;
    emit(FavoritesSuccess());
    DioHelper.postData(
        url: favorites,
        token: token,
        data: {
          'product_id' : id,
        }
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel?.status == false){
        favoritesList[id] =!favoritesList[id]!;
      }else{
        getFavorites();
      }
      emit(FavoritesSuccessAppState(changeFavoritesModel!));
    }).catchError((error){
      favoritesList[id] =!favoritesList[id]!;
      emit(FavoritesErrorAppState(error));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(FavoritesScreenLoading());
    DioHelper.getData(
      url: favorites,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(FavoritesScreenSuccess());
    }).catchError((error){
      print(error.toString());
      emit(FavoritesScreenError());
    });
  }

  SettingsModel? userData;
  void getSettings(){
    emit(GetProfileLoading());
    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value){
      userData = SettingsModel.fromJson(value.data);
      print('get profile');
      print(userData?.data?.name);
      emit(GetProfileSuccess(userData!));
    }).catchError((error){
      print(error);
      emit(GetProfileError(error));
    });
  }

  void updateData({
    required String name,
    required String phone,
    required String email,
}){
    DioHelper.putData(
      url: updateProfile,
      token: token,
      data: {
        'name' : name,
        'phone':phone,
        'email':email,
      }
    ).then((value){
      userData = SettingsModel.fromJson(value.data);
      print('update profile');
      print(userData?.data?.name);
      emit(UpdateProfileSuccessAppState(userData!));
    }).catchError((error){
      print(error);
      emit(UpdateProfileErrorAppState(error));
    });
  }

}

class RegisterCubit extends Cubit <ShopRegisterStates>{
  RegisterCubit():super(InitialRegisterState());
  static RegisterCubit get (context) => BlocProvider.of(context);

  late RegisterModel registerModel;
  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
    String? image,
  }){
    emit(RegisterLoadingAppState());
    DioHelper.postData(
        url: register,
        data: {
          'name' : name,
          'phone' : phone,
          'email' : email,
          'password' : password,
        }
    ).then((value){
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessAppState(registerModel));
    }).catchError((error){
      print(error);
      emit(RegisterErrorAppState(error));
    });
  }

  bool isPass = true;
  changePasswordMode (){
    isPass = !isPass;
    emit(RegisterChangePasswordMode());
  }
}

class SearchCubit extends Cubit <SearchStates>{
  SearchCubit() : super(InitialSearchState());
  static SearchCubit get (context) => BlocProvider.of(context);

  SearchModel? model;
  void searchData(String text){
    emit(SearchLoading());
    DioHelper.postData(
        url: search,
        token: token,
        data: {
          'text' : text
        }
    ).then((value){
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccess());
    }).catchError((error){
      print(error.toString());
      emit(SearchError());
    });
  }
}