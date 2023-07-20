import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/cubit_login/cubit.dart';
import 'package:shopapp/cubit/cubit_login/states.dart';
import 'package:shopapp/module/layout/layout_screen.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shopapp/module/register/register_screen.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/network/cache_helper.dart';

import '../../shared/components.dart';

class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              // showToast(
              //   text: state.loginModel.message,
              //   state: ToastStates.SUCCESS
              // );
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then((value) {
                token = state.loginModel.data!.token;

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Layoutscreen(),
                    ),
                    (route) => false);
              });
            } else {
              showToast(
                  text: state.loginModel.message, state: ToastStates.SUCCESS);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Login now to browse out hot offers',
                      style: TextStyle(
                          fontSize: 15.0,
                          //fontWeight: FontWeight.w900,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your text";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      // onChanged: (value){
                      //   NewsCubit.get(context).getSearch(value);
                      // },
                      obscureText: ShopLoginCubit.get(context).isPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Password";
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          icon: Icon(ShopLoginCubit.get(context).suffix),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => MaterialButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          color: Colors.blue,
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                          },
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
