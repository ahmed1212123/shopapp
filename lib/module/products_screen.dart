import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_cubit.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_states.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/shared/components.dart';

class ProductsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state)
      {
        if (state is ShopSuccessChangeFavoritesState){
          if (!state.model.status){
            showToast(
                text: state.model.message,
                state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) =>
                ProductsBuilder(context, ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget ProductsBuilder(BuildContext context, HomeModel? model , CategoriesModel categoriesModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  //width: 100,
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics() ,
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=>buildCategoriesItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context,index)=>SizedBox(
                        width: 20.0,
                      ),
                      itemCount: categoriesModel.data.data.length,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Products",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.6,
            children: List.generate(
                model.data.products.length,
                (index) =>
                    buildGridProduct(context, model.data.products[index])),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesItem(DataOnData model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      );

  Widget buildGridProduct(BuildContext context, ProductModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 250,
              width: double.infinity,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                height: 1,
              ),
            ),
            Row(
              children: [
                Text(
                  '${model.price.round()}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor:  ShopCubit.get(context).favorites[model.id]! ? Colors.blue: Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
