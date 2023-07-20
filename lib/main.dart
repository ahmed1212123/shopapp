import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/cubit_mode/cubit.dart';
import 'package:shopapp/cubit/cubit_mode/state.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_cubit.dart';
import 'package:shopapp/module/layout/layout_screen.dart';
import 'package:shopapp/module/login/login_screen.dart';
import 'package:shopapp/module/on_boarding.dart';

import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/network/cache_helper.dart';
import 'package:shopapp/shared/network/dio_helper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;

  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  print(token);
  if(onBoarding!=null)
  {
    if(token != null) widget = Layoutscreen();
    else widget = LoginScreen();
  }else
    {
      widget = OnBoardingScreen();
    }

  runApp( MyApp(
    isDark: isDark,
    StartWidget: widget,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  bool? isDark;
  Widget StartWidget;

  MyApp({this.isDark,required this.StartWidget});


  // MyApp(this.isDark, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context )=> AppCubit()..changeMode( fromShared: isDark,),),
        BlocProvider(create: (BuildContext context)=> ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()),

      ],
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white ,
                      statusBarBrightness: Brightness.dark,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.black
                    )
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  elevation: 20,
                )

            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black12,
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black12 ,
                    statusBarBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.black12,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.white
                  )

              ),
              textTheme: const TextTheme(
                  bodyMedium: TextStyle(
                    color: Colors.white,
                  )
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20,
                  backgroundColor: Colors.black38
              ),
            ),
            themeMode: /*AppCubit.get(context).isDark? ThemeMode.dark:*/ThemeMode.light,
            home: StartWidget,
          );
        },
      ),
    );
  }
}
