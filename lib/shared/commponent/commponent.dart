import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/model/ProductData.dart';

import '../../layout/shoplayout/cubit/ShopCubit.dart';
import '../../model/favoriteModel/favoritemodel.dart';
import '../style/color.dart';
import 'constent.dart';

Widget defaultextbutton({required Function function, @required String?  text,}
)=>TextButton(onPressed:(){function();}, child:Text(text!.toUpperCase()),);

Widget defaultMaterialButton({
  double width=double.infinity,
  Color background= Colors.blue,
  bool isuppercase=true,
  @required String text='login',
  @required VoidCallback? function,

})=>  Container(
  height: 50,
  width: double.infinity,
  color: background,
  child: MaterialButton(
    onPressed:function,
    child:Text(isuppercase?text.toUpperCase():text,
      style:
      TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24,
      ),
    ),
  ),
);

Widget defaulTextFormField({
  @required TextEditingController? controller,
  @required String? labelText,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  @required TextInputType? type,
  bool obscureText=false ,
  Function()? suffixpressed,
  Function()? onTap,
  Function(String)? onFieldSubmitted,
  Function(String)? onChanged,
  FormFieldValidator? validate,
})=> TextFormField(
  controller:controller,
  decoration: InputDecoration(
    labelText: labelText,
    prefixIcon:Icon(prefixIcon),
    border: OutlineInputBorder(),
    suffixIcon:suffixIcon!=null?IconButton(onPressed:suffixpressed, icon:Icon(suffixIcon)):null,
  ),
  obscureText: obscureText,
  keyboardType:type,
  onTap:onTap,
  onChanged:onChanged,
  onFieldSubmitted: onFieldSubmitted,
  validator:validate,
);

void NvigateTo(context,Widget)=>Navigator.push
  (
    context,
    MaterialPageRoute(builder:(context) => Widget,)
);

void Nvigateandfinish(context,Widget)=>Navigator.pushAndRemoveUntil
  (
    context,
    MaterialPageRoute(builder:(context)=> Widget,),
      (route) => false,
);
Widget mydivider()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey[300],
);

Widget BuildProductItem( Product product, cubit, {bool isoldprise = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${product.image}'),
              width: 120,
              height: 120,
            ),
            if (product.discount != 0 && isoldprise)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${product.price}',
                        style: TextStyle(
                          color: defaultcolor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (product.discount != 0 && isoldprise)
                        Text(
                          '${product.oldPrice}',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            cubit.changeFavorite(product.id!);
                          },
                          icon: CircleAvatar(
                              radius: 15,
                              backgroundColor:favorites[product.id]!?defaultcolor:Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ))),
                    ],
                  )
                ]),
          ),
        )
      ],
    ),
  ),
);
void showToast({@required String? message, ToastStates? state}) {
  Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ChoseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0);
}
enum ToastStates { SUCCESS, ERROR, WARING }
Color ChoseToastColor(ToastStates state) {
  Color color;
  if (state == ToastStates.SUCCESS) {
    color = Colors.green;
  } else if (state == ToastStates.ERROR) {
    color = Colors.red;
  } else {
    color = Colors.amber;
  }
  return color;
}
