import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final Icon icon;
  const CustomButton({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 20,
        child: Container(
          width: width * 0.3,
          height: height * 0.15,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 212, 221, 228),
              borderRadius: BorderRadius.circular(10)),
          child: icon,
        ),
      ),
    );
  }
}
