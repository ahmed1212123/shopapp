
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_cubit.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_states.dart';


import '../shared/network/cache_helper.dart';
import 'login/login_screen.dart';

class SettingScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state)
      {

      },
      builder: (context,state){
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;


        return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context)=> Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      if (state is ShopLoadingUpdateState)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,

                        validator: (value){
                          if (value!.isEmpty)
                          {
                            return "Enter your name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),

                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,

                        validator: (value){
                          if (value!.isEmpty){
                            return "Enter your Email";
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
                      SizedBox(height: 20),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,

                        validator: (value){
                          if (value!.isEmpty){
                            return "Enter your phone";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),

                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 60,
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: ()
                          {

                                ShopCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                          },
                          child: Text(
                            'update'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 60,
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: ()
                          {
                            CacheHelper.removeData(key: 'token',).then((value) {
                              if (value == true) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                        (route) => false);
                              }
                            });
                          },
                          child: Text(
                            'LOGOUT',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
