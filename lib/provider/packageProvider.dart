// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Package with ChangeNotifier {
  List<dynamic> packages = [];

  final url = dotenv.env['API_URL'];

  Future<String> getPackage() async {
    try {
      final response = await http.get(Uri.parse("$url/pack"));
      if (response.statusCode == 200) {
        packages = json.decode(response.body);
        notifyListeners();
        return "success";
      } else {
        return 'Réponse invalide reçue du serveur! : ${response.statusCode} ';
      }
    } on SocketException {
      return "Impossible d'accéder à Internet!";
    } on FormatException {
      return "Une erreur s'est produite";
    } catch (exception) {
      return exception.toString();
    }
  }
}
