import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final Function() onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 20,
        child: Container(
          width: size.width * 0.3,
          height: size.height * 0.15,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 212, 221, 228),
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon,
        ),
      ),
    );
  }
}
