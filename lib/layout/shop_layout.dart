import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/componants/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getData()
        ..getCategories(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (BuildContext context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            appBar: AppBar(
              title: const Text('Salla'),
              actions: [
                TextButton(
                  onPressed: () {
                    CacheHelper.removeData('token')!.then((value) {
                      if (value) {
                        NavigateAndFinsh(
                            context: context, widget: ShopLoginScreen());
                      }
                    });
                  },
                  child: const Text(
                    'Log out',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
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
      ),
    );
  }
}
