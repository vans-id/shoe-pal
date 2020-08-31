import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoepal/shared/colors.dart';
import 'dart:math';

import 'package:shoepal/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.order.products[0].imageUrl,
                ),
              ),
              title: Text(
                'Rp ${numberFormat(widget.order.ammount.toStringAsFixed(0))}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              trailing: IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            if (_isExpanded)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
                height: min(widget.order.products.length * 20.0 + 60, 180),
                child: ListView(
                  children: widget.order.products.map((prod) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          prod.title,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          '${prod.quantity} x Rp ${numberFormat(prod.price.toStringAsFixed(0))}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
