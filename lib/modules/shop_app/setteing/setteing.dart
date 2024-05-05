import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/compononse/components.dart';
import '../../../shared/compononse/constants.dart';


class SetteingScreen extends StatelessWidget {
var formKey=GlobalKey<FormState>();
var nameController=TextEditingController();
var emailController=TextEditingController();
var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<ShopCubit,ShopStates>(
        builder:(BuildContext context ,state) 
          {
            // var model = ShopCubit.get(context).userModel;
            //
            // if (model != null && model.data != null) {
            //   nameController.text = model.data.name ;
            //   emailController.text = model.data.email ;
            //   phoneController.text = model.data.phone ;
            // }

            return ConditionalBuilder(
             condition: ShopCubit.get(context).userModel!=null,
             builder: (context)=>Padding(
               padding: const EdgeInsets.all(20.0),
               child: Form(
                 key: formKey,
                 child: Column(
                   children: [
                     if(state is ShopLoadingUpdateUserlStates)
                     LinearProgressIndicator(
                       valueColor:AlwaysStoppedAnimation<Color> (
                         Color(0xFFE389B9)
                       ),
                     ),
                     SizedBox(height: 20.0,),
                     defaultTextFormField(
                       controller: nameController,
                       type: TextInputType.name,
                       validate: (value){
                         if(value!.isEmpty)
                         {
                           return 'Please Enter Your Name';
                         }
                         return null;
                       },
                       label: 'Name',
                       prefix: Icons.person,
                     ),
                     SizedBox(
                       height: 20.0,
                     ),
                     defaultTextFormField(
                       controller: emailController,
                       type: TextInputType.emailAddress,
                       validate: (value){
                         if(value!.isEmpty)
                         {
                           return 'Please Enter Your Email';
                         }
                         return null;
                       },
                       label: 'Email Address',
                       prefix: Icons.email_outlined,
                     ),
                     SizedBox(
                       height: 20.0,
                     ),
                     defaultTextFormField(
                       controller: phoneController,
                       type: TextInputType.phone,
                       validate: (value){
                         if(value!.isEmpty)
                         {
                           return 'Please Enter Your Phone';
                         }
                         return null;
                       },
                       label: 'Phone',
                       prefix: Icons.phone,
                     ),
                      SizedBox(
                        height: 30.0,
                      ),
                     defaultButton(
                         function:(){
                           if(formKey.currentState!.validate())
                             {
                               ShopCubit.get(context).updateUserData(
                                   name: nameController.text,
                                   email: emailController.text,
                                   phone: phoneController.text,
                               );
                             }


                         } ,
                         text: 'update',
                       background: Color(0xFFE389B9),

                     ),

                     SizedBox(
                       height: 30.0,
                     ),
                     defaultButton(
                       function:(){
                         singOut(context);
                       } ,
                       text: 'logout',
                       background: Color(0xFFE389B9),

                     ),
                   ],
                 ),
               ),
             ),
             fallback: (context)=>Center(
               child: CircularProgressIndicator(
                 valueColor: AlwaysStoppedAnimation<Color>(
          Color(0xFFE389B9),
               ),
           ),
             ),
           );
          },
       listener: (BuildContext context, state){},
      ),
    );
  }
}
