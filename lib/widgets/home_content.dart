import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.shoes,
  }) : super(key: key);

  final List<String> shoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 235 + MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Text(
            'Shoes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 30,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Chip(
              backgroundColor: index == 0 ? Colors.black : null,
              label: Text(
                shoes[index],
                style: TextStyle(
                  color: index == 0 ? Colors.white : null,
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: shoes.length,
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
          child: Text(
            "243 OPTIONS",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.2,
              color: Colors.black45,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 0, right: 20),
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 60,
                  width: 120,
                  child: Image.asset(
                    'assets/${index + 1}.png',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Undercover React Presto",
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "GHS 12.97",
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.2,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 30,
            ),
            itemCount: shoes.length,
          ),
        ),
      ],
    );
  }
}
