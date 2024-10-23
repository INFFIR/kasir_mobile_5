import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/components/bottom_nav_bar.dart';

class MailOpenPage extends StatelessWidget {
  const MailOpenPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar dan tinggi layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('MAIL'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png', // Ganti dengan path gambar Anda
              fit: BoxFit.cover, // Agar gambar menutupi seluruh halaman
            ),
          ),
          // Container untuk konten
          Positioned(
            top: 10, // Jarak dari atas
            left: 10, // Jarak dari kiri
            right: 10, // Jarak dari kanan
            bottom: 10, // Jarak dari bawah
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10.0), // Jarak 10 piksel dari setiap sudut layar
                padding: const EdgeInsets.all(16.0), // Padding di dalam kotak

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // Latar belakang putih dengan sedikit transparansi
                  borderRadius: BorderRadius.circular(12), // Sudut membulat
                ),
                child: Column( // Menggunakan Column untuk menampung isi
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Memastikan konten memenuhi lebar
                  children: [
                    // Kotak untuk konten
                    Container(
                      margin: const EdgeInsets.all(10.0), // Jarak 10 piksel dari setiap sudut layar
                      padding: const EdgeInsets.all(16.0), // Padding di dalam kotak
                      width: screenWidth - 20, // Mengatur lebar kotak untuk mengisi seluruh layar - margin
                      height: screenHeight -20, // Mengatur tinggi kotak sesuai dengan tinggi layar
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F2FA), // Warna kotak
                        borderRadius: BorderRadius.circular(12.0), // Sudut membulat
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam kotak
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pegawai n',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                              Text(
                                '29 - 9 2024 14 : 00 WIB',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10), // Jarak antara header dan teks
                          Expanded(
                            child: SingleChildScrollView(
                              child:                          Text(
                            """
The standard Lorem Ipsum passage, used since the 1500s:
"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC:
"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"

1914 translation by H. Rackham:
"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"

Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC:
"At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."

1914 translation by H. Rackham:
"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.
""",
                            style: TextStyle(color: Colors.black),
                          ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar kotak
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
