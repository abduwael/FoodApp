
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/layout/home/food_layout.dart';
import 'package:food/modules/home-screen/cubit/cubit.dart';
import 'package:food/shared/block_observer.dart';
import 'package:food/shared/shared.network/local/cache_helper.dart';
import 'package:food/shared/shared.network/remote/dio_helper.dart';
import 'package:food/shared/styles/themes.dart';

import 'layout/home/cubit/cubit.dart';
import 'layout/home/cubit/states.dart';
import 'modules/foods/foods_screen.dart';
import 'modules/home-screen/home.dart';
import 'modules/recommended_food_detail/recommended_food.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  runApp(MyApp());
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
                      create: (BuildContext context) => FoodPopularCubit()..getPopularData()..getRecommendedFoodData(),
                    ),


                  ],
                  child: BlocConsumer<FoodAppCubit, FoodAppState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return MaterialApp(
                          navigatorKey: _navKey,
                          theme: lightTheme,

                          themeMode: ThemeMode.light,
                          debugShowCheckedModeBanner: false,
                          home: HomeScreen(),
                        );
                      }));
  }
}
