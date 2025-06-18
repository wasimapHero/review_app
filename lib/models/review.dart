// Review model with comments and replies
import 'package:review_app/models/comment.dart';

class Review {
  final int id;
  final String departureAirport;
  final String arrivalAirport;
  final String airline;
  final String travelClass;
  final String? reviewText;
  final String travelDate;
  final int rating;
  final List<String>? images;
  final List<Comment>? comments;
  final int? likes;

  Review({
    required this.id,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.airline,
    required this.travelClass,
     this.reviewText,
    required this.travelDate,
    required this.rating,
     this.images,
     this.comments,
     this.likes, 
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      departureAirport: json['departure_airport'],
      arrivalAirport: json['arrival_airport'],
      airline: json['airline'],
      travelClass: json['class'],
      reviewText: json['review_text'],
      travelDate: json['travel_date'],
      rating: json['rating'],
      images: List<String>.from(json['images'] ?? []),
      comments: [],
      likes: 0
    );
  }
}