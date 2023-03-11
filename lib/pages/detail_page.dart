import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_app_ui/consts.dart';
import 'package:cinema_app_ui/models/movie_model.dart';
import 'package:cinema_app_ui/pages/reservation_page.dart';
import 'package:cinema_app_ui/widgets/category_item.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;
  const DetailPage({super.key, required this.movie});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: white,
            size: 20,
          ),
        ),
        title: Text(
          'Movie Detail',
          style: font.copyWith(fontSize: 14, color: white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              height: 335,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: widget.movie.title,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                        key: UniqueKey(),
                        height: 335,
                        width: 225,
                        imageUrl: widget.movie.poster,
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
                        progressIndicatorBuilder: (context, url, progress) {
                          return Center(
                              child: CircularProgressIndicator(
                            value: progress.progress,
                          ));
                        },
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CategoryItem(
                        icon: Icons.videocam_rounded,
                        category: 'Genre',
                        categoryValue: widget.movie.genre,
                      ),
                      CategoryItem(
                        icon: Icons.access_time_filled,
                        category: 'Duration',
                        categoryValue: formatTime(
                            Duration(minutes: widget.movie.duration)),
                      ),
                      CategoryItem(
                        icon: Icons.videocam_rounded,
                        category: 'Rating',
                        categoryValue: '${widget.movie.rating} / 10',
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              widget.movie.title,
              style: font.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold, color: white),
            ),
            const SizedBox(height: 30),
            Divider(
              color: white.withOpacity(0.3),
              height: 1,
            ),
            const SizedBox(height: 20),
            Text(
              'Synopsis',
              style: font.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold, color: white),
            ),
            const SizedBox(height: 20),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [white, white.withOpacity(0.1)],
                  stops: const [0.3, 1.0],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                ).createShader(Rect.fromLTRB(0, 0, 0, bounds.height));
              },
              child: Text(
                widget.movie.synopsis,
                maxLines: 8,
                style: font.copyWith(color: white, height: 2, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReservationPage()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: orange,
                height: 66,
                child: Center(
                  child: Text(
                    'Get Reservation',
                    style: font.copyWith(
                        fontSize: 14,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
