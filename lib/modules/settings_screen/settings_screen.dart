import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/Login.dart';
import 'package:shop_app/shared/component/cubit.dart';
import 'package:shop_app/shared/component/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../shared/component/component.dart';

class Settings extends StatelessWidget{
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey <FormState> ();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <HomeLayoutCubit,HomeLayoutStates> (
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeLayoutCubit.get(context);
        cubit.userData!.data!.name != null ? nameController.text = cubit.userData!.data!.name : null;
        cubit.userData!.data!.email != null ? emailController.text = cubit.userData!.data!.email : null;
        cubit.userData!.data!.phone != null ? phoneController.text = cubit.userData!.data!.phone : null;
        return ConditionalBuilder(
          condition: cubit.userData != null,
          builder: (context) =>  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is UpdateProfileLoadingAppState)
                    LinearProgressIndicator(),
                  const SizedBox(height: 15,),
                  defaultTextFormField(
                    title: 'Name',
                    prefix: Icons.person,
                    type: TextInputType.name,
                    validate: (value){
                      if(value.isEmpty){
                        return 'Name mustn\'t  be empty';
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  const SizedBox(height: 15,),
                  defaultTextFormField(
                    title: 'Email',
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value.isEmpty){
                        return 'Email mustn\'t  be empty';
                      }
                      return null;
                    },
                    controller: emailController,
                  ),
                  const SizedBox(height: 15,),
                  defaultTextFormField(
                    title: 'Phone',
                    prefix: Icons.phone,
                    type: TextInputType.number,
                    validate: (value){
                      if(value.isEmpty){
                        return 'Phone mustn\'t  be empty';
                      }
                      return null;
                    },
                    controller: phoneController,
                  ),
                  const SizedBox(height: 15,),
                  defaultButton(
                      title: 'UPDATE',
                      press: (){
                        if(formKey.currentState!.validate()){
                          cubit.updateData(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        }
                      }
                  ),
                  const SizedBox(height: 15,),
                  defaultButton(
                    title: 'LOGOUT',
                    press: (){
                      cubit.signOut('token', context, LoginScreen());
                    }
                  )
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

