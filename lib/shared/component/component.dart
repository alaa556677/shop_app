import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/component/cubit.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../models/categories_model/categories_model.dart';
import '../../models/home_model/home_model.dart';
import '../../models/favorite_model/favorites_model.dart';
import '../../models/search_model/search_model.dart';

List<BoardingModel> boarding = [
  BoardingModel(
      image: 'assets/images/boarding2.png',
      title: 'On board 1 title',
      body: 'body 1'),
  BoardingModel(
      image: 'assets/images/boarding9.png', title: 'title 2', body: 'body 2'),
  BoardingModel(
      image: 'assets/images/boarding5.png', title: 'title 3', body: 'body 3'),
];

Widget buildBoardingItem(model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
          child: Text(
            '${model.title}',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
          child: Text(
            '${model.body}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

Widget defaultTextFormField({
  String? title,
  TextEditingController? controller,
  var validate,
  TextInputType? type,
  IconData? prefix,
  IconData? suffix,
  bool isPassword = false,
  var suffixPressed,
  var onSubmitted,
}) =>
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: controller,
        validator: validate,
        keyboardType: type,
        obscureText: isPassword,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
            hintText: title,
            prefixIcon: Icon(
              prefix,
              color: Colors.black45,
            ),
            suffixIcon: IconButton(
              icon: Icon(suffix),
              onPressed: suffixPressed,
            ),
            hintStyle: const TextStyle(
              color: Colors.black45,
            ),
            contentPadding: const EdgeInsetsDirectional.all(14),
            border: InputBorder.none),
      ),
    );

Widget defaultButton({
  var press,
  String? title,
}) =>
    SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: press,
        child: Text(
          '$title',
          style: const TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );

Widget defaultTextButton({
  var press,
  String? title,
  double size = 20,
  Color color = Colors.black,
}) =>
    TextButton(
        onPressed: press,
        child: Text(
          '${title?.toUpperCase()}',
          style: TextStyle(
            color: color,
            fontSize: size,
          ),
        ));

Future<bool?> buildToastBuilder({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, warning }

chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

enum ChooseScreen { success, error }

chooseScreen(ChooseScreen choose) {
  bool isLogin;
  switch (choose) {
    case ChooseScreen.success:
      isLogin = true;
      break;
    case ChooseScreen.error:
      isLogin = false;
      break;
  }
  return isLogin;
}

navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget productsBuilder(HomeLayoutModel? model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model?.data?.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  height: 250,
                  viewportFraction: 1.0,
                  reverse: false,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel.data!.data![index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 8,
                    ),
                    itemCount: categoriesModel.data!.data!.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.7,
              children: List.generate(
                model!.data!.products.length,
                (index) =>
                    buildProductItem(model.data!.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildProductItem(ProductModel model, context) {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Discount',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            model.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                '${model.price.round()} EGP',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (model.discount != 0)
                Text(
                  '${model.oldPrice.round()} EGP',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
              const Spacer(),
              IconButton(
                onPressed: (){
                  HomeLayoutCubit.get(context).changeFavorites(model.id);
                },
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: HomeLayoutCubit.get(context).favoritesList[model.id] == true ? Colors.blue : Colors.grey[300],
                  child: const Icon(
                    Icons.favorite_border,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget buildCategoryItem(CategoriesDataList categoriesDataList) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(categoriesDataList.image),
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100,
          child: Text(
            categoriesDataList.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );

Widget buildCatItem(CategoriesDataList categoriesDataList) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Image(
            image: NetworkImage(categoriesDataList.image),
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            categoriesDataList.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Spacer(),
          const Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );

Widget buildFavoritesItem(FavoritesData model, context) => Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Container(
                height: 120,
                width: 120,
                child: Image(
                  image: NetworkImage('${model.product!.image}'),
                  width: 120,
                  height: 120,
                ),
              ),
              if (model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Discount',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.product!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: (){
                            HomeLayoutCubit.get(context).changeFavorites(model.product!.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: HomeLayoutCubit.get(context).favoritesList[model.product?.id]! ? Colors.blue : Colors.grey[300],
                            child: const Icon(
                              Icons.favorite_border,
                              size : 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

Widget separatedBuilder() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        color: Colors.grey,
        height: 3,
        width: double.infinity,
      ),
    );

Widget buildSearchItem(ProductData model, context) => Container(
  height: 120,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 120,
        width: 120,
        child: Image(
          image: NetworkImage('${model.image}'),
          width: 120,
          height: 120,
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                    const Spacer(),
                    if (HomeLayoutCubit.get(context).favoritesList[model.id] != null)
                        IconButton(
                          onPressed: (){
                            HomeLayoutCubit.get(context).changeFavorites(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: HomeLayoutCubit.get(context).favoritesList[model.id]! ? Colors.blue : Colors.grey[300],
                            child: const Icon(
                              Icons.favorite_border,
                              size : 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ],
  ),
);
