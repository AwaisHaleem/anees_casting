import 'package:anees_costing/Screen/Admin/homepage/mobile.dart';
import 'package:anees_costing/Screen/Auth/Login/login.dart';
import 'package:anees_costing/Screen/Customer/customer_products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Models/auth.dart';
import '../../contant.dart';
import '../Admin/homepage/admin_home.dart';
import '../Auth/Login/mobilelogin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirst = true;
  CurrentUser? currentUser;

  @override
  void didChangeDependencies() async {
    if (isFirst) {
      await Future.delayed(Duration(seconds: 2)).then((value) async {
        bool isLogin = await Provider.of<Auth>(context, listen: false)
            .tryAutoLogin()
            .catchError((error) {
          //  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          print('error in autologin');
        });
        print(isLogin);
        currentUser = Provider.of<Auth>(context, listen: false).currentUser;
        if (isLogin && currentUser!.role!.toLowerCase() == 'customer') {
          Navigator.of(context)
              .pushReplacementNamed(CustomerProductScreen.routeName);
        } else if (isLogin && currentUser!.role!.toLowerCase() == 'seller') {
          Navigator.of(context).pushReplacementNamed(AdminHomePage.routeName);
        } else if (isLogin && currentUser!.role!.toLowerCase() == 'admin') {
          Navigator.of(context).pushReplacementNamed(AdminHomePage.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        }
        isFirst = false;
      });
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Text(
          'Anees Casting',
          style: GoogleFonts.berkshireSwash(
            fontSize: 60,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
