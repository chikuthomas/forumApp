import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:forumapp/constants/constants.dart';
import 'package:forumapp/views/home.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  //loading variable
  final isLoading = false.obs;

  //token variable to store logged in user variable.
  final token = ''.obs;

  //make user of the phones storage to store token .this package needs to be installed in pubspec
  final box = GetStorage();

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      //show loading icon once you click on register

      isLoading.value = true;

      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${url}register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      //returning response

      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);

        //redirect user to home page after successful login
        Get.offAll(()=>const HomePage());
        //debugPrint(response.body);
        //print('Response status: ${response.statusCode}');
        //print('Response body: ${response.body}');
      } else {
        isLoading.value = false;

        Get.snackbar('error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        debugPrint(response.body);
        //print('Response status: ${response.statusCode}');
        //print('Response body: ${response.body}');
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  //login functionality

  Future login({
    required String username,
    required String password,
  }) async {
    try {
      //show loading icon once you click on register

      isLoading.value = true;

      var data = {
        'username': username,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${url}login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      //returning response

      if (response.statusCode == 200) {
        isLoading.value = false;
        //writing token
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);

        //redirect user to home page after successful login
        Get.offAll(()=>const HomePage());
        //debugPrint(response.body);
        //print('Response status: ${response.statusCode}');
        //print('Response body: ${response.body}');
      } else {
        isLoading.value = false;

        Get.snackbar('error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        debugPrint(response.body);
        //print('Response status: ${response.statusCode}');
        //print('Response body: ${response.body}');
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
