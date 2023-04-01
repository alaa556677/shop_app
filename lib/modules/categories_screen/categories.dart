import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/cubit.dart';

import '../../shared/component/states.dart';

class Categories extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <HomeLayoutCubit,HomeLayoutStates> (
        builder: (context, state){
          var cubit = HomeLayoutCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ListView.separated(
              itemBuilder: (context,index) => buildCatItem(cubit.categoriesModel.data!.data![index]),
              separatorBuilder: (context,index) => const SizedBox(height: 25,),
              itemCount: cubit.categoriesModel.data!.data!.length,
            ),
          );
        } , 
        listener: (context, state){}
    );
  }
}