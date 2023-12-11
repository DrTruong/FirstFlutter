import 'package:first_flutter/apps/refresh_loadmore_gridview/models/color.dart';
import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final ColorInformation colorInfo;

  const ColorItem(this.colorInfo, {super.key});

  Widget _buildTag() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.black12,
      child: Text(
        colorInfo.name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: colorInfo.color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 3),
            blurRadius: 4,
            spreadRadius: 0,
          )
        ],
      ),
      child: _buildTag(),
    );
  }
}
