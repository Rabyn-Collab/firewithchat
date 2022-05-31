


class Comments{
  final String username;
  final String imageUrl;
  final String comment;

   Comments({
    required this.username,
     required this.comment,
     required this.imageUrl
});

   factory Comments.fromJson(Map<String, dynamic> json){
      return Comments(
          username: json['username'],
          comment: json['comment'],
          imageUrl: json['imageUrl']
      );
   }


    Map<String, dynamic> toJson(){
      return {
        'username': this.username,
        'comment': this.comment,
        'imageUrl': this.imageUrl
      };
    }

}





class Like{
  final int likes;
  final List<String> usernames;


  Like({required this.likes, required this.usernames});

  factory Like.fromJson(Map<String, dynamic> json){
    return Like(
        usernames: (json['usernames'] as List).map((e) => e as String).toList(),
        likes: json['likes']
    );
  }


  Map<String, dynamic> toJson(){
    return {
      'usernames': this.usernames,
      'likes': this.likes,
    };
  }


}

class Post {
  final String postId;
  final String userId;
  final String title;
  final String description;
  final String imageUrl;
  final String imageId;
  final List<Comments> comments;
  final Like like;


  Post({
    required this.like,
    required this.imageUrl,
    required this.title,
    required this.comments,
    required this.description,
    required this.imageId,
    required this.postId,
    required this.userId
});







}