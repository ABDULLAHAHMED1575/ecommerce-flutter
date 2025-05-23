import 'package:flutter/material.dart';

class ProductCards extends StatefulWidget {
  final String name;
  final String price;
  final String image_url;
  final String stock;
  const ProductCards({
    super.key,
    required this.name,
    required this.price,
    required this.image_url,
    required this.stock,
  });

  @override
  State<ProductCards> createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 200,
      child: Card(
        child: Column(
          children: [
            Image.network(widget.image_url,height: 150,width: 200,),
            Row(
              children: [
                Text(widget.name),
                Text(widget.price),
                Text(widget.stock),
              ],
            )
          ],
        ),
      ),
    );
  }
}
