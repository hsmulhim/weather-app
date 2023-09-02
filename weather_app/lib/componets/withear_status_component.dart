import 'package:flutter/material.dart';

class WithearStatusComponent extends StatelessWidget {
  const WithearStatusComponent({
    super.key,
    required this.windKph,
    required this.humidity,
    required this.cloud,
  });
  final String windKph;
  final String humidity;
  final String cloud;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 430,
        left: 25,
        child: Container(
          height: 100,
          width: 310,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (Colors.blue).withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.network(
                      'https://www9.0zz0.com/2023/08/31/11/582627949.png',
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$windKph",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Wind Speed',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      'https://www9.0zz0.com/2023/08/31/11/319142916.png',
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$cloud",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Cloudy',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      'https://www9.0zz0.com/2023/08/31/11/477407294.png',
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$humidity",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Humidity',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
