import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/models/popular_food.dart';
import 'package:food/models/recommeded_food.dart';
import 'package:food/modules/home-screen/cubit/cubit.dart';
import 'package:food/modules/home-screen/cubit/states.dart';
import 'package:food/shared/shared.components/components.dart';
import 'package:food/shared/shared.components/dimensions.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:intl/intl.dart';

import '../../shared/shared.components/constants.dart';
import '../../shared/shared.network/local/cache_helper.dart';
import '../foods/foods_screen.dart';
import '../recommended_food_detail/recommended_food.dart';

class FoodPageBody extends StatefulWidget {


  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  @override
  void dispose() {
  //  FoodPopularCubit.get(context).pageController.removeListener(() { });
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<FoodPopularCubit,FoodPopularAppStates>(
      listener:(context, state) {

      },
      builder:(context,state,) {

           var cubit=FoodPopularCubit.get(context);

           var recommendedModel=FoodPopularCubit.get(context).recommendedFoodModel;
            var popularFoodModel=FoodPopularCubit.get(context).popularFoodModel;

           return  ConditionalBuilder(

          condition:recommendedModel!=null&&popularFoodModel!=null ,
          builder: (context){

            return Column(
              children: [
                // slider section
                Container(
                  height: Dimensions.pageView(context),
                  //  color: Colors.red,
                  child: PageView.builder(

                      controller:cubit.pageController,
                      itemCount: popularFoodModel!.productsPopular.length,
                      itemBuilder: (context, index) {
                        return buildPageItem(index, context,popularFoodModel.productsPopular[index],cubit: cubit);

                      }),
                ),
                // dots
                Builder(
                  builder: (context){
                   FoodPopularCubit.get(context).changeView();
                    return DotsIndicator(
                      axis: Axis.horizontal,
                      dotsCount: cubit.popularFoodModel!.productsPopular.length,
                      position: cubit.currentPage,
                      decorator: DotsDecorator(
                        activeColor: AppColors.mainColor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),


                    );
                  },

                ),
                //popular text
                SizedBox(height: Dimensions.height30(context),),
                Container(
                  margin: EdgeInsets.only(left: Dimensions.height10(context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      bigText(text: 'Recommended', context: context),
                      SizedBox(width: Dimensions.height10(context),),
                      Container
                        (
                          margin: EdgeInsets.only(bottom: 3),
                          child: bigText(text: '.', context: context)


                      ),
                      SizedBox(width: Dimensions.height10(context),),
                      Container(
                        margin: EdgeInsets.only(bottom: 2),
                        child:
                        smallText(text: 'Food pairing', context: context),


                      ),

                    ],
                  ),
                ),
                // list of food and images
                Container(
                  child: ListView.separated(

                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return recommended(index,context,cubit.recommendedFoodModel!.products[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20,),
                    itemCount: cubit.recommendedFoodModel!.products.length,
                  ),
                ),
              ],
            );

          },

          fallback: (context)=>Center(child: CircularProgressIndicator(),),

        );
      }
    );
  }

  Widget recommended(int index,context, model)
  {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RecommendedFoodDetail(index: index,model: model,)
            )
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: Dimensions.width10(context),
            right: Dimensions.width10(context)),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image section
            Container(
              height: Dimensions.listViewImgSize(context),
              width: Dimensions.listViewImgSize(context),
              margin: EdgeInsets.only(left: Dimensions.width10(
                  context),),
              decoration: BoxDecoration(borderRadius: BorderRadius
                  .circular(Dimensions.height30(context),),
                color: index.isEven ? Colors.cyan : const Color(
                    0xFF9294cc),
                image: DecorationImage(
                  image: NetworkImage('http://mvs.bslmeiyu.com/uploads/${model!.img}',

                  ),
                  fit: BoxFit.cover,

                ),


              ),
            ),

            Expanded(
              child: Container(
                 clipBehavior: Clip.none,
                height: Dimensions.listViewTextSize(context),
                margin: EdgeInsets.only(
                    right: Dimensions.height10(context)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      Dimensions.width20(context),
                    ),
                    bottomRight: Radius.circular(
                      Dimensions.width20(context),

                    ),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0.01),
                        blurRadius: 0.01
                    )
                  ],

                ),

                child: Padding(

                  padding: EdgeInsets.only(
                      left: Dimensions.width10(context),
                      right: Dimensions.width10(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      bigText(text: '${model.name}',
                          color: Colors.black,
                          context: context),
                      SizedBox(height: Dimensions.height10(context),),
                      Row(
                        children: [
                          Expanded(
                            child: smallText(
                                text: '${model.description}',
                                context: context,
                                color: Colors.black54),
                          ),
                        ],),
                      SizedBox(height: Dimensions.height10(context),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndText(icon: Icons.circle_sharp,
                              text: 'Normal',
                              iconColor: Colors.orangeAccent,
                              context: context),
                          IconAndText(
                              icon: Icons.location_on_outlined,
                              text: '1.7 km',
                              iconColor: AppColors.mainColor,
                              context: context),
                          IconAndText(icon: Icons.timer,
                            text: '32 min',
                            iconColor: Colors.redAccent,
                            context: context,)
                        ],),


                    ],
                  ),
                ),

              ),

            ),

          ],
        ),

      ),
    );
  }

  Widget buildPageItem(int index, context,ProductsModel? model,{required FoodPopularCubit cubit})
  {

    Matrix4 matrix = new Matrix4.identity();
    if (index ==  cubit.currentPage.floor()) {

      var currentScale = 1 - ( cubit.currentPage - index) * (1 -  cubit.scaleFactor); //  0*(1- cubit.scaleFactor)
      var currtrans = 220 * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currtrans, 0);
    } else if (index ==  cubit.currentPage.floor() + 1) {
      var currScale =  cubit.scaleFactor + ( cubit.currentPage - index + 1) * (1 -  cubit.scaleFactor); // condition (1-2+1 = 0) * (1-scale) (scale = 0.8 )
      var currtrans = 220 * (1 - currScale) / 2; //(1-0.8)/2 =1/10*220=22
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currtrans, 0);
    } else if (index ==  cubit.currentPage.floor() - 1) {
      var currentScale = 1 - ( cubit.currentPage - index) * (1 -  cubit.scaleFactor); //  0*(1- cubit.scaleFactor)
      var currtrans = 220 * (1 - currentScale) / 2; //(1-0.8)/2 =1/10*220=22
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currtrans, 0);
    } else {
      var currscale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)..setTranslationRaw(0, 220 * (1 -  cubit.scaleFactor) / 2, 1);
    }
    {
      return Transform(
        transform: matrix,
        child: Stack(

          children: [
            GestureDetector(
              onTap: (){
                print(FoodPopularCubit.get(context).popularFoodModel!.productsPopular[index].name.toString());
              navigateAndFinish(context, (PopularFoodDetail(index: index, product:  model)));
              },
              child: Container(
                height: Dimensions.pageViewContainer(context),
                margin: EdgeInsets.only(left: Dimensions.width10(context),
                    right: Dimensions.width10(context)),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(
                    Dimensions.radius30(context)),
                  color: index.isEven ? Colors.cyan : const Color(0xFF9294cc),
                  image: DecorationImage(
                    image: NetworkImage('http://mvs.bslmeiyu.com/uploads/${model!.img}',
                    ),
                    fit: BoxFit.cover,
                  ),


                ),

              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer(context),

                margin: EdgeInsets.only(left: Dimensions.width30(context),
                    right: Dimensions.width30(context),
                    bottom: Dimensions.height30(context)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        Dimensions.radius20(context)),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 10),
                          blurRadius: 5
                      )
                    ]

                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height15(context), left: 15, right: 15,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Expanded(child: bigText(text: '${model.name}',
                          color: Colors.black,
                          context: context,
                          size: Dimensions.font26(context))),
                      SizedBox(height: Dimensions.height10(context),),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Wrap(
                              children: List.generate(5, (index) =>
                                  Icon(
                                    Icons.star, color: AppColors.mainColor,
                                    size: Dimensions.height20(context),)),
                            ),

                            smallText(text: '4.5', context: context),

                            smallText(text: '1278 ', context: context),

                            smallText(text: 'comments', context: context),

                          ],),
                      ),
                      SizedBox(height: Dimensions.height10(context),),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconAndText(icon: Icons.circle_sharp,

                                text: 'Normal',
                                iconColor: Colors.orangeAccent,
                                context: context),
                            IconAndText(icon: Icons.location_on_outlined,
                                text: '1.7 km',
                                iconColor: AppColors.mainColor,
                                context: context),
                            IconAndText(icon: Icons.timer,
                              text: '32 min',
                              iconColor: Colors.redAccent, context: context,),

                          ],),
                      ),


                    ],
                  ),
                ),
              ),

            ),


          ],
        ),
      );
    }
  }
}
