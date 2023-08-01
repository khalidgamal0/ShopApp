import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/ProductModel/ProductModel.dart';
import 'package:shopapp/moduels/categories/Categories.dart';

import '../../layout/shoplayout/cubit/ShopCubit.dart';
import '../../layout/shoplayout/cubit/ShopStates.dart';
import '../../model/categorymodel.dart';
import '../../shared/commponent/commponent.dart';
import '../../shared/commponent/constent.dart';
import '../../shared/style/color.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {
        if(state  is ShopSuccsessChangeFavorite ){
          if(!state.x.status!){
            showToast(message:state.x.message!,state:ToastStates.ERROR );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:ShopCubit.get(context).homeModel!=null &&ShopCubit.get(context).categorymodel!=null ,
          builder: (context) =>productBuilsder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categorymodel!,context) ,
          fallback: (context) =>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
Widget productBuilsder(HomeModel model,CategoryModel catmodel, context)=>SingleChildScrollView(
  child:  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
          items: model.data!.banners.
          map((e) => Image(image:NetworkImage(e.image!),fit: BoxFit.cover,width: double.infinity,)).toList(),
             options: CarouselOptions(
              height: 200,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              // scrollDirection: Axis.horizontal,
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1
          )),
      Padding(
        padding: const EdgeInsets.all( 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories',style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold),),
            SizedBox(height: 20,),
            Container(height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => categorybuilder(catmodel!.data!.data[index]),
                separatorBuilder:(context, index) =>SizedBox(width: 15,),
                itemCount: catmodel!.data!.data.length),
            ),
            SizedBox(height: 20,),
            Text('New Products',style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold),),
          ],
        ),
      ),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1/1.75,
          children:List.generate(model.data!.products.length,
                  (index) => productGridBuilsder(model!.data!.products[index],context)),
        ),
      ),
    ],
  ),
);

Widget productGridBuilsder(productsModel model,context)=>Container(
  color: Colors.white,
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(image: NetworkImage(model.image!),
            width:double.infinity,height:200,
          ),
          if(model.discount! !=0)
          Container(
            color: Colors.red,
            child: Text('DISCOUNT',style:TextStyle(color: Colors.white),),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.name!,
              style:TextStyle(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,),
              Row(children: [
                Text('${model.price}',
                  style: TextStyle(
                    color: defaultcolor,
                  ),),
                SizedBox(width: 15,),
                if(model.discount! !=0)
                Text('${model.old_price}',
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough
                  ),),
                Spacer(),
                IconButton(onPressed: (){
                  ShopCubit.get(context).changeFavorite(model.id!);
                }, icon:CircleAvatar(
                    radius: 15,
                    backgroundColor:favorites[model.id]!?defaultcolor:Colors.grey,
                    child: Icon(Icons.favorite_outline,color: Colors.white,)))
              ],),
          ],
        ),
      )
    ],
  ),
);

Widget categorybuilder(DataModel model)=>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(
      image: NetworkImage('${model.image}'),
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    ),
    Container(
      width: 100,
      color: Colors.black.withOpacity(.6),
      child: Text('${model.name}',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,),maxLines: 1,overflow: TextOverflow.ellipsis,),
    ),
  ],
);