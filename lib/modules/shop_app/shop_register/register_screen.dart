import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hexcolor/hexcolor.dart';

import '../../../shared/compononse/components.dart';
import '../../../shared/compononse/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../shop_layout.dart';
import '../shop_login/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        builder: (BuildContext context, state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: HexColor('#E389B9'),
                          ),
                        ),
                        Text(
                          'register now to browse our hot offer',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone Number';
                            }
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone_android,
                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          type: TextInputType.visiblePassword,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVsibility();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! ShopRegisterLoading,
                          builder: (context) => defaultButton(
                            background: HexColor('#E389B9'),
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              }

                            },
                            text: 'rigister',

                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFFE389B9)),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      listener: (BuildContext context, state) {
        if (state is ShopRegisterSuccess) {
          if (state.loginModel.status) {
            print(state.loginModel.message);
            print(state.loginModel.data.token);
            CacheHelper.saveData(key: 'token',
                value: state.loginModel.data.token
            ).then((value){
              token=state.loginModel.data.token;
              navigateAndFinish(
                  context, ShopLayout()
              );
            });

          }
          else {
            print(state.loginModel.message);
            showToast(
                text: state.loginModel.message, state: ToastState.ERROR);

          }
        }
      },
      ),
    );
  }
}
