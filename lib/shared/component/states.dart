import 'package:shop_app/models/change_model/change_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';

import '../../models/register_model/register_model.dart';
import '../../models/settings_model/settings_model.dart';

abstract class AppStates{}
class InitialAppState extends AppStates{}
class MoveToLoginTrue extends AppStates{}
class MoveToLoginFalse extends AppStates{}

abstract class ShopLoginStates{}
class InitialLoginState extends ShopLoginStates{}
class LoginSuccessAppState extends ShopLoginStates{
  final LoginModel loginModel;
  LoginSuccessAppState(this.loginModel);
}
class LoginLoadingAppState extends ShopLoginStates{}
class LoginErrorAppState extends ShopLoginStates{
  final String error;
  LoginErrorAppState(this.error);
}
class ChangePasswordMode extends ShopLoginStates{}

abstract class HomeLayoutStates{}
class InitialHomeLayoutState extends HomeLayoutStates{}
class ChangeBottomIndex extends HomeLayoutStates{}
class HomeSuccessAppState extends HomeLayoutStates{
  final HomeLayoutModel homeModel;
  HomeSuccessAppState(this.homeModel);
}
class HomeLoadingAppState extends HomeLayoutStates{}
class HomeErrorAppState extends HomeLayoutStates{
  final String error;
  HomeErrorAppState(this.error);
}
class ChangeFavoriteButton extends HomeLayoutStates{}

class CategoriesSuccessAppState extends HomeLayoutStates{}
class CategoriesErrorAppState extends HomeLayoutStates{
  final String error;
  CategoriesErrorAppState(this.error);
}

class FavoritesSuccessAppState extends HomeLayoutStates{
  final ChangeFavoritesModel model;
  FavoritesSuccessAppState(this.model);
}
class FavoritesErrorAppState extends HomeLayoutStates{
  final String error;
  FavoritesErrorAppState(this.error);
}
class FavoritesSuccess extends HomeLayoutStates{}

class FavoritesScreenSuccess extends HomeLayoutStates{}
class FavoritesScreenLoading extends HomeLayoutStates{}
class FavoritesScreenError extends HomeLayoutStates{}

class GetProfileLoading extends HomeLayoutStates{}
class GetProfileSuccess extends HomeLayoutStates{
  final SettingsModel model;
  GetProfileSuccess(this.model);
}
class GetProfileError extends HomeLayoutStates{
  final error;
  GetProfileError(this.error);
}

abstract class ShopRegisterStates{}
class InitialRegisterState extends ShopRegisterStates{}
class RegisterSuccessAppState extends ShopRegisterStates{
  final RegisterModel registerModel;
  RegisterSuccessAppState(this.registerModel);
}
class RegisterLoadingAppState extends ShopRegisterStates{}
class RegisterErrorAppState extends ShopRegisterStates{
  final error;
  RegisterErrorAppState(this.error);
}
class RegisterChangePasswordMode extends ShopRegisterStates{}

class UpdateProfileSuccessAppState extends HomeLayoutStates{
  final SettingsModel Model;
  UpdateProfileSuccessAppState(this.Model);
}
class UpdateProfileLoadingAppState extends HomeLayoutStates{}
class UpdateProfileErrorAppState extends HomeLayoutStates{
  final error;
  UpdateProfileErrorAppState(this.error);
}

abstract class SearchStates{}
class InitialSearchState extends SearchStates{}
class SearchSuccess extends SearchStates{}
class SearchError extends SearchStates{}
class SearchLoading extends SearchStates{}