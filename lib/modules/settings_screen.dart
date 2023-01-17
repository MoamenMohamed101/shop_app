import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        emailController.text = cubit.userModel!.data!.email!;
        nameController.text = cubit.userModel!.data!.name!;
        phoneController.text = cubit.userModel!.data!.phone!;
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetProfileStates,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultFormField(
                  controller: emailController,
                  keyboard: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email is empty';
                    }
                    return null;
                  },
                  text: 'Email Address',
                  prefixIcon: Icons.email,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: emailController,
                  keyboard: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name empty';
                    }
                    return null;
                  },
                  text: 'Name',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: phoneController,
                  keyboard: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone is empty';
                    }
                    return null;
                  },
                  text: 'Phone Number',
                  prefixIcon: Icons.phone,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                  voidCallback: () {
                    signOut(context);
                  },
                  text: 'LOG OUT',
                  width: double.infinity,
                )
              ],
            ),
          ),
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
