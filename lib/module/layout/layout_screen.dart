import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_cubit.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_states.dart';
import 'package:shopapp/module/search_screen.dart';


class Layoutscreen extends StatelessWidget {


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit ,ShopState>(
      listener: (context,state)=> ShopCubit(),
      builder:(context,state) {
        var cubit =  ShopCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text("salla"),
          actions: [
            IconButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),)); 
                },
                icon: Icon(Icons.search)
            )
          ],
        ),
        body: cubit.bottomScreen[cubit.currentState],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            cubit.ChangeBottom(index);
          },
          currentIndex: cubit.currentState,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),

          ],
        ),
      );
      },
    );
  }
}
