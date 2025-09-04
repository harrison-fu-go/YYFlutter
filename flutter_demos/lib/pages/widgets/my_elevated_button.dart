/* File: my_elevated_button.dart
 * Created by GYGES.Harrison on 2025/9/4 at 17:39
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/material.dart';

class IElevatedButton extends StatelessWidget {

  final String title;

  final int? index;

  final Function(int?) onTap;

  const IElevatedButton({super.key, this.index, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onTap(index);
        },
        child: Text(title));
  }

}