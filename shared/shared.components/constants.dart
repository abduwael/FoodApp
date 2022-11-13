

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:shared_preferences/shared_preferences.dart';

final  defaultColor=HexColor('0FF89dad0');
final Color redColor = HexColor('FF0000');
final Color greenColor = HexColor('008000');
void signOut(context)
{

}
// String token = CacheHelper.getData('token');

/*void socialSignOut(context)
{
//  CacheHelper.removeData('uId').then((value) {});


//  CacheHelper.removeData('token').then((value)
  {
    if(value==true)
      SocialCubit.get(context).userModel=null;
    SocialCubit.get(context).postModel=null;

    CacheHelper.clearData();
    navigateAndFinish(context, SocialAppLogin());

  });
}*/

String uId='';

// final snackBar = displaySnackBar(context: context, text: '${state.error}', backGroundColor: Colors.red, color: Colors.white);ScaffoldMessenger.of(context).showSnackBar(snackBar);