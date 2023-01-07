import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/componants/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salla'),
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.removeData('token')!.then((value) {
                if (value) {
                  NavigateAndFinsh(context: context, widget: ShopLoginScreen());
                }
              });
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
