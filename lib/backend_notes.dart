// In video Shared pref :-

// 1- make one method to save all types of data (string , int , bool , double) in shared pref

// 2- make one method to get all types of data (string , int , bool , double) in shared pref

// 3- save data of onBoarding in shared pref when the user skip or when he reach last screen by using FloatingActionButton and go to login screen

// 4- save data of token in shared pref when the user write his email and password correct in login screen and go to shop layout screen

// if (onBoarding != null) {
//   if (token != null) {
//     widget = const ShopLayout();
//   } else {
//     widget = ShopLoginScreen();
//   }
// } else {
//   widget = const OnBoardingScreen();
// }

// ================================================================================
// In video Build Shop Layout [1] :-

// 1- Build layout screen (bottomNavigationBar)

// 2- build home model

// 3- home is get

// 4- call get method in cubit , give it the url and token , call it when the application start
//==================================================================================
// Setup Favorites [like a pro] :-

//1- Make map in cubit and give it the id and in_favorites from products in HomeModel by use forEach

//2- call map(favorites) in products screen and toggle between colors on it

//3- Make method in cubit to change product Id

//4- Make Favorites Model

//5- favorites[productId!] = !favorites[productId]!;

//6- Show toast if status of changeFavoritesModel false

//7- make favorites screen ui

//8- Make model FavoritesModel from website json to dart

//9- Make method to get favorites data and put it the data in model

//10- put the data in Favorites screen

//11- Get favorites in changeFavoritesModel
