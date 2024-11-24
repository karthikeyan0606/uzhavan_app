import 'package:flutter/material.dart';
import 'package:uzhavan_app/files/home/bloc/home_bloc.dart';
import 'package:uzhavan_app/files/home/home_product_data_model.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  _ProductTileWidgetState createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool isPurchased = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.productDataModel.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(widget.productDataModel.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(widget.productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${widget.productDataModel.price}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!isPurchased) {
                    widget.homeBloc.add(HomeProductCartButtonClickedEvent(
                        clickedProduct: widget.productDataModel));
                  }
                  setState(() {
                    isPurchased = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPurchased
                      ? Colors.green
                      : Colors.green[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    if (isPurchased)
                      const Icon(Icons.check, color: Colors.white),
                    Text(
                      isPurchased ? "Purchased" : "Purchase",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
