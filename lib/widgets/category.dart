import 'package:cinema_app_ui/consts.dart';
import 'package:flutter/material.dart';

class CategoryHome extends StatelessWidget {
  final String emoticon, name;
  const CategoryHome({
    Key? key,
    required this.emoticon,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15)),
          child: Image.asset('assets/emoticons/$emoticon'),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: font.copyWith(fontSize: 14, color: white),
        )
      ],
    );
  }
}
