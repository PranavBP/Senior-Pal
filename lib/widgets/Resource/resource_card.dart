import 'package:flutter/material.dart';
import 'package:seniorpal/models/resource.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceCard extends StatelessWidget {
  final Resource resource;

  const ResourceCard({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6), // Black background with opacity
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resource.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text
              ),
            ),
            const SizedBox(height: 8),
            if (resource.address.isNotEmpty) ...[
              Text(
                resource.address,
                style: const TextStyle(color: Colors.white), // White text
              ),
              const SizedBox(height: 4),
            ],
            if (resource.phoneNumber.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      resource.phoneNumber,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white), // White text
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
            if (resource.email.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.email, size: 16, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      resource.email,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white), // White text
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
            if (resource.website.isNotEmpty) ...[
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(resource.website);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch ${resource.website}';
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.web, size: 16, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        resource.website,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.blue, // Keep website text blue
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
