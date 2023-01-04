import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register_screen.dart';

import '../../shared/componants/components.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  bool? isPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ShopLoginCubit(ShopLoginInitialStates()),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Login not to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFormField(
                          controller: emailController,
                          keyboard: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter email';
                            }
                            return null;
                          },
                          text: 'Enter email address',
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          keyboard: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter password';
                            }
                            return null;
                          },
                          text: 'Enter your password',
                          prefixIcon: Icons.lock,
                          // suffixIcon: Icons.add,
                          // isPassword: isPassword!,
                          iconSuffix: () {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: true,
                          builder: (context) => defaultButton(
                            color: Colors.blue,
                            text: 'login',
                            voidCallback: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                print(emailController.text);
                                print(passwordController.text);
                              }
                            },
                            width: double.infinity,
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  widget: const ShopRegisterScreen(),
                                );
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
