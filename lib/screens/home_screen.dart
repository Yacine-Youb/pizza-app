import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pizzeria_app/classes/pizza.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;
  double rotationIncrement = 2 * pi / 5; // Rotate by 72 degrees per click
  double currentAngle = 0.0;
  int selectedIndex = 0;
  // List of image paths
  final List<Pizza> pizzas = [
    Pizza(
        name: 'Margherita', imagePath: 'assets/images/pizza1.png', price: 10.9),
    Pizza(
        name: 'Pepperoni', imagePath: 'assets/images/pizza2.png', price: 12.9),
    Pizza(
        name: 'Vegetarian', imagePath: 'assets/images/pizza3.png', price: 11.9),
    Pizza(name: 'Hawaiian', imagePath: 'assets/images/pizza4.png', price: 13.9),
    Pizza(
        name: 'Meat Lovers',
        imagePath: 'assets/images/pizza5.png',
        price: 14.9),
  ];

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for rotation
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Rotation animation setup
    rotationAnimation =
        Tween<double>(begin: 0.0, end: 0.0).animate(animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width /
        2; // Radius for positioning images around the circle
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pizza',
          style: TextStyle(
              fontFamily: "Lacquer-Regular", fontSize: 50, color: Colors.amber),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Positioned(
                      right: 20, // Centered with adjustment for image size
                      top: 310,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/left-arrow.png",
                                color: Colors.white,
                                width: 30,
                              ),
                              Text(
                                "${pizzas[selectedIndex].price}\$",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(width: 40),
                              Text(
                                pizzas[selectedIndex].name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      )),
                  ...List.generate(pizzas.length, (index) {
                    double angle = (2 * pi / pizzas.length) * index +
                        rotationAnimation.value;
                    double x = radius * cos(angle);
                    double y = radius * sin(angle);

                    return Positioned(
                      right: x - 30, // Centered with adjustment for image size
                      top: 250 + y, // Centered with adjustment for image size
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white,width: 2),
                        ),
                        child: Image.asset(
                          pizzas[index].imagePath,
                          width: 150.0, // Fixed size
                          height: 150.0,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.only(
                        left: 25, right: 15, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 2),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back_ios,
                          size: 40, color: Colors.amber),
                    ),
                  ),
                  color: Colors.amber,
                  onPressed: () {
                    // Increment the target angle for the rotation
                    currentAngle -= rotationIncrement;

                    // Update the animation's end value for rotation
                    rotationAnimation = Tween<double>(
                            begin: rotationAnimation.value, end: currentAngle)
                        .animate(animationController);

                    // Restart the rotation animation
                    animationController.forward(from: 0);

                    if (selectedIndex == 0) {
                      selectedIndex = 4;
                    } else {
                      selectedIndex--;
                    }
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 15, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 2),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_forward_ios,
                          size: 40, color: Colors.amber),
                    ),
                  ),
                  color: Colors.amber,
                  onPressed: () {
                    // Increment the target angle for the rotation
                    currentAngle += rotationIncrement;

                    // Update the animation's end value for rotation
                    rotationAnimation = Tween<double>(
                            begin: rotationAnimation.value, end: currentAngle)
                        .animate(animationController);

                    // Restart the rotation animation
                    animationController.forward(from: 0);

                    if (selectedIndex == 4) {
                      selectedIndex = 0;
                    } else {
                      selectedIndex++;
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
