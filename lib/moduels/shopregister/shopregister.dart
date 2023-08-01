import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/shoplayout/shoplayout.dart';
import 'package:shopapp/moduels/shopregister/cubit/registerCubit.dart';
import 'package:shopapp/moduels/shopregister/cubit/registerStates.dart';
import 'package:shopapp/shared/commponent/commponent.dart';

import '../shoploginscrren/shopLoginScreen.dart';

class ShopRegister extends StatelessWidget {
  var namecontroller=TextEditingController();
  var passcontroller=TextEditingController();
  var emailcontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => registerCubit(),
      child: BlocConsumer<registerCubit,registerStates>(
        listener: (context, state) {
          if (state is registerSuccessState){
            if(state.registerModel.status!){
              print(state.registerModel.data!.token);
              print(state.registerModel.message);
              NvigateTo(context, ShopLayout());
            }
            else{
              print(state.registerModel.message);
              Fluttertoast.showToast(
                  msg:state.registerModel.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (context, state) {
        var cubit= registerCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('REGISTER',style:TextStyle(fontSize: 24,color: Colors.blue),),
                          SizedBox(height: 10,),
                          Text('register now to browes our offer',style:TextStyle(fontSize: 24,color: Colors.grey),),
                          SizedBox(height:20,),
                          defaulTextFormField(
                              controller: namecontroller,
                              labelText: 'Name',
                              prefixIcon: Icons.person,
                              type: TextInputType.name,
                              validate: (value){
                                if(value.isEmpty){
                                  return 'name must not be empty';
                                }
                              }
                          ),
                          SizedBox(height:20,),
                          defaulTextFormField(
                              controller: phonecontroller,
                              labelText: 'Phone',
                              prefixIcon: Icons.phone,
                              type: TextInputType.phone,
                              validate: (value){
                                if(value.isEmpty){
                                  return 'Phone must not be empty';
                                }
                              }
                          ),
                          SizedBox(height:20,),
                          defaulTextFormField(
                              controller: emailcontroller,
                              labelText: 'Email Adress',
                              prefixIcon: Icons.email,
                              type: TextInputType.emailAddress,
                              validate: (value){
                                if(value.isEmpty){
                                  return 'email must not be empty';
                                }
                              }
                          ),
                          SizedBox(height:20,),
                          defaulTextFormField(
                              controller: passcontroller,
                              labelText: 'Password',
                              prefixIcon: Icons.lock,
                              suffixIcon: cubit.suffixIcon,
                              suffixpressed: cubit.changePassvisbility,
                              obscureText: cubit.obscureText,
                              type: TextInputType.visiblePassword,
                              validate: (value){
                                if(value.isEmpty){
                                  return 'Password must not be empty';
                                }
                              }
                          ),
                          SizedBox(height:20,),
                          defaultMaterialButton(text: 'Register', function:(){
                            if(formkey.currentState!.validate()){
                              cubit.userRegister(
                                  name:namecontroller.text,
                                  phone:phonecontroller.text,
                                  email:emailcontroller.text,
                                  password:passcontroller.text
                              );
                            }
                          })

                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
