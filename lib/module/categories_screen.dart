
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_cubit.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_states.dart';
import 'package:shopapp/models/categories_model.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context , state){},
        builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildCategories(ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context,index)=>Divider(height: 15),
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
        );
        },
    );
  }
  Widget buildCategories(DataOnData model)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image,),
          height: 150,
          width: 150,
        ),
        SizedBox(width: 10,),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}