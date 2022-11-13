import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/layout/home/cubit/cubit.dart';
import 'package:food/layout/home/cubit/states.dart';

import '../../modules/home-screen/cubit/cubit.dart';


class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodAppCubit, FoodAppState>(
      listener: (context, states) {},
      builder: (context, states) {


        FoodAppCubit cubit = FoodAppCubit.get(context);
        return Scaffold(

          bottomNavigationBar: BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.botnavbarindex(index);
            },
            items: cubit.item,
          ),
          body: cubit.screen[cubit.currentIndex],
        );
      },
    );
  }
}
