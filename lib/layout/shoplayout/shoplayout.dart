import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/commponent/commponent.dart';
import '../../moduels/search/Search.dart';
import 'cubit/ShopCubit.dart';
import 'cubit/ShopStates.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..UserHomeData()..getcategoryData()..getfavoriteproduct()..getUserDatatosettingscreen(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=ShopCubit.get(context);
          return  Scaffold(
            appBar: AppBar( title: const Text('salla'),
              actions: [
                IconButton(onPressed: (){
                  NvigateTo(context,Search());
                }, icon:const Icon(Icons.search))
              ],),
            body:cubit.BottomScreens[cubit.cuurent_index],
            bottomNavigationBar:BottomNavigationBar(
              onTap:(index){
                cubit.changeBottomScreens(index);
              } ,
              currentIndex:cubit.cuurent_index,
              items: const [
                BottomNavigationBarItem(icon:Icon(Icons.home),label: 'home'),
                BottomNavigationBarItem(icon:Icon(Icons.apps),label: 'Categories'),
                BottomNavigationBarItem(icon:Icon(Icons.favorite),label: 'favorite'),
                BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'settings'),
              ],
            ),
          );
        },
      ),
    );
  }
}
