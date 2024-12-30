import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/detail/detail_bloc.dart';
import '../../bloc/detail/detail_event.dart';
import '../../bloc/detail/detail_state.dart';
import '../../data/repository/product_repository.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int productId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(title: Text('Product Detail')),
      body: BlocProvider(
        create: (context) => DetailBloc(ProductRepository())..add(LoadDetail(productId)),
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DetailLoaded) {
              final product = state.product;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(product.image, height: 200),
                    SizedBox(height: 16),
                    Text(product.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(product.description, style: TextStyle(fontSize: 16)),
                  ],
                ),
              );
            } else if (state is DetailError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Loading...'));
          },
        ),
      ),
    );
  }
}
