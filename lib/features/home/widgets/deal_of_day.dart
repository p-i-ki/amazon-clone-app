import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: const Text(
            'Deal of the day',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.asset(
          'assets/images/macbook-459196_1280.jpg',
          height: 235,
          //the image will try to fit within the given height 235
          fit: BoxFit.fitHeight,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            '\$100',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text('Piki'),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/macbook-459196_1280.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.fitWidth,
              ),
              Image.asset(
                'assets/images/macbook-459196_1280.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.fitWidth,
              ),
              Image.asset(
                'assets/images/macbook-459196_1280.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.fitWidth,
              ),
              Image.asset(
                'assets/images/macbook-459196_1280.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Text(
            'See all deals',
            style: TextStyle(color: Colors.cyan[800]),
          ),
        )
      ],
    );
  }
}
