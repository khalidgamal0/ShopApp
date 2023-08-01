import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shoplayout/cubit/ShopStates.dart';
import 'package:shopapp/shared/commponent/commponent.dart';
import '../../layout/shoplayout/cubit/ShopCubit.dart';
import '../../model/categorymodel.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Scaffold(
            body:ListView.separated(
                itemBuilder: (context, index) =>buildCatItem(ShopCubit.get(context).categorymodel!.data!.data[index]) ,
                separatorBuilder: (context, index) => mydivider(),
                itemCount: ShopCubit.get(context).categorymodel!.data!.data.length)
        );
      },

    );
  }
  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 20,),
      Text('${model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      Spacer(),
      Icon(Icons.arrow_forward_ios_sharp)
    ],),
  );
}
