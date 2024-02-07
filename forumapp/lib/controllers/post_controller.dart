import 'dart:convert';
import 'package:forumapp/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {

      //below line prevents  the app from misbehaving in rendering the posts/feeds
      posts.value.clear();

      isLoading.value = true;
      var response = await http.get(
        Uri.parse('${url}feeds'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['feeds'];
        for (var item in content) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        isLoading.value = false;

        print('Response body error: ${response.body}');
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPosts({
    required String content,
  }
  ) async {
    try {
      isLoading.value = true;

      var data ={
        'content':content,
      };

      //Posting the data content to the API url
      var response = await http.post(
        Uri.parse('${url}feed/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      //returning response to the user
      if (response.statusCode == 201) {
        isLoading.value = false;
        print( json.decode(response.body));

      } else {

        Get.snackbar('error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        debugPrint(response.body);
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
