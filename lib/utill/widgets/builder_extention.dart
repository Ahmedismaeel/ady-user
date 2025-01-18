import 'package:flutter/material.dart';

extension AddBuilder on Widget {
  withBuilder({required Function(BuildContext) onTap}) {
    return Builder(
      builder: (BuildContext context) {
        return InkWell(
            onTap: () {
              onTap(context);
            },
            child: this);
      },
    );
  }
}
