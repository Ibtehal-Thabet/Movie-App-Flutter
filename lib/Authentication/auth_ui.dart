import 'package:flutter/material.dart';

class LayeredBackground extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  LayeredBackground(
      {required this.child, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Shape with Gradient
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF7C3660), // Start color
                Color(0xFF0F8A75), // End color
              ],
            ),
          ),
        ),
        // Inner Shape with Solid Color and Padding
        Container(
          width: width - 8, // Adjusted to create padding effect
          height: height - 8, // Adjusted to create padding effect
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFF19191B),
          ),
          child: Center(child: child),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  CustomButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: LayeredBackground(
        width: double.infinity, // Button width
        height: 50, // Button height
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  dynamic isPassword = false;

  CustomTextField(
      {required this.controller,
      required this.hintText,
      required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return LayeredBackground(
      width: double.infinity,
      height: 50, // TextField height
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
        obscureText: isPassword,
      ),
    );
  }
}

class LayeredRadialBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0x997C3660), // Start color
            Color(0xFF19191B), // Center color
            Color(0xFF19191B), // End color
          ],
          radius: 1.1, // Radius for the gradient
          center: Alignment(
              -0.6, -0.6), // Equivalent to centerX = 0.2, centerY = 0.2
        ),
      ),
    );
  }
}

class LayeredRadialBackgroundOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0x800F8A75), // Start color
            Colors.transparent, // Center color
            Colors.transparent, // End color
          ],
          radius: 1.1, // Radius for the gradient
          center:
              Alignment(0.6, 0.2), // Equivalent to centerX = 0.8, centerY = 0.6
        ),
      ),
    );
  }
}
