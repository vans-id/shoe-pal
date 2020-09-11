import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrdersSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 16,
        ),
        child: Card(
          elevation: 3,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.white,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.white,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                trailing: Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.white,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
