import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/shared_preferences.dart';
import '../../shared/component/cubit.dart';
import '../../shared/component/states.dart';
import '../../shared/constants/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class LoginScreen extends StatelessWidget{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey <FormState> ();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <LoginCubit,ShopLoginStates>(
        listener: (context,state){
          if (state is LoginSuccessAppState){
            if(state.loginModel.status){
              print(state.loginModel.message);
              CacheHelper.saveData(key: 'isLogin', value: chooseScreen(ChooseScreen.success));
              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value){
                token = state.loginModel.data!.token ;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeLayout()),
                    (Route<dynamic> route) => false);
              });
              buildToastBuilder(
                  message: state.loginModel.message,
                  state: ToastStates.success
              );
            }else{
              CacheHelper.saveData(key: 'isLogin', value: chooseScreen(ChooseScreen.error));
              print(state.loginModel.message);
              buildToastBuilder(
                  message: state.loginModel.message,
                  state: ToastStates.error
              );
            }
          }
        },
        builder: (context,state){
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const  SizedBox(height: 15,),
                        Text(
                          'Login now to browse our offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                              fontSize: 18
                          ),
                        ),
                        const SizedBox(height: 30,),
                        defaultTextFormField(
                          title: 'Email Address',
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if (value.isEmpty){
                              return 'you must enter your email for login';
                            }
                            return null;
                          },
                          controller: emailController,
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 20,),
                        defaultTextFormField(
                          title: 'Password',
                          onSubmitted: (value){
                            if (formKey.currentState!.validate()){
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                            }
                          },
                          type: TextInputType.number,
                          validate: (value){
                            if (value.isEmpty){
                              return 'you must enter Password for login';
                            }
                            return null;
                          },
                          controller: passwordController,
                          prefix: Icons.lock,
                          suffix: cubit.isPass? Icons.visibility_off : Icons.visibility,
                          isPassword: cubit.isPass,
                          suffixPressed: (){
                            cubit.changePasswordMode();
                          },
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingAppState,
                          builder: (context) => defaultButton(
                            title: 'LOGIN',
                            press: (){
                              if (formKey.currentState!.validate()){
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have account?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            defaultTextButton(
                              color: Colors.blue,
                              size: 18,
                              title: 'Register Now',
                              press: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                                );
                              }
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}