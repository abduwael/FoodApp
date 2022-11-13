
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/modules/add-to-cart-screen/add-to-cart.dart';
import 'package:food/modules/add-to-cart-screen/cubit/cubit.dart';
import 'package:food/modules/home-screen/cubit/cubit.dart';
import 'package:food/shared/block_observer.dart';
import 'package:food/shared/shared.components/constants.dart';
import 'package:food/shared/shared.network/local/cache_helper.dart';
import 'package:food/shared/shared.network/remote/dio_helper.dart';
import 'package:food/shared/styles/themes.dart';
import 'layout/home/cubit/cubit.dart';
import 'layout/home/cubit/states.dart';
import 'layout/home/food_layout.dart';
import 'modules/home-screen/home.dart';
import 'modules/splash_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();






  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {

    final _navKey = GlobalKey<NavigatorState>();
              return  MultiBlocProvider(

                  providers: [
                    BlocProvider(
                      create: (BuildContext context) => FoodAppCubit() ,
                    ),
                    BlocProvider(
                      create: (BuildContext context) => FoodPopularCubit()..getCartStorageData(),
                    ),


                  ],
                  child: BlocConsumer<FoodAppCubit, FoodAppState>(
                      listener: (context, state) {},
                      builder: (context, state) {

                        return Builder(
                          builder: (context) {

                            return MaterialApp(
                              navigatorKey: _navKey,
                              theme: lightTheme,

                              themeMode: ThemeMode.light,
                              debugShowCheckedModeBanner: false,
                              home: SplashScreen(),
                            );
                          }
                        );
                      }));
  }
}
