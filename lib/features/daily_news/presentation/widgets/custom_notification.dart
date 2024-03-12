import 'package:flutter/material.dart';

class Custom_Notification extends StatelessWidget {
  const Custom_Notification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Icon(Icons.notifications_none_outlined, size: 30),
        Positioned(
          right: 0,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            child: Text(
              '1',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
