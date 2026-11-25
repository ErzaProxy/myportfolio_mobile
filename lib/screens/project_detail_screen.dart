import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:provider/provider.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final baseUrl = context.read<ApiClient>().baseUrl;
    final hasImage = project.thumbnail.trim().isNotEmpty;
    final imageUrl = project.thumbnail.startsWith('http')
        ? project.thumbnail
        : '$baseUrl${project.thumbnail}';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          project.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Text('Gambar tidak dapat dimuat'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    project.nama,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    project.tipeDisplay.isNotEmpty
                        ? project.tipeDisplay
                        : project.tipe,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text('${project.starCount} Stars'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Skillset / Teknologi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(height: 4.0),
            Text(project.skillset),
            const SizedBox(height: 16.0),
            const Text(
              'Deskripsi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(height: 4.0),
            Text(project.deskripsi),
            if (project.link.isNotEmpty) ...[
              const SizedBox(height: 16.0),
              const Text(
                'URL Proyek',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const SizedBox(height: 4.0),
              SelectableText(
                project.link,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
