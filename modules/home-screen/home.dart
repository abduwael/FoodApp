import 'package:flutter/material.dart';
import 'package:food/shared/shared.components/components.dart';
import 'package:food/shared/shared.components/dimensions.dart';
import 'package:food/shared/styles/colors.dart';

import 'food_page_body.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Column(
        children: [
          Container(

            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20(context),right:  Dimensions.width20(context)),
              margin: EdgeInsets.only(top: Dimensions.height45(context) ,bottom: Dimensions.height15(context)),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children:  [
                 Column(
                   children:  [
                    bigText(text: 'Egypt',color: AppColors.mainColor,context: context),
                     Row(
                       children: [
                         smallText(text: 'Cairo',color:Colors.black54,context: context),
                         Icon(Icons.arrow_drop_down_rounded),
                       ],
                     ),
                   ],
                 ),
                 InkWell(
                   onTap: (){},
                   child: Container(height: Dimensions.height45(context),width: Dimensions.height45(context),
                   decoration: BoxDecoration(
                     color: AppColors.mainColor,
                     borderRadius: BorderRadius.circular(Dimensions.radius15(context)),
                   ),
                     child:  Icon(Icons.search,color: Colors.white,size: Dimensions.iconSize24(context)),
                   ),
                 ),

               ],
             ),
            ),
          ),
          Expanded(

            child: SingleChildScrollView
              (child: FoodPageBody()),
          ),
        ],
      ),



    );
  }
}
