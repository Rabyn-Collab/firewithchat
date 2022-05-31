



class Users {
final String email;
final String userId;
final String userImage;
final String username;


Users({
  required this.email,
  required this.userId,
  required this.userImage,
  required this.username
});


factory Users.fromJson(Map<String, dynamic> json){
  return Users(
      email: json['email'],
      userId:  json['userId'],
      userImage: json['userImage'],
      username: json['username']
  );
}




}