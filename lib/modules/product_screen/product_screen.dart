import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/cubit.dart';
import 'package:shop_app/shared/component/states.dart';

class Products extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context,state){
        if(state is FavoritesSuccessAppState){
          if(state.model.status == false){
            buildToastBuilder(
              message: '${state.model.message}',
              state: ToastStates.error
            );
          }
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
            condition: HomeLayoutCubit.get(context).homeModel?.data != null && HomeLayoutCubit.get(context).categoriesModel.data != null ,
            builder: (context) => productsBuilder(HomeLayoutCubit.get(context).homeModel, HomeLayoutCubit.get(context).categoriesModel, context),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}