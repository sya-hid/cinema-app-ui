class Category {
  final String emoticon, name;

  Category({required this.emoticon, required this.name});
}

List<Category> categories = [
  Category(
      emoticon: 'smiling-face-with-heart-eyes-32x32-1395589.png',
      name: 'Romance'),
  Category(
      emoticon: 'grinning-face-with-smiling-eyes-32x32-1395548.png',
      name: 'Comedy'),
  Category(emoticon: 'fearful-face-32x32-1395553.png', name: 'Horror'),
  Category(emoticon: 'face-blowing-a-kiss-32x32-1395556.png', name: 'Drama')
];
