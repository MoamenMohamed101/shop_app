import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesStates,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildFavItem(cubit.favoritesModel!.data!.data![index], context),
            separatorBuilder: (context, index) => Container(
                color: Colors.grey, width: double.infinity, height: 1),
            itemCount: cubit.favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

buildFavItem(FavoritesData? favoritesData, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage('${favoritesData!.product!.image}'),
                  //fit: BoxFit.cover,
                  width: 120,
                  fit: BoxFit.cover,
                  height: 120,
                ),
                if (favoritesData.product!.discount != 0)
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
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${favoritesData.product!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${favoritesData.product!.price}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (favoritesData.product!.oldPrice != 0 &&
                          favoritesData.product!.discount != 0)
                        Text(
                          '${favoritesData.product!.oldPrice}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavourites(favoritesData.product!.id);
                        },
                        icon: CircleAvatar(
                          radius: 18,
                          backgroundColor: ShopCubit.get(context)
                                  .favorites[favoritesData.product!.id]!
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
      ),
    );
