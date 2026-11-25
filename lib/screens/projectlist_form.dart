import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:myportfolio_mobile/widgets/auth_guard.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _nama = "";
  String _tipe = "web";
  String _deskripsi = "";
  String _thumbnail = "";
  String _link = "";
  String _skillset = "";
  bool _isSubmitting = false;

  static const Map<String, String> _projectTypes = {
    'web': 'Web Development',
    'mobile': 'Mobile App',
    'game': 'Game Development',
    'data': 'Data Science',
    'other': 'Other',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !mounted) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    final newProject = Project(
      nama: _nama,
      tipe: _tipe,
      deskripsi: _deskripsi,
      thumbnail: _thumbnail,
      link: _link,
      skillset: _skillset,
    );

    try {
      final created = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Proyek berhasil tersimpan'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Nama Proyek: ${created.nama}'),
                  Text(
                    'Tipe: ${created.tipeDisplay.isNotEmpty ? created.tipeDisplay : created.tipe}',
                  ),
                  Text('Skillset: ${created.skillset}'),
                  Text('Deskripsi: ${created.deskripsi}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  _formKey.currentState!.reset();
                  setState(() {
                    _nama = "";
                    _tipe = "web";
                    _deskripsi = "";
                    _thumbnail = "";
                    _link = "";
                    _skillset = "";
                  });
                },
              ),
            ],
          );
        },
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Sesi berakhir, silakan login ulang.'),
            ),
          );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Gagal menyimpan proyek (HTTP ${e.statusCode}).'),
            ),
          );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Gagal terhubung ke server: $e')),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Form Tambah Proyek')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. NAMA PROYEK
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Proyek",
                    labelText: "Nama Proyek",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _nama = value.trim(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // 2. TIPE PROYEK
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: DropdownButtonFormField<String>(
                  initialValue: _tipe,
                  decoration: InputDecoration(
                    labelText: "Tipe Proyek",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  items: _projectTypes.entries
                      .map(
                        (entry) => DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _tipe = value;
                      });
                    }
                  },
                ),
              ),

              // 3. SKILLSET / TEKNOLOGI
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Flutter, Django, TypeScript",
                    labelText: "Skillset / Teknologi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _skillset = value.trim(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Skillset tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // 4. DESKRIPSI PROYEK
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Proyek",
                    labelText: "Deskripsi Proyek",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _deskripsi = value.trim(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // 5. THUMBNAIL (Wajib sesuai ProjectSerializer Django kamu)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "/static/img/project/iMaba.png atau https://...",
                    labelText: "Path / URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _thumbnail = value.trim(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Path/URL thumbnail tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // 6. LINK PROYEK (Opsional, divalidasi jika diisi)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "https://example.com (opsional)",
                    labelText: "URL Proyek",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _link = value.trim(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }
                    final uri = Uri.tryParse(value.trim());
                    final isValid =
                        uri != null &&
                        (uri.scheme == 'http' || uri.scheme == 'https') &&
                        uri.host.isNotEmpty;
                    if (!isValid) {
                      return "Format URL tidak valid! Awali dengan http:// atau https://";
                    }
                    return null;
                  },
                ),
              ),

              // TOMBOL SAVE
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
