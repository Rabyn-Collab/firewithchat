import 'package:flutter/material.dart';
import 'package:flutter_projects_start/model/post.dart';
import 'package:flutter_projects_start/model/user.dart';
import 'package:flutter_projects_start/provider/crud_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;




class DetailScreen extends StatelessWidget {
 final Post post;
 final types.User user;
 DetailScreen(this.post, this.user);
final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Consumer(
          builder: (context, ref, child) {
            final postStreamData = ref.watch(postStream);
            return ListView(
              children: [
                Hero(
                    tag: post.imageUrl,
                    child: Container(
                        height: 400,
                        child: Image.network(
                          post.imageUrl, width: double.infinity,
                          fit: BoxFit.fitWidth,))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title),
                      SizedBox(height: 15,),
                      Text(post.description),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                            hintText: 'add some comment'
                        ),
                        onFieldSubmitted: (val) {
                          final newComment = Comments(
                              username: user.firstName!,
                              comment: val,
                              imageUrl: user.imageUrl!
                          );
                          ref.read(crudProvider).addComment(postId: post.postId,
                              comments: newComment);
                          commentController.clear();
                        },
                      ),

                      SizedBox(height: 15,),

                      postStreamData.when(
                          data: (data){
                            final currentPost = data.firstWhere((element) => element.postId == post.postId);
                            return  Column(
                              children: currentPost.comments.map((e) {
                                return ListTile(
                                  leading: Image.network(e.imageUrl),
                                  title: Text(e.username),
                                  subtitle: Text(e.comment),
                                );
                              }).toList(),
                            );
                          },
                          error: (err, stack) => Text('$err'),
                          loading: () => Center(child: CircularProgressIndicator(
                            color: Colors.purple,
                          ))
                      )




                    ],
                  ),
                ),

              ],
            );
          }
        )
    );
  }
}
