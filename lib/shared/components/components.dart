import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';

myDivider() => Container(height: 1, width: double.infinity, color: Colors.grey);

defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? keyboard,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  @required String? Function(String?)? validator,
  @required String? text,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
  VoidCallback? iconSuffix,
  VoidCallback? onTap,
}) =>
    TextFormField(
      onTap: onTap,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: text!,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon!),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: iconSuffix,
                icon: isPassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.remove_red_eye),
              )
            : null,
      ),
      keyboardType: keyboard,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
    );

defaultButton({
  double? width,
  Color? color = Colors.blue,
  @required VoidCallback? voidCallback,
  @required String? text,
  bool? isUpperCase = true,
  double? radius = 10.0,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius!),
      ),
      child: MaterialButton(
        onPressed: voidCallback,
        child: Text(
          isUpperCase! ? text!.toUpperCase() : text!,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

navigateTo({context, widget}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void NavigateAndFinsh({context, widget}) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

showToast(String? message, ToastStates states) => Fluttertoast.showToast(
    msg: message!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(states),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

buildListProduct(model , context,{bool? isOldPrice = true})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage('${model!.image}'),
              //fit: BoxFit.cover,
              width: 120,
              fit: BoxFit.cover,
              height: 120,
            ),
            if (model.discount != 0)
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
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(height: 1.3),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (model.oldPrice != 0 &&
                      model.discount != 0 && isOldPrice == true)
                    Text(
                      '${model.oldPrice}',
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
                          .changeFavourites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 18,
                      backgroundColor: ShopCubit.get(context)
                          .favorites[model.id]!
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