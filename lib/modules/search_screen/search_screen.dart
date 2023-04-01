import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/cubit.dart';
import 'package:shop_app/shared/component/states.dart';

class Search extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'search',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  defaultTextFormField(
                    title: 'search',
                    type: TextInputType.text,
                    prefix: Icons.search,
                    controller: searchController,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'you must write anything';
                      }
                      return null;
                    },
                    onSubmitted: (text){
                      cubit.searchData(text);
                    }
                  ),
                  const SizedBox(height: 15,),
                  if (state is SearchLoading)
                    const LinearProgressIndicator(),
                  if (state is SearchSuccess)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index) => buildSearchItem(cubit.model!.data!.dataList[index], context),
                        separatorBuilder: (context,index) => separatedBuilder(),
                        itemCount: cubit.model!.data!.dataList.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
