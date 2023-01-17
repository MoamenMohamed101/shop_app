import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach(
        (element) => print(
          element.group(0),
        ),
      );
}

var token = '';

signOut(context) {
  CacheHelper.removeData('token')!.then((value) {
    if (value) {
      NavigateAndFinsh(context: context, widget: ShopLoginScreen());
    }
  });
}
