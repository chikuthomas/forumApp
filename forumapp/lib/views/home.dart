import 'package:flutter/material.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:get/get.dart';
import './widgets/post_data.dart';
import './widgets/post_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum App'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            PostField(
              hintText: 'What do you want to ask?',
              controller: _textController,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              onPressed: () async {
                await _postController.createPosts(
                    content: _textController.text.trim());

                //this clears the input field after posting
                _textController.clear();
                _postController.getAllPosts();
              },
              child: Obx(() {
                return _postController.isLoading.value
                    ?  CircularProgressIndicator(
                          color: Colors.white,
                        )

                    : Text('Post');
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Posts'),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () {
                return _postController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _postController.posts.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: post_data(
                              post: _postController.posts.value[index],
                            ),
                          );
                        },
                      );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
