import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/commponent/commponent.dart';
import 'cubit/searchStates.dart';
import 'cubit/searchcubit.dart';

class Search extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return  Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      defaulTextFormField(
                          controller: searchcontroller,
                          labelText:'search',
                          prefixIcon: Icons.search,
                          type:TextInputType.text,
                          validate: (value){
                            if(value.isEmpty){
                              return 'search must not empty';
                            }
                          },
                          onFieldSubmitted:(text){
                            SearchCubit.get(context).getsearch(text);
                          }
                      ),
                      SizedBox(height: 20,),
                      if(state is searchloading)
                      LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      if(state is searcsuccess||state is ShopLoadingGetFavorite||state is ShopChangeFavorite||state is ShopSuccessChangeFavorite||state is ShopErrorChangeFavorite||state is ShopErrorGetFavorite||state is ShopSuccessGetFavorite)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder:(context, index) => BuildProductItem(SearchCubit.get(context).searchmodel!.data!.data[index],SearchCubit.get(context),isoldprise: false),
                            separatorBuilder: (context, index) => mydivider(),
                            itemCount:SearchCubit.get(context).searchmodel!.data!.data.length),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
