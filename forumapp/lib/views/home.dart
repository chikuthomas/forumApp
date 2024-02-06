import 'package:flutter/material.dart';
import './widgets/post_data.dart';
import './widgets/post_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();

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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            PostField(
              hintText: 'What do you want to ask?',
              controller: _postController,
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
              onPressed: () {},
              child: const Text('Post'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Posts'),
            const SizedBox(
              height: 20,
            ),
            post_data(),
            post_data(),
            post_data(),
          ]),
        ),
      ),
    );
  }
}

