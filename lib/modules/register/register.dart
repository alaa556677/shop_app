import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_layout.dart';
import '../../shared/component/component.dart';
import '../../shared/component/cubit.dart';
import '../../shared/component/states.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/shared_preferences.dart';

class RegisterScreen extends StatelessWidget{
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if (state is RegisterSuccessAppState){
            if(state.registerModel.status == true){
              print(state.registerModel.message);
              CacheHelper.saveData(key: 'isLogin', value: chooseScreen(ChooseScreen.success));
              CacheHelper.saveData(key: 'token', value: state.registerModel.data?.token).then((value){
                token = state.registerModel.data!.token ;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeLayout()),
                        (Route<dynamic> route) => false);
              });
              buildToastBuilder(
                  message: '${state.registerModel.message}',
                  state: ToastStates.success
              );
            }else{
              CacheHelper.saveData(key: 'isLogin', value: chooseScreen(ChooseScreen.error));
              print(state.registerModel.message);
              buildToastBuilder(
                  message: '${state.registerModel.message}',
                  state: ToastStates.error
              );
            }
          }
        },
        builder: (context,state){
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
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
                          'Register',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const  SizedBox(height: 15,),
                        Text(
                          'Register now to browse our offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                              fontSize: 18
                          ),
                        ),
                        const SizedBox(height: 30,),
                        defaultTextFormField(
                          title: 'Name',
                          type: TextInputType.name,
                          validate: (value){
                            if (value.isEmpty){
                              return 'you must enter your name';
                            }
                            return null;
                          },
                          controller: nameController,
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 20,),
                        defaultTextFormField(
                          title: 'Phone',
                          type: TextInputType.number,
                          validate: (value){
                            if (value.isEmpty){
                              return 'you must enter your phone';
                            }
                            return null;
                          },
                          controller: phoneController,
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 20,),
                        defaultTextFormField(
                          title: 'Email Address',
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if (value.isEmpty){
                              return 'you must enter your email';
                            }
                            return null;
                          },
                          controller: emailController,
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 20,),
                        defaultTextFormField(
                          title: 'Password',
                          type: TextInputType.number,
                          validate: (value){
                            if (value.isEmpty){
                              return 'you must enter Password';
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
                          condition: state is! RegisterLoadingAppState,
                          builder: (context) => defaultButton(
                            title: 'REGISTER',
                            press: (){
                              if (formKey.currentState!.validate()){
                                cubit.userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
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