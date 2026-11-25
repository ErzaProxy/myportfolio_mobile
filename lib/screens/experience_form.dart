import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Variabel state untuk menampung input pengalaman
  String _role = "";
  String _organization = "";
  String _description = "";
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;
  String _companyUrl = "";

  // Controller untuk menampilkan tanggal terpilih di dalam TextFormField
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  // Format tanggal DD-MM-YYYY tanpa package tambahan
  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return "$day-$month-$year";
  }

  // Memunculkan kalender (showDatePicker)
  Future<void> _selectDate({required bool isStartDate}) async {
    final DateTime initial = isStartDate
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1990),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text = _formatDate(picked);
        } else {
          _endDate = picked;
          _endDateController.text = _formatDate(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Tambah Pengalaman',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      // Memakai LeftDrawer yang sama dengan halaman utama & Tambah Proyek
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- INPUT 1: POSISI / PERAN ---
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText:
                        "Contoh: Software Engineering Intern / Staf RISTEK",
                    labelText: "Posisi / Peran",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _role = value?.trim() ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Posisi atau peran tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Posisi maksimal 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // --- INPUT 2: PERUSAHAAN / ORGANISASI ---
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: RISTEK Fasilkom UI",
                    labelText: "Perusahaan / Organisasi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _organization = value?.trim() ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama perusahaan atau organisasi tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Nama perusahaan atau organisasi maksimal 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // --- INPUT 3: DESKRIPSI PENGALAMAN ---
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  maxLines: 3, // Kotak teks lebih tinggi untuk deskripsi
                  decoration: InputDecoration(
                    hintText:
                        "Ceritakan tugas dan pencapaianmu di posisi ini...",
                    labelText: "Deskripsi Pengalaman",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value?.trim() ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pengalaman tidak boleh kosong!";
                    }
                    if (value.trim().length > 500) {
                      return "Deskripsi maksimal 500 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // --- INPUT 4: TANGGAL MULAI ---
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Pilih tanggal mulai",
                    labelText: "Tanggal Mulai",
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onTap: () => _selectDate(isStartDate: true),
                  validator: (String? value) {
                    if (_startDate == null || value == null || value.isEmpty) {
                      return "Tanggal mulai wajib dipilih!";
                    }
                    return null;
                  },
                ),
              ),

              // --- INPUT 5: CHECKBOX MASIH BERLANGSUNG ---
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Masih berlangsung sampai sekarang"),
                value: _isCurrent,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  setState(() {
                    _isCurrent = value ?? false;
                    // Jika dicentang, kosongkan tanggal selesai
                    if (_isCurrent) {
                      _endDate = null;
                      _endDateController.clear();
                    }
                  });
                },
              ),

              // --- INPUT 6: TANGGAL SELESAI (Tampil hanya jika tidak sedang berlangsung) ---
              if (!_isCurrent)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _endDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Pilih tanggal selesai",
                      labelText: "Tanggal Selesai",
                      suffixIcon: const Icon(Icons.event),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onTap: () => _selectDate(isStartDate: false),
                    validator: (String? value) {
                      if (_endDate == null || value == null || value.isEmpty) {
                        return "Tanggal selesai wajib dipilih!";
                      }
                      if (_startDate != null &&
                          _endDate!.isBefore(_startDate!)) {
                        return "Tanggal selesai tidak boleh sebelum tanggal mulai!";
                      }
                      return null;
                    },
                  ),
                ),

              // --- INPUT 7: URL ORGANISASI / BUKTI (Opsional, divalidasi jika diisi) ---
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "https://ristek.cs.ui.ac.id (opsional)",
                    labelText: "URL Perusahaan / Organisasi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _companyUrl = value?.trim() ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }
                    final uri = Uri.tryParse(value.trim());
                    final isValidUrl =
                        uri != null &&
                        (uri.scheme == 'http' || uri.scheme == 'https') &&
                        uri.host.isNotEmpty;
                    if (!isValidUrl) {
                      return "Format URL tidak valid! Awali dengan http:// atau https://";
                    }
                    return null;
                  },
                ),
              ),

              // --- TOMBOL SIMPAN ---
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Pengalaman Berhasil Tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Posisi: $_role'),
                                  const SizedBox(height: 4),
                                  Text('Organisasi: $_organization'),
                                  const SizedBox(height: 4),
                                  Text('Deskripsi: $_description'),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tanggal Mulai: ${_formatDate(_startDate!)}',
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tanggal Selesai: ${_isCurrent ? "Sekarang" : _formatDate(_endDate!)}',
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'URL: ${_companyUrl.isEmpty ? "-" : _companyUrl}',
                                  ),
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
                                    _role = "";
                                    _organization = "";
                                    _description = "";
                                    _startDate = null;
                                    _endDate = null;
                                    _isCurrent = false;
                                    _companyUrl = "";
                                    _startDateController.clear();
                                    _endDateController.clear();
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
