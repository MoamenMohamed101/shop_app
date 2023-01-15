import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildCardItem(cubit.categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => Container(
                color: Colors.grey, width: double.infinity, height: 1),
            itemCount: cubit.categoriesModel!.data!.data!.length);
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

buildCardItem(DataModel dataModel) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            image: NetworkImage(dataModel.image),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            dataModel.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
