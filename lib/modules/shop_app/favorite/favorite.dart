import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/compononse/components.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // Check if the state is loading favorites before displaying the UI
        if (state is ShopLoadingGetFavoritesStates) {

          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFE389B9),
              ),
            ),
          );
        } else {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesStates,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProducts(
                ShopCubit.get(context).favoritesModel!.data.data[index].product,
                context,
              ),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel?.data?.data?.length ?? 0,

            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFE389B9),
                ),
              ),
            ),
          );
        }
      }
      ,
    );
  }


}
