# myportfolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

AI DISCLOSURE:
### TI7
Model yang digunakan: Gemini 4 Argon
- Membantu memahami sintaks dan cara menggunakan Flutter/Dart sekaligus memberikan rancangan apa aja yang harus dibuat dan diedit supaya sesuai dengan TI 7
Link to Chat: https://share.gemini.google/CMGEHNfNqnKn

Jawaban Pertanyaan:
1. Widget Tree dan Hubungan Parent-ChildWidget tree pada Flutter adalah struktur hierarki berbentuk pohon yang menggambarkan bagaimana seluruh widget di dalam aplikasi disusun dan saling terhubung untuk membentuk tampilan UI. Dalam struktur ini, hubungan parent-child bekerja di mana parent widget berfungsi sebagai wadah yang membungkus, mengatur layout, memberikan constraints ukuran, atau meneruskan data kepada satu child maupun beberapa children di dalamnya. Sebaliknya, child widget akan mengikuti aturan layout yang diberikan oleh parent-nya lalu melakukan render tampilannya sendiri di layar, sehingga pengaturan pada parent widget secara otomatis akan memengaruhi posisi maupun perilaku child widget di bawahnya.

2. Widget yang Digunakan dalam Proyek dan Fungsinya
Dalam proyek ini, beberapa widget utama yang digunakan meliputi MaterialApp sebagai kerangka dasar aplikasi yang mengatur theme serta routing, dan Scaffold yang membentuk struktur layar utama beserta AppBar sebagai header bar di bagian atas. Untuk mengatur layout, digunakan widget seperti Padding untuk memberi jarak tepi, Center untuk menempatkan elemen di tengah, serta Column, Row, dan GridView agar elemen tersusun rapi secara vertikal, horizontal, maupun berbentuk grid. Selain itu, terdapat Card dan Container untuk membungkus elemen visual menjadi card atau box, Text dan Icon untuk menampilkan teks serta ikon, InkWell atau ElevatedButton untuk mendeteksi aksi tap dari user, serta SnackBar yang dipanggil melalui ScaffoldMessenger untuk memunculkan pesan pop-up singkat di bagian bawah layar saat tombol ditekan.

3. Fungsi MaterialApp dan Alasan Menjadi Root WidgetWidget MaterialApp berfungsi sebagai wrapper utama yang menyediakan berbagai konfigurasi dan fitur esensial berbasis Material Design untuk aplikasi Flutter. Widget ini umumnya selalu ditempatkan sebagai root widget di posisi paling atas karena di dalamnya sudah tersedia pengaturan global yang dibutuhkan oleh seluruh halaman aplikasi, seperti sistem routing antarhalaman, pengaturan theme melalui ThemeData, hingga manajemen tampilan dasar layar. Dengan meletakkan MaterialApp sebagai root widget, semua child widget di bawahnya dapat langsung mewarisi theme visual yang seragam dan menggunakan komponen Material seperti Scaffold, Dialog, maupun SnackBar tanpa perlu dikonfigurasi ulang satu per satu.

4. Perbedaan StatelessWidget dan StatefulWidget
Perbedaan utama antara StatelessWidget dan StatefulWidget terletak pada kemampuannya menyimpan dan mengubah state internal yang memengaruhi tampilan UI saat aplikasi sedang berjalan. StatelessWidget bersifat statis, artinya setelah widget selesai di-build, tampilannya tidak akan pernah berubah sendiri kecuali ada perubahan data dari parent widget-nya; widget ini cocok dipilih untuk komponen yang tampilannya tetap seperti label text, ikon, atau halaman informasi statis. Sebaliknya, StatefulWidget bersifat dinamis karena memiliki objek State terpisah yang memungkinkan widget melakukan re-render tampilannya secara langsung menggunakan method setState(), sehingga harus digunakan ketika UI perlu berubah secara interaktif mengikuti aksi user atau perubahan data, misalnya pada fitur counter, form input, atau tombol toggle.

5. Pengertian dan Penggunaan BuildContextBuildContext adalah objek penanda yang merepresentasikan lokasi atau posisi spesifik suatu widget di dalam widget tree. Objek ini sangat penting di Flutter karena menjadi jembatan bagi sebuah widget untuk mengetahui posisinya sendiri dan berkomunikasi dengan ancestor widget yang berada di atasnya dalam hierarki tree. Di dalam method build, BuildContext diterima sebagai parameter context dan digunakan untuk mengambil data atau memanggil fitur dari parent maupun ancestor widget di atasnya, contohnya saat kita ingin mengakses warna theme aplikasi dengan Theme.of(context), melakukan navigation halaman dengan Navigator.of(context), atau memunculkan pesan ke layar menggunakan ScaffoldMessenger.of(context).showSnackBar().

6. Konsep Hot Reload vs Hot RestartHot reload adalah fitur di Flutter yang menyuntikkan perubahan code terbaru langsung ke Dart Virtual Machine yang sedang berjalan dan hanya melakukan rebuild pada widget tree dalam hitungan detik tanpa menghilangkan state aplikasi saat itu. Sementara itu, hot restart akan menghapus seluruh state yang tersimpan, melakukan reset nilai variabel kembali ke kondisi awal, dan menjalankan ulang aplikasi dari fungsi main(). Kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart ketika kita mengubah nilai global atau static variable, memodifikasi code di dalam main() atau initState(), serta mengubah tipe widget antara StatelessWidget dan StatefulWidget, sedangkan full restart wajib dilakukan apabila kita menambahkan package atau plugin baru di pubspec.yaml maupun mengubah native code Android dan iOS.

## TI 8

Model yang digunakan: Gemini 4 NEON
- Membantu menjelaskan konsep dan sintaks dasar Flutter/Dart (seperti StatelessWidget vs StatefulWidget, navigasi Navigator, Form, GlobalKey<FormState>, dan penyelesaian error bottom overflow).
- Membantu merancang struktur refactoring berkas ke dalam folder lib/screens/ dan lib/widgets/ serta mengadaptasi halaman formulir baru (ExperienceFormPage) beserta komponen input (TextFormField, showDatePicker, CheckboxListTile) dan aturan validasinya.
- Membantu menyesuaikan tata letak kisi 2x2 (ConstrainedBox dan GridView.count)

Jawaban Pertanyaan:

1. Navigator.push() digunakan untuk menambahkan route baru ke atas navigation stack sehingga halaman sebelumnya tetap tersimpan dan pengguna bisa kembali menggunakan tombol back bawaan perangkat. Navigator.pushReplacement() mengganti route yang sedang aktif dengan halaman baru sambil menghapus halaman sebelumnya dari stack agar navigation history tidak menumpuk. Sementara itu, Navigator.pop() menghapus route paling atas—seperti menutup halaman aktif atau AlertDialog—untuk kembali ke tampilan di bawahnya. Untuk membuka form dari action card (ItemCard), aplikasi menggunakan Navigator.push() agar pengguna tetap bisa kembali ke homepage memakai tombol back. Adapun opsi Halaman Utama pada LeftDrawer menggunakan Navigator.pushReplacement() menuju MyHomePage sehingga halaman form langsung digantikan tanpa menambah stack baru.

2. Susunan Scaffold sebagai root layout di setiap halaman memastikan posisi komponen utama seperti AppBar di atas, drawer di sisi kiri, dan body di area utama selalu seragam di seluruh aplikasi. Dengan memasang widget LeftDrawer yang sama pada MyHomePage, ProjectFormPage, dan ExperienceFormPage, pengguna mendapatkan navigation flow yang konsisten dari halaman mana pun tanpa duplikasi kode. Konsistensi visual juga dijaga melalui konfigurasi tema terpusat di main.dart (seedColor: Color(0xFFBBDD22)), contohnya penggunaan Theme.of(context).colorScheme.primary secara bersamaan sebagai backgroundColor pada AppBar di homepage dan halaman form, warna latar DrawerHeader di LeftDrawer, serta warna tombol Simpan di ExperienceFormPage.

3. Vertical layout menggunakan Column dengan CrossAxisAlignment.stretch dipilih pada experience form agar alur pengisian data dari atas ke bawah—mulai dari posisi, organisasi, deskripsi, tanggal, hingga URL dan tombol Simpan—mudah diikuti dan rapi di berbagai ukuran layar. Spacing widgets seperti Padding dan SizedBox berperan memberikan jarak antar-field serta jarak dari tepi layar supaya komponen tidak saling menempel dan tetap nyaman disentuh. Ketika ukuran layar sempit atau menyusut akibat munculnya on-screen keyboard, scrolling widget SingleChildScrollView membuat seluruh isi form dapat di-scroll sehingga mencegah error bottom overflow dan memastikan semua input field beserta tombol Simpan tetap mudah dijangkau.

4. GlobalKey<FormState> berperan sebagai unique identifier yang menghubungkan tombol Simpan dengan state keseluruhan Form, validator berisi fungsi pengecekan aturan pada masing-masing TextFormField, dan _formKey.currentState!.validate() dipanggil saat tombol Simpan ditekan untuk menjalankan semua validator sekaligus serta memunculkan error message pada field yang tidak valid. Contoh nilai yang ditolak oleh validasi di experience form adalah required field yang hanya berisi whitespace ("   "), end date yang lebih awal daripada start date, atau format URL tanpa protokol seperti "ristek.cs.ui.ac.id". Memilih jenis input widget atau keyboardType (seperti TextInputType.url) saja belum cukup karena pengaturan keyboard hanya membantu kemudahan mengetik tanpa memblokir submission; pengguna tetap bisa membiarkan field kosong, mengetik spasi, atau melakukan paste teks dengan format yang salah sehingga validasi logika tetap dibutuhkan.
