import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:myportfolio_mobile/widgets/project_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506602334";
  final String nama = "Muhammad Raihan Al Qadri Kusumaputra";
  final String kelas = "PBP B";

  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Proyek", Icons.folder, const Color(0xFF33AAEE)),
    ItemHomepage("Tambah Proyek", Icons.add_circle, const Color(0xFFFFDD44)),
    ItemHomepage("Tambah Pengalaman", Icons.work, const Color(0xFFBBDD22)),
    ItemHomepage("Logout", Icons.logout, const Color(0xFFEE6666)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Membuat ikon garis tiga (drawer) berwarna putih
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Menambahkan LeftDrawer ke dalam Scaffold
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'ようこそ、私のモバイルPortfolioへ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),

                    // === BAGIAN INI YANG DIUBAH ===
                    ConstrainedBox(
                      // Mengatur ukuran total blok 2x2 (kecilkan lagi jika masih kurang mungil)
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.symmetric(
                          vertical: 72,
                          horizontal: 48,
                        ),
                        crossAxisSpacing: 20, // Jarak antar tombol kiri-kanan
                        mainAxisSpacing: 20,  // Jarak antar tombol atas-bawah
                        crossAxisCount: 2,    // Grid 2x2
                        childAspectRatio: 1.0, // Ubah ke 1.0 kalau mau kotak persegi sempurna
                        shrinkWrap: true,
                        children: items.map((ItemHomepage item) {
                          return ItemCard(item);
                        }).toList(),
                      ),
                    ),
                    // === BATAS BAGIAN YANG DIUBAH ===
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}