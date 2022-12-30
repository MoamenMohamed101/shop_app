import 'package:flutter/material.dart';

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
