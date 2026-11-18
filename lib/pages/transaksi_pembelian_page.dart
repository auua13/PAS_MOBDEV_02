import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_gasal_02/controller/transaksi_pembelian_controller.dart';
import 'package:pas_gasal_02/components/loginclone_image1.dart';
import 'package:pas_gasal_02/controller/kuliner_controller.dart';

class DetailListProdukPage extends StatelessWidget {
  DetailListProdukPage({super.key});

  final controller = Get.put(TransaksiPembelianController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Detail Produk', style: TextStyle(fontWeight: FontWeight.bold)),
         backgroundColor: Colors.green[500],
          foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 220,margin: const EdgeInsets.symmetric(horizontal: 16),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16),border: Border.all(color: Colors.grey.shade300),),
               child: Image.asset(controller.imageMakanan,fit: BoxFit.contain,),
            ),
            const SizedBox(height: 16),
 
            Container(padding: const EdgeInsets.all(16),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16),border: Border.all(color: Colors.grey.shade300),),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" ${controller.namaMakanan}", style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),),
                  Text(" ${controller.hargaMakanan}", style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[600]),),
                
                  
                  const Divider(height: 24),

                  Text("Deskripsi Makanan",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[600]),),
                  const SizedBox(height: 4),
                  Text(controller.deskripsiMakanan,style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),),

                  const Divider(height: 24),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              "Keranjang Pesanan Anda:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            flex: 2,
            child: Obx(
              () => controller.keranjang.isEmpty
                  ? const Center(
                      child: Text("Belum ada makanan yang dipilih", style: TextStyle(color: Colors.grey)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.keranjang.length,
                      itemBuilder: (context, index) {
                        final item = controller.keranjang[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(item.makanan.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Rp ${item.makanan.harga.toStringAsFixed(0)} x ${item.jumlah.value} = Rp ${item.totalHargaItem.toStringAsFixed(0)}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                  onPressed: () => controller.kurangJumlah(item),
                                ),
                                Obx(() => Text('${item.jumlah.value}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                  onPressed: () => controller.tambahJumlah(item),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),


            ElevatedButton(
              onPressed: Get.back,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[500],
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Kembali",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}