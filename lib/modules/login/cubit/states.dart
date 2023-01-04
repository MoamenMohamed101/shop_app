abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginSuccessStates extends ShopLoginStates {}

class ShopLoginErrorStates extends ShopLoginStates {
  final error;

  ShopLoginErrorStates(this.error);
}
