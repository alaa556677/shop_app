import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/cubit.dart';
import 'package:shop_app/shared/component/states.dart';

class HomeLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
               'Soo Shop',
                style: Theme.of(context).textTheme.headline5,
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(context, Search());
                    },
                    icon: const Icon(Icons.search, color: Colors.black,),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits), label: 'Products'),
                BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
              onTap: (index){
                cubit.changeBottomIndex(index);
              },
            ),
            body: cubit.screens[cubit.bottomIndex],
          );
        },
    );
  }
}

// onBoarding?LoginScreen():OnBoarding_Screen(),