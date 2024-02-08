
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/view/base/color_resources.dart';
import 'package:betakety_app/view/screes/auth/auth_screen.dart';
import 'package:betakety_app/view/screes/home/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBody extends StatefulWidget{
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  late SharedPreferences sharedPrefs ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
            () => checkUser()
    );
  }
  checkUser() async {
    sharedPrefs = await SharedPreferences.getInstance();

    if(sharedPrefs.containsKey("user")){

      //  user = User.fromJsonShared(json.decode(sharedPrefs.getString("user") )) ;

      Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => NavBarScreen())) ;


      // api.login( onError:  onError, onLogin:
      //  onLogin, password: user.password , username: user.userName ) ;
    }
    else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      ) ; }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
    body:Center( child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    const   Spacer(),

    Image.asset(Images.logo_with_name ,
    fit: BoxFit.cover,
    repeat: ImageRepeat.noRepeat,
    ),
    const   Spacer(),
      const Text( AppConstants.appName ,style:   TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30.0 ,
    color: ColorResources.primaryColor
    ),),
    //  padding:const EdgeInsets.all(100),) ,
    const   Spacer(),

    const  CircularProgressIndicator(color: ColorResources.primaryColor,),
    const   Spacer(),


    ]),
    ) );
  }
}