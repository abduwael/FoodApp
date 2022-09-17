import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/layout/home/cubit/cubit.dart';
import 'package:food/main.dart';
import 'package:food/models/popular_food.dart';
import 'package:food/modules/home-screen/cubit/states.dart';
import 'package:food/modules/home-screen/home.dart';
import 'package:food/shared/shared.components/dimensions.dart';
import 'package:food/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';

import '../../shared/shared.components/components.dart';
import '../../shared/styles/colors.dart';
import '../home-screen/cubit/cubit.dart';

class PopularFoodDetail extends StatelessWidget {
  int index;
  ProductsPopular product;
   PopularFoodDetail({Key? key,required this.index,required this.product}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    FoodPopularCubit.get(context).initProduct();
    return BlocConsumer<FoodPopularCubit,FoodPopularAppStates>(

      listener: (context,state)
      {

      },
      builder: (context,state){
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                  left: 0,
                  right:0,
                  child: Container(
                    height: Dimensions.popularFoodImgSize(context),
                    width: double.infinity,

                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('http://mvs.bslmeiyu.com/uploads/${product.img}'),
                        )
                    ),

                  )),
              Positioned(
                  top: Dimensions.height45(context),
                  left: Dimensions.width20(context),
                  right: Dimensions.width20(context),
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.7),
                          child: IconButton(onPressed: ()
                          {
                            FoodPopularCubit.get(context).currentPage=0.0;
                            navigateAndFinish(context, HomeScreen());
                          }, icon: Icon(Icons.arrow_back,color: Colors.white,size: Dimensions.iconSize16(context),))),
                      Spacer(),
                      CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.7),
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.add_shopping_cart_outlined,color: Colors.white,size: Dimensions.iconSize16(context),))),


                    ],)),
              Positioned(
                  left: 0,
                  right:0,
                  top: Dimensions.popularFoodImgSize(context)-20,
                  bottom: 0,

                  child: Container(

                      padding: EdgeInsets.only(
                          left: Dimensions.width20(context),
                          right: Dimensions.width20(context),
                          top: Dimensions.width20(context)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20(context)),topLeft: Radius.circular(Dimensions.radius20(context))),
                        color: Colors.white,

                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              bigText(text: '${product.name}', color: Colors.black ,  context: context,size: Dimensions.font26(context)),
                              SizedBox(height: Dimensions.height10(context),),

                              Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    children: List.generate(5, (index) =>
                                        Icon(
                                          Icons.star, color: AppColors.mainColor,size: Dimensions.height20(context),)),
                                  ),

                                  SizedBox(width:Dimensions.width10(context)),
                                  smallText(text: '4.5',context: context,size: 14),
                                  SizedBox(width:Dimensions.width10(context)),
                                  smallText(text: '1278 ',context: context,size: 14),
                                  SizedBox(width:Dimensions.width10(context)),
                                  smallText(text: 'comments',context: context,size: 14),

                                ],),
                              SizedBox(height:Dimensions.height10(context),),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconAndText(icon: Icons.circle_sharp,

                                      text: 'Normal',
                                      iconColor: Colors.orangeAccent,context: context),
                                  IconAndText(icon: Icons.location_on_outlined,
                                      text: '1.7 km',
                                      iconColor: AppColors.mainColor,context: context),
                                  IconAndText(icon: Icons.timer,
                                    text: '32 min',
                                    iconColor: Colors.redAccent,context: context,),

                                ],),


                            ],
                          ),

                          SizedBox(height: Dimensions.height30(context),),
                          bigText(text: 'Introduce', context: context,),
                          SizedBox(height: Dimensions.height15(context),),
                          Expanded(child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),

                              child: ExpandableTextWidget( text: '${product.description}' ))),
                          //  ExpandableTextWidget(  text: 'ExpandableTextWidget'),

                        ],
                      )

                  )),
            ],
          ),
          bottomNavigationBar: Container(
            height: Dimensions.pageViewTextContainer(context),
            // color: Colors.grey,
            padding: EdgeInsets.only(left: Dimensions.height20(context),right: Dimensions.height20(context),bottom: Dimensions.height30(context),top: Dimensions.height30(context)),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20(context)*2),
                topRight:  Radius.circular(Dimensions.radius20(context)*2),
              ),

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(


                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20(context)),

                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: ()
                      {
                        FoodPopularCubit.get(context).setQuantity(false,context);

                      }
                        ,icon: Icon(Icons.remove),),
                      bigText(context: context, text: '${FoodPopularCubit.get(context).quantityCubit}'),
                      IconButton(onPressed: ()
                      {
                        FoodPopularCubit.get(context).setQuantity(true,context);
                      }
                        ,icon: Icon(Icons.add),),



                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(Dimensions.height12(context)),
                  decoration: BoxDecoration(
                    color:AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20(context)),
                  ),
                  child: InkWell(
                      onTap: ()
                      {
                         FoodPopularCubit.get(context).addItem(product, FoodPopularCubit.get(context).quantityCubit,context);

                        },

                      child: bigText(context: context, text: '\$${product.price}  |  Add to cart',color: Colors.white)),

                ),


              ],
            ),


          ),
        );
      },
    );
  }
}




Widget appColumn(dynamic context)
{
  return  Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      bigText(text: 'Burger', color: Colors.black ,  context: context,size: Dimensions.font26(context)),
      SizedBox(height: Dimensions.height10(context),),

      Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: List.generate(5, (index) =>
                Icon(
                  Icons.star, color: AppColors.mainColor,size: Dimensions.height20(context),)),
          ),

          SizedBox(width:Dimensions.width10(context)),
          smallText(text: '4.5',context: context,size: 14),
          SizedBox(width:Dimensions.width10(context)),
          smallText(text: '1278 ',context: context,size: 14),
          SizedBox(width:Dimensions.width10(context)),
          smallText(text: 'comments',context: context,size: 14),

        ],),
      SizedBox(height:Dimensions.height10(context),),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndText(icon: Icons.circle_sharp,

              text: 'Normal',
              iconColor: Colors.orangeAccent,context: context),
          IconAndText(icon: Icons.location_on_outlined,
              text: '1.7 km',
              iconColor: AppColors.mainColor,context: context),
          IconAndText(icon: Icons.timer,
            text: '32 min',
            iconColor: Colors.redAccent,context: context,),

        ],),


    ],
  );
}