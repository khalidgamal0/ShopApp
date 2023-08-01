import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shoplayout/cubit/ShopCubit.dart';
import '../../layout/shoplayout/cubit/ShopStates.dart';
import '../../shared/commponent/commponent.dart';
import '../../shared/commponent/constent.dart';


class SettingScreen extends StatelessWidget {
  var namecontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var emailcontroller=TextEditingController();

 late String name;
  late String phone;
  late String email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        name= namecontroller.text;
        phone= phonecontroller.text;
        email= emailcontroller.text;
        var cubit=ShopCubit.get(context);
        namecontroller.text=cubit.UserModel!.data ==null?namecontroller.text=name:cubit.UserModel!.data!.name!;
        phonecontroller.text=cubit.UserModel!.data ==null?phonecontroller.text=phone:cubit.UserModel!.data!.phone!;
        emailcontroller.text=cubit.UserModel!.data ==null?emailcontroller.text=email:cubit.UserModel!.data!.email!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if(state is ShopupdateloadingUserData)
                  LinearProgressIndicator(),
                SizedBox(height: 20,),
                defaulTextFormField(
                    controller: namecontroller,
                    labelText: 'Name',
                    prefixIcon: Icons.person,
                    type: TextInputType.name,
                    validate:(value){
                      if(value.isEmpty){
                        return'name must not empty';
                      }
                    }
                ),
                SizedBox(height: 20,),

                defaulTextFormField(
                    controller: emailcontroller,
                    labelText: 'Email Adress',
                    prefixIcon: Icons.email,
                    type: TextInputType.emailAddress,
                    validate:(value){
                      if(value.isEmpty){
                        return'email must not empty';
                      }
                    }
                ),
                SizedBox(height: 20,),

                defaulTextFormField(
                    controller: phonecontroller,
                    labelText: 'Phone',
                    prefixIcon: Icons.phone,
                    type: TextInputType.phone,
                    validate:(value){
                      if(value.isEmpty){
                        return'phone must not empty';
                      }
                    }
                ),
                SizedBox(height: 20,),
                defaultMaterialButton(text: 'update', function:(){
                  ShopCubit.get(context).updateUserDatatosettingscreen(
                    name: namecontroller.text,
                    phone: phonecontroller.text,
                    email: emailcontroller.text,
                  );
                }),
                SizedBox(height: 20,),
                defaultMaterialButton(text: 'Logout', function:(){signOut(context);})
              ],
            ),
          ),
        );
      },

    );
  }
}
