import 'package:flutter/material.dart';
import 'package:sibeton_ecommerce/blocs/cart_bloc.dart';
import 'package:sibeton_ecommerce/blocs/categories_bloc.dart';
import 'package:sibeton_ecommerce/pages/home_page.dart';
import 'package:sibeton_ecommerce/widgets/bloc_provider.dart';

void main() => runApp(BlocProvider<CartBloc>(
      child: MyApp(),
      bloc: CartBloc(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CategoriesBloc>(
        bloc: CategoriesBloc(),
        child: HomePage(),
      ),
    );
  }
}
