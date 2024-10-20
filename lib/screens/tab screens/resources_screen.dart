import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hero_minds/data/resources.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/widgets/Resource/resource_card.dart';

class ResourcesScreen extends ConsumerStatefulWidget {
  // final theme = ref.watch(themeNotifierProvider);

  const ResourcesScreen({super.key});

  @override
  ConsumerState<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends ConsumerState<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Resources",
          style: TextStyle(
            color: theme.textColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.backgroundGradient[0],
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: theme.backgroundGradient,
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: resources.length,
            itemBuilder: (context, index) {
              return ResourceCard(resource: resources[index]);
            },
          ),
        ],
      ),
    );
  }
}
