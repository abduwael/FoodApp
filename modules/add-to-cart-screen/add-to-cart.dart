
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/layout/home/food_layout.dart';
import 'package:food/models/cart_food.dart';
import 'package:food/modules/home-screen/cubit/cubit.dart';
import 'package:food/modules/home-screen/cubit/states.dart';
import 'package:food/modules/recommended_food_detail/recommended_food.dart';
import 'package:food/shared/shared.components/dimensions.dart';
import 'package:food/shared/styles/colors.dart';
import '../../models/recommeded_food.dart';
import '../../shared/shared.components/components.dart';
import '../foods/foods_screen.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  List<CartModel> localCartModel =[];
  List<CartModel> _cartModel=[];

  @override
  void initState() {
   // localCartModel = FoodPopularCubit.get(context).getCartStorageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   if (FoodPopularCubit.get(context).getCart().isEmpty){
     _cartModel = localCartModel;
     print("LOACLLLLLLLl"+_cartModel.toString());
   }else {
     _cartModel = FoodPopularCubit.get(context).getCart();
     print("ELSEE "+_cartModel.toString());
   }
    return BlocConsumer<FoodPopularCubit, FoodPopularAppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                  top: Dimensions.height20(context) * 3,
                  right: Dimensions.width20(context),
                  left: Dimensions.width20(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          backgroundColor: AppColors.mainColor,
                          child: IconButton(
                              onPressed: ()
                              {
                             Navigator.pop(context);

                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: Dimensions.iconSize24(context),
                              ))),
                      SizedBox(
                        width: Dimensions.width20(context) * 5,
                      ),
                      CircleAvatar(
                          backgroundColor: AppColors.mainColor,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: Dimensions.iconSize24(context),
                              ))),
                      CircleAvatar(
                          backgroundColor: AppColors.mainColor,
                          child: IconButton(
                              onPressed: () {
                                navigateAndFinish(context, HomeLayout());
                              },
                              icon: Icon(
                                Icons.home_outlined,
                                color: Colors.white,
                                size: Dimensions.iconSize24(context),
                              ))),
                    ],
                  )),
              Positioned(
                  top: Dimensions.height20(context) * 6,
                  right: Dimensions.width20(context) / 2,
                  left: Dimensions.width20(context) / 2,
                  bottom: 0,
                  child: ListView.separated(
                      itemBuilder: (context, index)
                      {
                        return buildCartItem(context,index,FoodPopularCubit.get(context),model: FoodPopularCubit.get(context).popularFoodModel!.productsPopular[index] );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 15,),
                      itemCount: FoodPopularCubit.get(context).getCart().length)
              ),
            ],
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(left: Dimensions.width20(context)*3,
                  right:  Dimensions.width20(context)*3,
                  top: Dimensions.height20(context),
                  bottom: Dimensions.height20(context),

                ),

              ),
              Container(
                height: Dimensions.pageViewTextContainer(context),
                // color: Colors.grey,
                padding: EdgeInsets.only(
                    left: Dimensions.height20(context),
                    right: Dimensions.height20(context),
                    bottom: Dimensions.height30(context),
                    top: Dimensions.height30(context)),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20(context) * 2),
                    topRight: Radius.circular(Dimensions.radius20(context) * 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius20(context)),
                      ),
                      child: Padding(

                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text('Total amount:   '),
                            Text(FoodPopularCubit.get(context).totalPrice.toString(),

                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(Dimensions.height12(context)),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius20(context)),
                      ),
                      child: InkWell(
                          onTap: ()
                          {

                          },
                          child: bigText(
                              context: context,
                              text: ' Check Out',
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCartItem(context,index,FoodPopularCubit cubit,{ ProductsModel ?model}) {
    return Row(
      children: [
        GestureDetector(
          onTap: ()
          {

            var popularFood=FoodPopularCubit.get(context).popularFoodModel!.productsPopular.indexOf(cubit.getCart()[index].product!);
            if(popularFood>=0)
            {
              navigateTo(context, PopularFoodDetail(index:popularFood,product: FoodPopularCubit.get(context).popularFoodModel!.productsPopular[popularFood],));


            }else
            {
              var recommendedFood=FoodPopularCubit.get(context).recommendedFoodModel!.products.indexOf(cubit.getCart()[index].product!);
              navigateTo(context, RecommendedFoodDetail(index:recommendedFood,model:FoodPopularCubit.get(context).recommendedFoodModel!.products[recommendedFood]));

            }



          },
          child: Container(
            height: Dimensions.listViewTextSize(context),
            width: Dimensions.listViewTextSize(context),
            margin: EdgeInsets.only(
              left: Dimensions.width10(context),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimensions.height30(context),
              ),
              color: Colors.cyan,
              image: DecorationImage(
                image: NetworkImage(
                  'http://mvs.bslmeiyu.com/uploads/${cubit.getCart()[index].img}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          width: Dimensions.width10(context),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bigText(
                  text: '${cubit.getCart()[index].name}',
                  color: Colors.black,
                  context: context,
                  textOVerFlow: TextOverflow.ellipsis),
              SizedBox(
                height: Dimensions.height20(context) / 2,
              ),
              smallText(context: context, text: 'spicy'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallText(
                      context: context,
                      text: '\$ ${cubit.getCart()[index].price}',
                      size: 20,
                      color: Colors.redAccent),
                  SizedBox(
                    width: Dimensions.width20(context) * 4,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: ()
                          {
                            cubit.addItem(cubit.getCart()[index].product , -1,context);

                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: Dimensions.iconSize24(context),
                          )),
                      bigText(context: context, text: '${cubit.getCart()[index].quantity}'),
                      IconButton(
                          onPressed: ()
                          {
                            cubit.addItem(cubit.getCart()[index].product , 1,context);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: Dimensions.iconSize24(context),
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}


