import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../shared/compononse/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopSearchScreen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultTextFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'enter text to search';
                            }
                            return null;
                          },
                          onSubmit: ( String text) {

                              SearchCubit.get(context).search(text);
                          },

                          label: 'Search',
                          prefix: Icons.search),
                      SizedBox(height: 10.0,),
                      if(state is SearchLoadingState)
                      LinearProgressIndicator(
                        valueColor:AlwaysStoppedAnimation<Color> (
                            Color(0xFFE389B9)),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProducts(SearchCubit.get(context).model?.data?.data?[index],context,isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context).model?.data?.data?.length ?? 0,

                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
