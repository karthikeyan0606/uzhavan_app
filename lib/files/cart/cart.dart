import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzhavan_app/files/cart/bloc/cart_bloc.dart';
import 'package:uzhavan_app/files/cart/cart_tile_widget.dart';
import 'package:uzhavan_app/files/home/home_product_data_model.dart';
import 'package:uzhavan_app/files/cart/buy_now_dialog.dart'; 

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  // Calculate the total cost 
  double _calculateTotalCost(List<ProductDataModel> cartItems) {
    double totalCost = 0.0;
    for (var item in cartItems) {
      totalCost += item.price;
    }
    return totalCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Purchased Items'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              if (successState.cartItems.isEmpty) {
                return Center(
                  child: Text(
                    'Nothing Found in Purchased...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                );
              } else {
                double totalCost = _calculateTotalCost(successState.cartItems);
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: successState.cartItems.length,
                        itemBuilder: (context, index) {
                          return CartTileWidget(
                            cartBloc: cartBloc,
                            productDataModel: successState.cartItems[index],
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Cost',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '\$${totalCost.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showBuyNowDialog(context); 
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                );
              }

            default:
              return Center(child: Text('An error occurred.'));
          }
        },
      ),
    );
  }
}
