import 'package:chats_app/modules/shop_app/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../shared/compononse/components.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: ( context, state) {  },
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              title: Text('Shopping Onlin',
            style: TextStyle(
              color: Color(0xFFE389B9),
            ),),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context,ShopSearchScreen(),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                  ),
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,

                ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,

                  ),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,

                  ),
                  label: 'Favorite'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_outlined,

                  ),
                  label: 'Account'
              ),
            ],

          ),
        );
      },

    );
  }
}
