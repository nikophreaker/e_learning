import 'package:flutter/material.dart';

class PageItem extends StatelessWidget {
  const PageItem({
    Key? key,
    required this.controller,
    required this.pageIndex,
    required this.imageUrl,
    required this.title,
    required this.desc,
  }) : super(key: key);

  final PageController controller;
  final int pageIndex;
  final String imageUrl;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          imageUrl,
          scale: 0.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                title,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                desc,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 0),
            ],
          ),
        ),
      ],
    );
  }
}
