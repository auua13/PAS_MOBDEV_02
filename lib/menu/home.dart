import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_gasal_02/controller/kuliner_controller.dart';
import 'package:pas_gasal_02/routes.dart';

class KulinerPage extends StatelessWidget {
  KulinerPage({super.key});

  final controller = Get.put(KulinerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Kuliner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 9, 9, 9),
      ),
      body: Container(
        margin: EdgeInsets.all(0),
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              await controller.fetchKuliner();
            },
            color: Colors.deepPurple,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 16),
                Container(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.makananList.length,
                    itemBuilder: (context, index) {
                      final makanan = controller.makananList[index];
                      return Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Get.toNamed(
                                Routes.detailListProduk,
                                arguments: {
                                  'namaProduk': makanan.nama,
                                  'hargaProduk': makanan.harga,
                                  'imageProduk': makanan.image,
                                  'deskripsiProduk': makanan.deskripsi,
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          makanan.image,
                                          width: double.infinity,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: PopupMenuButton<String>(
                                            icon: const Icon(Icons.more_vert, size: 18, color: Colors.black87),
                                            onSelected: (value) {
                                              if (value == 'detail') {
                                                Get.toNamed(
                                                  Routes.detailListProduk,
                                                  arguments: {
                                                    'namaProduk': makanan.nama,
                                                    'hargaProduk': makanan.harga,
                                                    'imageProduk': makanan.image,
                                                    'deskripsiProduk': makanan.deskripsi,
                                                  },
                                                );
                                              } else if (value == 'hapus') {
                                                
                                                controller.makananList.removeAt(index);

                                                Get.snackbar(
                                                  'Berhasil', 
                                                  '${makanan  .nama} dihapus',
                                                  snackPosition: SnackPosition.BOTTOM,
                                                );
                                              }
                                            },
                                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                              const PopupMenuItem<String>(
                                                value: 'detail',
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 8),
                                                    Text('Detail'),
                                                  ],
                                                ),
                                              ),
                                              const PopupMenuItem<String>(
                                                value: 'hapus',
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 8),
                                                    Text('Hapus', style: TextStyle(color: Colors.red)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(makanan.nama,maxLines: 1,overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),),
                                  Text(makanan.harga as String,style: TextStyle(color: const Color.fromARGB(255, 101, 101, 101),fontWeight: FontWeight.w600,fontSize: 13,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}