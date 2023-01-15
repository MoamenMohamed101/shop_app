import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/componants/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => productsBuilder(
              cubit.homeModel!, cubit.categoriesModel!, context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is ShopSuccessFavoritesStates) {
          if (state.changeFavoritesModel.status == false) {
            showToast(state.changeFavoritesModel.message, ToastStates.ERROR);
          }
        }
      },
    );
  }
}

productsBuilder(
        HomeModel homeModel, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                scrollDirection: Axis.horizontal),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(
                          categoriesModel.data!.data![index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: categoriesModel.data!.data!.length),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.57,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                homeModel.data!.products.length,
                (index) =>
                    buildGridProduct(homeModel.data!.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildGridProduct(Products? products, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(products!.image!),
                //fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              if (products.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: const Text(
                    'Discount',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  products.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${products.price!.round()}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (products.oldPrice != 0 && products.discount != 0)
                      Text(
                        '${products.oldPrice}',
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavourites(products.id);
                      },
                      icon: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            ShopCubit.get(context).favorites[products.id]!
                                ? Colors.blue
                                : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildCategoriesItem(DataModel categories) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(categories.image!),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100,
          child: Text(
            categories.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
