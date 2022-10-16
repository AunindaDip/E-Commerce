import 'package:flutter/material.dart';
import 'package:symbexecommerce/Controller/Cart_controller.dart';
import 'package:symbexecommerce/Widget/totalCartitem.dart';

class TotalWidget extends StatelessWidget {
  final cartcontroller controller;

  const TotalWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TotalcartItem(
                text: 'Total',
                value: controller.SumCart().toString(),
                controller: controller,
                isSubtotal: false)
          ],
        ),
      ),
    );
  }
}
