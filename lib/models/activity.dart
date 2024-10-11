import 'package:flutter/material.dart';
import 'package:seniorpal/models/modules.dart';

class Activity {
  final String name;
  final String desc;
  final String image;
  final List<Module> modules;
  final Widget? data;

  Activity(
      {required this.name,
      required this.desc,
      required this.image,
      required this.modules,
      this.data});
}
