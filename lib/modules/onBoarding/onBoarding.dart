import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/component/cubit.dart';
import 'package:shop_app/shared/component/states.dart';
import '../../shared/component/component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/shared_preferences.dart';

class OnBoarding_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController pc = PageController(viewportFraction: 1);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          void submit(){
            CacheHelper.saveData(
                key: 'onBoarding',
                value: true
            ).then((value){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
            });
          }
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                defaultTextButton(
                  press: submit,
                  title: 'Skip',
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pc,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      cubit.changeIsLast(index);
                    },
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                  child: Row(
                    children: [
                      SmoothPageIndicator(
                        controller: pc,
                        count: boarding.length,
                        effect: const ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue,
                          dotHeight: 15,
                          dotWidth: 15,
                          expansionFactor: 3,
                        ),
                      ),
                      const Spacer(),
                      FloatingActionButton(
                        onPressed: () {
                          if (cubit.isLast) {
                           submit();
                          } else {
                            pc.nextPage(
                                duration: const Duration(microseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        },
                        mini: true,
                        child: const Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
    );
  }
}
