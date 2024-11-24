import 'package:flutter/material.dart';

void showBuyNowDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success!'),
        content: const Text(
            'The Product was successfully purchased! Check your products on the Purchased Items.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Hide'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thanks For Purchasing !')),
              );
            },
          ),
        ],
      );
    },
  );
}
