import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shoplayout/cubit/ShopCubit.dart';
import '../../layout/shoplayout/cubit/ShopStates.dart';
import '../../shared/commponent/commponent.dart';
import '../../shared/commponent/constent.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ShopCubit,ShopStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return ConditionalBuilder(
        // condition:ShopCubit.get(context).favoritesModel !=null&& state is! Shoploadinggetfavorite,
        condition:favoritmodel !=null&&ShopCubit.get(context).homeModel!=null,
        builder:(context) =>ListView.separated(
            itemBuilder:(context, index) => BuildProductItem(favoritmodel!.data!.data[index].product!,ShopCubit.get(context)),
            separatorBuilder: (context, index) => mydivider(),
            itemCount:favoritmodel!.data!.data.length),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
    },
  );


  }
}
