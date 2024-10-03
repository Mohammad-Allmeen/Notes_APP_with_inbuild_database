import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation

    // Create a Tween Animation for scaling
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
    ));

    // Navigate to HomePage after 5 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation, // Apply the animation
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.network("https://cdn-icons-png.flaticon.com/512/8167/8167238.png",
width:220,
                    height: 220,
                ),
                ),
                backgroundColor: Colors.white, //// Fallback color
                radius: 100, // Adjust radius to fit your design
              ),
            ),
            SizedBox(height: 20), // Add some spacing
            Text(
              "Notes App",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Adjust text color for visibility
              ),
            ),
            SizedBox(
              height: 20,
            ),
           // Text("Write what you think" ,style: TextStyle(fontSize:15, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
