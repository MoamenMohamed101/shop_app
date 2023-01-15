import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavItem(),
            separatorBuilder: (context, index) => Container(
                color: Colors.grey, width: double.infinity, height: 1),
            itemCount: 10);
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

buildFavItem() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                const Image(
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.PhMqSsHVO7SC7wrIUAlDFgHaDr?pid=ImgDet&rs=1'),
                  //fit: BoxFit.cover,
                  width: 120,
                  fit: BoxFit.cover,
                  height: 120,
                ),
                if (1 != 0)
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
                  const Text(
                    'pokpokwdpokdwpodkwodkodkwokdwodkdokwkdwokwokpodkwdkw',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      const Text(
                        '2000',
                        style: TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (1 != 0)
                        const Text(
                          '2000',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          //ShopCubit.get(context).changeFavourites(products.id);
                        },
                        icon: const CircleAvatar(
                          radius: 18,
                          backgroundColor: true ? Colors.blue : Colors.grey,
                          child: Icon(
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
