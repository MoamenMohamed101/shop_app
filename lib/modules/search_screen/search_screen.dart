import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/cubit.dart';
import 'package:shop_app/modules/search_screen/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopSearchCubit, ShopSearchStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopSearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    keyboard: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please search';
                      }
                      return null;
                    },
                    text: 'Search',
                    prefixIcon: Icons.search,
                    onFieldSubmitted: (value) {
                      cubit.search(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is ShopSearchLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(
                          cubit.searchModel!.data!.data![index],
                          context,
                          //isOldPrice: false
                        ),
                        separatorBuilder: (context, index) => Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: 1,
                        ),
                        itemCount: 5,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
