import 'package:flutter/material.dart';

const double _size = 80.0;

class CircularImageContainer extends StatelessWidget {
  const CircularImageContainer({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      width: _size + 10.0,
      height: _size + 10.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: _size,
          height: _size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
