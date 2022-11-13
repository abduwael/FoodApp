import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/models/recommeded_food.dart';
import 'package:food/modules/add-to-cart-screen/add-to-cart.dart';
import 'package:food/modules/home-screen/cubit/cubit.dart';
import 'package:food/modules/home-screen/cubit/states.dart';
import 'package:food/modules/home-screen/home.dart';
import 'package:food/shared/shared.components/components.dart';
import 'package:food/shared/shared.components/dimensions.dart';
import 'package:food/shared/styles/colors.dart';

class RecommendedFoodDetail extends StatelessWidget {
  ProductsModel?model;
  int index;
   RecommendedFoodDetail({Key? key,required this.index, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodPopularCubit.get(context).initProduct(model);
    return BlocConsumer<FoodPopularCubit,FoodPopularAppStates>(
      listener: (context, state) {

      },
      builder:(context,state){
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading:false,
                toolbarHeight: Dimensions.height20(context)*3,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              FoodPopularCubit.get(context).currentPage=0.0;
                              navigateAndFinish(context, HomeScreen());
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.black,
                              size: Dimensions.iconSize16(context),
                            ))),
                    Stack(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: ()
                                {
                                  navigateTo(context, AddToCartScreen());
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black,
                                  size: Dimensions.iconSize16(context),
                                ))),
                        Builder(builder: (context){
                          return FoodPopularCubit.get(context).totalItems>=1? Positioned(
                            top: 0,
                            right: 0,

                            child: CircleAvatar(

                                radius: 9,
                                backgroundColor: AppColors.mainColor,
                                child: Text('${FoodPopularCubit.get(context).totalItems}',style: TextStyle(
                                  color: Colors.white,

                                ),)

                            ),
                          ): Container();
                        }),
                      ],
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20(context)),
                          topRight: Radius.circular(Dimensions.radius20(context)),
                        )),
                    child: Center(
                      child: bigText(
                          text: '${model!.name}',
                          context: context,
                          size: Dimensions.font26(context)),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                  ),
                ),
                backgroundColor: Colors.brown.shade900,
                systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.brown.shade900),
                pinned: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'http://mvs.bslmeiyu.com/uploads/${model!.img}',
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.height20(context),
                          right: Dimensions.height20(context)),
                      child: ExpandableTextWidget(
                          text:
                          '${model!.description}'
                      ),
                    ),
                  ],
                ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(

                        backgroundColor:AppColors.mainColor,
                        child: IconButton(
                            onPressed: () {
                              FoodPopularCubit.get(context).setQuantity(false, context);
                            },
                            icon: Icon(
                              Icons.remove,color: Colors.white,
                              size: Dimensions.iconSize16(context),
                            ))),
                    bigText(context: context, text: '\$${model!.price} '+' X  '+'${FoodPopularCubit.get(context).cartItemsList}'),
                    CircleAvatar(

                        backgroundColor: AppColors.mainColor,
                        child: IconButton(
                            onPressed: () {
                              FoodPopularCubit.get(context).setQuantity(true, context);
                            },
                            icon: Icon(
                              Icons.add,color: Colors.white,
                              size: Dimensions.iconSize16(context),
                            ))),

                  ],
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
                      child: Row(
                        children: [
                          Container(
                            width: Dimensions.height20(context)*3,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite,
                                color: AppColors.mainColor,
                              ),
                            ),
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
                          onTap: ()
                          {
                               FoodPopularCubit.get(context).addItem(model, FoodPopularCubit.get(context).quantityCubit, context);
                               FoodPopularCubit.get(context).quantityCubit=0;
                          },
                          child: bigText(
                              context: context,
                              text: '\$${model!.price}  |  Add to cart',
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } ,
    );
  }
}
