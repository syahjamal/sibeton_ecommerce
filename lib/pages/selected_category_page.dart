import 'package:flutter/material.dart';
import 'package:sibeton_ecommerce/blocs/products_bloc.dart';
import 'package:sibeton_ecommerce/models/product.dart';
import 'package:sibeton_ecommerce/widgets/bloc_provider.dart';

class SelectedCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsBloc _productBloc = BlocProvider.of<ProductsBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<Product>>(
        stream: _productBloc.outProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Text(snapshot.data[index].name),
                  );
                });
          }
          return SizedBox();
        },
      ),
    );
  }
}
