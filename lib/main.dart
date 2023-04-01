import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/onBoarding/onBoarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/cubit.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/shared_preferences.dart';
import 'layout/home_layout.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding;
  Widget widget;
  CacheHelper.getData(key: 'onBoarding') != null ? onBoarding = CacheHelper.getData(key: 'onBoarding') : onBoarding = false;
  CacheHelper.getData(key: 'token') != null ? token = CacheHelper.getData(key: 'token') : token = 'empty';
  if(onBoarding == true){
    if(token != 'empty'){
      widget = HomeLayout();
    }else{
      widget = LoginScreen();
    }
   }else{
    widget = OnBoarding_Screen();
   }
  print(token);
  print(onBoarding);
  runApp(MyApp(widget,));
}
class MyApp extends StatelessWidget{
  final Widget startWidget;
  MyApp(this.startWidget,);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit(),),
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => HomeLayoutCubit()..getDataHome()..getDataCategories()..getFavorites()..getSettings()),
          BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(create: (context) => SearchCubit()),
    ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: startWidget,
          ),
        ),
    );
  }
}

