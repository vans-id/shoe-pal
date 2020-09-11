import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserProductsSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemBuilder: (_, i) => Column(children: <Widget>[
          ListTile(
            leading: Shimmer.fromColors(
              baseColor: Colors.grey[200],
              highlightColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
              ),
            ),
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
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Shimmer.fromColors(
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
                  Shimmer.fromColors(
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
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[700],
          ),
        ]),
        itemCount: 4,
      ),
    );
  }
}
