import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../shared/component/states.dart';

class Favorites extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <HomeLayoutCubit,HomeLayoutStates> (
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeLayoutCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConditionalBuilder (
            condition: state is !FavoritesScreenLoading,
            builder: (context) =>  ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => buildFavoritesItem(cubit.favoritesModel!.data!.data[index], context) ,
              separatorBuilder: (context, index) => separatedBuilder(),
              itemCount: cubit.favoritesModel!.data!.data.length,
            ),
            fallback: (context)=> const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}