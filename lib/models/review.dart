

class Review {
  final String? id;
  final String userId; // review giver
  final String? userImage; 
  final String? userName; 
  final String imageReviewCommonId; 
  final DateTime createdAt; // also used as updated at
  final String departureAirport;
  final String arrivalAirport;
  final String airline;
  final String travelClass;
  final String? reviewText;
  final DateTime travelDate;
  final int rating;
  final List<String>? images;
  final int? likes;

  Review({
    this.id,
    required this.userId,
    this.userImage, 
    this.userName, 
    required this.imageReviewCommonId, 
    required this.createdAt, 
    required this.departureAirport,
    required this.arrivalAirport,
    required this.airline,
    required this.travelClass,
     this.reviewText,
    required this.travelDate,
    required this.rating,
     this.images,
     this.likes, 
  });

  factory Review.fromJson(Map<String, dynamic> json) {
  return Review(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    userImage: json['user_image'] as String?,
    userName: json['user_name'] as String?,
    imageReviewCommonId: json['image_review_common_id'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
    departureAirport: json['departure_airport'] as String,
    arrivalAirport: json['arrival_airport'] as String,
    airline: json['airline'] as String,
    travelClass: json['class'] as String,
    reviewText: json['review_text'] as String?,
    travelDate: DateTime.parse(json['travel_date'] as String),
    rating: json['rating'] as int,
    images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    likes: json['likes'] as int?, 
  );
}



  Map<String, dynamic> toJson() {
  return {
    'user_id': userId,
    'user_image': userImage,
    'user_name': userName,
    'image_review_common_id': imageReviewCommonId,
    'created_at': createdAt.toIso8601String(),
    'departure_airport': departureAirport,
    'arrival_airport': arrivalAirport,
    'airline': airline,
    'class': travelClass,
    'review_text': reviewText,
    'travel_date': travelDate.toIso8601String(),
    'rating': rating,
    'images': images,
    'likes': likes,
  };
}

}