
import 'package:get/get.dart';
import 'package:pas_gasal_02/pages/login_clone_fix_page.dart';
import 'package:pas_gasal_02/pages/menu_drawer.page.dart';



class Routes {
  //list halaman apk
  static const String registration = "/registration";
  static const String confirmRegistration = "/confirmregistration";
  static const String listProduk = "/listproduk";
  static const String detailListProduk = "/detaillistproduk";
  static const String detailListProdukHP = "/detaillistprodukhp";
  static const String mainMenu = "/mainmenu";
  static const String mainMenuDrawer = "/mainmenudrawer";
  static const String menuDrawer = "/menudrawer";
  static const String loginCloneFix = "/loginclonefix";
  static const String loginPage = "/loginPage";
  

  
  // dll

  // tampung ke array buat ke maindart
  static final pages = [
    GetPage(name: loginCloneFix, page: ()=>LoginCloneFixPage()),
    GetPage(name: mainMenuDrawer, page: ()=> MenuDrawerPage()),
    // dll
  ];
}