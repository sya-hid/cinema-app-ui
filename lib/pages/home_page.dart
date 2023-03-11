import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_app_ui/consts.dart';
import 'package:cinema_app_ui/models/category_model.dart';
import 'package:cinema_app_ui/models/movie_model.dart';
import 'package:cinema_app_ui/pages/detail_page.dart';
import 'package:cinema_app_ui/widgets/category.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? controller;
  double viewPortFraction = 0.6;
  double? pageOffset = 1;
  int currentMovie = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        PageController(initialPage: 1, viewportFraction: viewPortFraction)
          ..addListener(() {
            setState(() {
              pageOffset = controller!.page;
            });
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Welcome Angelina',
                          style: font.copyWith(
                              fontSize: 14, color: white.withOpacity(0.8))),
                      const SizedBox(width: 5),
                      Image.asset(
                        'assets/emoticons/hand.png',
                        width: 24,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Let\'s relax and watch movie !',
                      style: font.copyWith(
                          fontSize: 14,
                          color: white.withOpacity(0.8),
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/profile.jpg'),
                        fit: BoxFit.fill)),
              )
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(30)),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: white.withOpacity(0.7),
                    ),
                    hintStyle: font.copyWith(color: white.withOpacity(0.7))),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: font.copyWith(
                      color: white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      'See All',
                      style: font.copyWith(fontSize: 14, color: orange),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: orange,
                      size: 20,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                    categories.length,
                    (index) => CategoryHome(
                          emoticon: categories[index].emoticon,
                          name: categories[index].name,
                        ))
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Showing this month',
              style: font.copyWith(
                  color: white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                PageView.builder(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      currentMovie = value % movies.length;
                    });
                  },
                  itemBuilder: (context, index) {
                    double scale = max(viewPortFraction,
                        (1 - (pageOffset! - index).abs() + viewPortFraction));
                    double angle = 0.0;
                    if (controller!.position.haveDimensions) {
                      angle = index.toDouble() - (controller!.page ?? 0);
                      angle = (angle * 5).clamp(-5, 5);
                    } else {
                      angle = index.toDouble() - 1;
                      angle = (angle * 5).clamp(-5, 5);
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      movie: movies[index % movies.length],
                                    )));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 100 - (scale / 1.6 * 100)),
                        child: Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Transform.rotate(
                              angle: angle * pi / 180,
                              child: Hero(
                                tag: movies[index % movies.length].title,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: CachedNetworkImage(
                                    key: UniqueKey(),
                                    height: 300,
                                    width: 206,
                                    imageUrl:
                                        movies[index % movies.length].poster,
                                    errorWidget: (context, url, error) {
                                      return const Icon(Icons.error);
                                    },
                                    progressIndicatorBuilder:
                                        (context, url, progress) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 330,
                  child: Row(
                    children: [
                      ...List.generate(
                          movies.length,
                          (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: index == movies.length - 1
                                    ? const EdgeInsets.only()
                                    : const EdgeInsets.only(right: 15),
                                width: currentMovie == index ? 30 : 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color:
                                        currentMovie == index ? orange : white,
                                    borderRadius: BorderRadius.circular(15)),
                              ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
