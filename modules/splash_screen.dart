import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food/modules/home-screen/cubit/cubit.dart';
import 'package:food/shared/shared.components/components.dart';

import '../layout/home/food_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SplashScreen>with SingleTickerProviderStateMixin  {
  late Animation<double>animation;
  late  AnimationController animationController;
 loadResource() async
  {
   await FoodPopularCubit.get(context).getPopularData();
   await FoodPopularCubit.get(context).getRecommendedFoodData();

  }
   @override
   void initState() {
     loadResource();


     if (mounted) {
     setState(() {
       animationController = AnimationController(
           vsync: this, duration: const Duration(seconds: 2))
         ..animateBack(1, curve: Curves.slowMiddle);
       animation = CurvedAnimation(
         parent: animationController, curve: Curves.easeInOut,);
       Timer(
           const Duration(seconds: 3),
               () =>
               navigateAndFinish(context, HomeLayout())
       );
     });
     }else
       {
         print('init mounted');
       }
     super.initState();
   }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }
  @override
  void dispose() {

    if (mounted){

        animationController.stop(canceled: true);
        animationController.dispose();
        animation.removeListener(() { });

    }else{
      print('dispose mounted');
    }

    super.dispose();



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.white,
      body:Stack(
        children: [

         Flex(
           direction: Axis.vertical,
           children: [
             Expanded(child: Image.asset('assets/images/ss.gif',fit: BoxFit.fitWidth,width: double.maxFinite,)),
           ],
         ),

      /*    Center(
            child: ScaleTransition(
                scale: animationController,
                child: Image.asset('assets/images/nnn.gif',fit: BoxFit.fitHeight,width: double.maxFinite)),
          ),
*/



        ],
      )
    );
  }
}


