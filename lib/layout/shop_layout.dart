import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          appBar: AppBar(
            title: const Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context: context ,widget: SearchScreen());
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
