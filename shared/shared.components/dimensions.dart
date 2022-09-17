

import 'package:flutter/material.dart';

class Dimensions
{
  static  double screenHeight(context) => MediaQuery.of(context).size.height; //803.6

  static  double screenWidth(context) => MediaQuery.of(context).size.width;
  static double pageView(context)=>screenHeight(context)/2.5;
  static double pageViewContainer(context)=>screenHeight(context)/3.65;
  static double pageViewTextContainer(context)=>screenHeight(context)/6.69;
  // dynamic height
  static double height10(context)=>screenHeight(context)/80.36;
  static double height20(context)=>screenHeight(context)/40.18;
  static double height15(context)=>screenHeight(context)/53.3;
  static double height30(context)=>screenHeight(context)/26.7;
  static double height45(context)=>screenHeight(context)/17.8;
  static double height12(context)=>screenHeight(context)/66.9;



// dynamic width
  static double width10(context)=>screenHeight(context)/80.36;
  static double width20(context)=>screenHeight(context)/40.18;
  static double width15(context)=>screenHeight(context)/53.3;
  static double width30(context)=>screenHeight(context)/26.7;


//font size
  static double font20(context)=>screenHeight(context)/40.18;
  static double font26(context)=>screenHeight(context)/30.9;




  //small text
  static double smallTextHeight15(context)=>screenHeight(context)/66.9;



  static double radius15(context)=>screenHeight(context)/53.5;

  static double radius20(context)=>screenHeight(context)/40.18;
  static double radius30(context)=>screenHeight(context)/26.7;



// icon

  static double iconSize24(context)=>screenHeight(context)/33.4;
  static double iconSize16(context)=>screenHeight(context)/52.4;



  // list view size

  static double listViewImgSize(context)=>screenWidth(context)/3.25; // 120

  static double listViewTextSize(context)=>screenWidth(context)/3.9; //100


// popular Food
  static double popularFoodImgSize(context)=>screenHeight(context)/2.41; //100







}