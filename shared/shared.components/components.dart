

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food/shared/shared.components/dimensions.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';


import '../../models/recommeded_food.dart';
import 'constants.dart';

Widget defaultButton({
  Color? color = Colors.blue,
  double width = double.infinity,
  required VoidCallback onpressed, // VoidCallback return Anonymous function
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        // if we have box decoration color must include in
        borderRadius: BorderRadius.circular(
          5,
        ),
        color: color,
      ),
      child: MaterialButton(
        onPressed: onpressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );

//__-------------------------------
Widget defaultTextButton({
  required VoidCallback onpressed, // VoidCallback return Anonymous function
  required String? text,
}) {
  return TextButton(onPressed: onpressed, child: Text(text!.toUpperCase()));
}

Widget defaultForm({
  GestureTapCallback? onTap,
  required TextEditingController controller,
  required FormFieldValidator<String>? validator,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  VoidCallback? suffixOnPressed,
  TextStyle? style,
}) =>
    TextFormField(
      style: style,
      validator: validator,
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixOnPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );




void navigateTo(context, widget) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => widget,maintainState:false ));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(

      context, MaterialPageRoute(builder: (context) => widget),

      (Route<dynamic> route) {
    return false;
  });
}





SnackBar displaySnackBar({required BuildContext context,required String text,Color ? backGroundColor,Color ? color}) {
  return SnackBar(

    backgroundColor: backGroundColor,
    content: Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color,
        fontSize: 18,
        fontWeight: FontWeight.bold,

      ),
    ),

  );
  //globalKey.currentState.showSnackBar(snackBar);
  //ScaffoldMessenger.of(context).showSnackBar(displaySnackBar);
}


AppBar defaultAppBar(
{required BuildContext context,
  String ? title,
  List<Widget>?actions,
})
=>AppBar
  (
  titleSpacing: 5.0,
    leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios_outlined),
    ),
  title: Text (title!,style: TextStyle(
    fontSize: 20
  ),),

  actions: actions,

  );
Widget bigText({
 required BuildContext context,
  required String text,
  double ?size=0,
  TextOverflow?textOVerFlow=TextOverflow.ellipsis,
  Color ?color= const Color(0xFF332d2b)
})
{
  return Text(text,
  style: TextStyle(overflow: textOVerFlow,
 color: color,
    fontSize:size==0? Dimensions.font20(context):size,

    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',


  ),
  );
}
Widget smallText({
 required BuildContext context,
  required String text,
  TextOverflow?textOVerFlow=TextOverflow.ellipsis,
  double height=1.2,
  double ?size=0,
  int maxlines=1,
  Color ?color= const Color(0xFFccc7c5)
})
{
  return Text(text,
    maxLines: maxlines,
    style: TextStyle(
      color: color,
      fontSize:size==0? Dimensions.smallTextHeight15(context):size,
 overflow: textOVerFlow,
      height: height,
      fontFamily: 'Roboto',


    ),
  );
}
Widget IconAndText({IconData?icon ,required String text,Color?color,Color?iconColor, required BuildContext context,})
{
  return  Row(

    children: [
      Icon(icon,color: iconColor,size: Dimensions.iconSize24(context),),
      SizedBox(width: 5,),
      smallText(text: text,color: color,context: context),

    ],
  );
}
class ExpandableTextWidget extends StatefulWidget {

   final String text;
 //  final BuildContext context;
  ExpandableTextWidget({Key? key,required this.text,}) : super(key: key){


 }
  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {

  late String firstHalf;
  late String secondHalf;
  bool hiddenText=true;
  static  double textHeight(context) => MediaQuery.of(context).size.height/4.5; //803.6

  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(widget.text.length > textHeight(context))
    {
      firstHalf=widget.text.substring(0,textHeight(context).toInt());
      secondHalf=widget.text.substring(textHeight(context).toInt()+1,widget.text.length);

    }else{
      firstHalf=widget.text;
      secondHalf='';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 200,
      child: secondHalf.isEmpty ? defaultText( context: context,text: firstHalf,):
      Column(
         children:[
           defaultText(context:context,text:hiddenText?(firstHalf+'...'):(firstHalf+secondHalf)),

          InkWell(
            onTap: ()
            {
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                defaultText(context: context, text: 'Show more',color: AppColors.mainColor,size: 14),
                hiddenText ? Icon(Icons.arrow_drop_down, color: AppColors.mainColor, ):Icon(Icons.arrow_drop_up_outlined,color: AppColors.mainColor, )

              ],
            ),
          )
              ],
      ),
    ) ;

  }


}
Widget defaultText({
  required BuildContext context,
  required String text,
  double height=1.8,
  double ?size=0,
  Color ?color= Colors.black45
})
{
  return Text(text,

    style: TextStyle(
      color: color,
      fontSize:size==0? Dimensions.height15(context):size,

      height: height,
      fontFamily: 'Roboto',


    ),
  );
}
Widget appColumn(dynamic context,{required ProductsModel model}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bigText(
          text: '${model.name}',
          color: Colors.black,
          context: context,
          size: Dimensions.font26(context)),
      SizedBox(
        height: Dimensions.height10(context),
      ),
      Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: List.generate(
                5,
                    (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.height20(context),
                )),
          ),
          SizedBox(width: Dimensions.width10(context)),
          smallText(text: '4.5', context: context, size: 14),
          SizedBox(width: Dimensions.width10(context)),
          smallText(text: '1278 ', context: context, size: 14),
          SizedBox(width: Dimensions.width10(context)),
          smallText(text: 'comments', context: context, size: 14),
        ],
      ),
      SizedBox(
        height: Dimensions.height10(context),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndText(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: Colors.orangeAccent,
              context: context),
          IconAndText(
              icon: Icons.location_on_outlined,
              text: '1.7 km',
              iconColor: AppColors.mainColor,
              context: context),
          IconAndText(
            icon: Icons.timer,
            text: '32 min',
            iconColor: Colors.redAccent,
            context: context,
          ),
        ],
      ),
    ],
  );
}
