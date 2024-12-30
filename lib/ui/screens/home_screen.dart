import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware_app/bloc/product/product_bloc.dart';
import '../../data/repository/product_repository.dart';
import '../../bloc/product/product_event.dart';
import '../../bloc/product/product_state.dart';
import '../screens/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: BlocProvider(
        create: (context) => ProductBloc(ProductRepository())..add(LoadProducts()),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              final products = state.products;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text(product.description),
                    leading: Image.network(product.image, width: 50, height: 50),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail', 
                        arguments: product.id, 
                      );
                    },
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('No products available.'));
          },
        ),
      ),
    );
  }
}
