import 'package:flutter/material.dart';
import 'package:sibeton_ecommerce/blocs/cart_bloc.dart';
import 'package:sibeton_ecommerce/blocs/products_bloc.dart';
import 'package:sibeton_ecommerce/models/product.dart';
import 'package:sibeton_ecommerce/widgets/bloc_provider.dart';
import 'package:sibeton_ecommerce/widgets/cart_button.dart';

class SelectedCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsBloc _productBloc = BlocProvider.of<ProductsBloc>(context);
    final _cartBloc = BlocProvider.of<CartBloc>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          CartButton(),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: _productBloc.outProducts,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = snapshot.data[index];
                    return Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _cartBloc.addProduct(product),
                              child: Center(
                                child: Text(
                                  snapshot.data[index].name,
                                  style: theme.primaryTextTheme.title
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
          }
        },
      ),
    );
  }
}
