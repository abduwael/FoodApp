
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/layout/home/cubit/cubit.dart';
import 'package:food/main.dart';
import 'package:food/models/popular_food.dart';
import 'package:food/modules/home-screen/cubit/states.dart';
import 'package:food/modules/home-screen/home.dart';
import 'package:food/shared/shared.components/dimensions.dart';
import 'package:food/shared/shared.network/local/cache_helper.dart';
import 'package:food/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';

import '../../models/recommeded_food.dart';
import '../../shared/shared.components/components.dart';
import '../../shared/shared.components/constants.dart';
import '../../shared/styles/colors.dart';
import '../add-to-cart-screen/add-to-cart.dart';
import '../home-screen/cubit/cubit.dart';

class PopularFoodDetail extends StatelessWidget {
  int index;
  ProductsModel? product;

  PopularFoodDetail({Key? key, required this.index, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productModel=product;
    FoodPopularCubit.get(context).initProduct(productModel);
    return BlocConsumer<FoodPopularCubit, FoodPopularAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
      //  FoodPopularCubit.get(context).initProduct(product);
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Dimensions.popularFoodImgSize(context),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'http://mvs.bslmeiyu.com/uploads/${productModel!.img}'),
                    )),
                  )),
              Positioned(
                  top: Dimensions.height45(context),
                  left: Dimensions.width20(context),
                  right: Dimensions.width20(context),
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.7),
                          child: IconButton(
                              onPressed: () {
                                FoodPopularCubit.get(context).currentPage = 0.0;
                                navigateAndFinish(context, HomeScreen());
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: Dimensions.iconSize16(context),
                              ))),
                      Spacer(),
                      Stack(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.7),
                              child: IconButton(
                                  onPressed: () {
                                    navigateTo(
                                        context, const AddToCartScreen());
                                  },
                                  icon: Icon(
                                    Icons.add_shopping_cart_outlined,
                                    color: Colors.white,
                                    size: Dimensions.iconSize16(context),
                                  ))),

                          BlocConsumer<FoodPopularCubit, FoodPopularAppStates>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (FoodPopularCubit.get(context).totalItems >= 1) {
                                  return Positioned(
                                    top: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: AppColors.mainColor,
                                        child: Text(
                                          '${FoodPopularCubit
                                              .get(context)
                                              .totalItems}',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )),
                                  );
                                } else {
                                  return Container();
                                }
                              }
                          ),
                        ],
                      ),
                    ],
                  )),
              Positioned(
                  left: 0,
                  right: 0,
                  top: Dimensions.popularFoodImgSize(context) - 20,
                  bottom: 0,
                  child: Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width20(context),
                          right: Dimensions.width20(context),
                          top: Dimensions.width20(context)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(Dimensions.radius20(context)),
                            topLeft:
                                Radius.circular(Dimensions.radius20(context))),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appColumn(context,model: productModel),

                          SizedBox(
                            height: Dimensions.height30(context),
                          ),
                          bigText(
                            text: 'Introduce',
                            context: context,
                          ),
                          SizedBox(
                            height: Dimensions.height15(context),
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: ExpandableTextWidget(
                                      text: '${productModel.description}'))),
                          //  ExpandableTextWidget(  text: 'ExpandableTextWidget'),
                        ],
                      )
                  )

              ),
            ],
          ),
          bottomNavigationBar: Container(
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
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          FoodPopularCubit.get(context)
                              .setQuantity(false, context);
                        },
                        icon: Icon(Icons.remove),
                      ),
                      bigText(
                          context: context,
                          text:
                              '${FoodPopularCubit.get(context).cartItemsList}'),
                      IconButton(
                        onPressed: () {
                          FoodPopularCubit.get(context)
                              .setQuantity(true, context);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
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
                      onTap: () {
                        FoodPopularCubit.get(context).addItem(productModel, FoodPopularCubit.get(context).quantityCubit, context);
                        FoodPopularCubit.get(context).quantityCubit = 0;


                      },
                      child: bigText(
                          context: context,
                          text: '\$${productModel.price}  |  Add to cart',
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



