import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/constant.dart';
import 'package:newsapp/features/daily_news/data/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';

class NewsApiServices {
  FirebaseAuth? auth;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Article>> getNewsArticles(
      {String? country, String? category}) async {
    try {
      final response = await http.get(
          Uri.parse(
              '${baseUrl}country=$country&category=$category&apiKey=$apiKey'),
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        Map<String, dynamic> body =
            json.decode(response.body) as Map<String, dynamic>;
        List<Article> articles = [];
        for (var i = 0; i < body['articles'].length; i++) {
          articles.add(Article.fromJson(body['articles'][i]));
        }
        return articles;
      } else {
        throw Exception('Failed to load articles');
      }
    } on SocketException catch (e) {
      throw Exception('No Internet connection');
    }
  }

  //Add to favourite
  Future<bool> addToFavourite(ArticleEntity articleEntity) async {
    try {
// Check if the article is already in the favourite list

      auth = FirebaseAuth.instance;
      final user = auth!.currentUser;

      await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('favourite')
          .where('title', isEqualTo: articleEntity.title)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          throw Exception('Article already in favourite');
        }
      });

      bool result = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('favourite')
          .add(articleEntity.toJson())
          .then((value) => true);
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Remove from favourite
  Future<bool> removeFromFavourite(ArticleEntity articleEntity) async {
    try {
      auth = FirebaseAuth.instance;
      final user = auth!.currentUser;
      print(articleEntity.title);
      bool result = await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('favourite')
          .where('title', isEqualTo: articleEntity.title)
          .get()
          .then((value) {
        for (var element in value.docs) {
          element.reference.delete();
        }
        return true;
      });
      return result;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  //Get favourite articles
  Future<List<ArticleEntity>> getFavouriteArticles() async {
    try {
      auth = FirebaseAuth.instance;
      final user = auth!.currentUser;
      final response = await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('favourite')
          .get();
      List<ArticleEntity> articles = [];
      for (var element in response.docs) {
        articles.add(ArticleEntity.fromJson(element.data()));
      }

      return articles;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}
