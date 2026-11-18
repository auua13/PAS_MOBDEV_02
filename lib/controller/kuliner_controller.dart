import 'package:get/get.dart';
import 'package:pas_gasal_02/models/makanan_model.dart';


// Model Item Keranjang (Menyimpan Makanan + Jumlah Porsinya)
class ItemKeranjang {
  final ModelMakanan makanan;
  var jumlah = 1.obs; // Menggunakan .obs agar reaktif per item

  ItemKeranjang({required this.makanan, int jumlahAwal = 1}) {
    jumlah.value = jumlahAwal;
  }

  double get totalHargaItem => makanan.harga * jumlah.value;
}

class KulinerController extends GetxController {
  // Daftar menu makanan di ListView horizontal
  var daftarMenu = <ModelMakanan>[
    ModelMakanan(id: '1', nama: 'Nasi Goreng Spesial', harga: 25000,deskripsi: "Nasi goreng bumbu rempah dengan telur mata sapi,ayam suwir, dan kerupuk.Gambar: Gunakan aset lokal atau URL gambarmakanan yang valid.", image: ''),
    ModelMakanan(id: '2', nama: 'Mie Ayam Bakso', harga: 20000,deskripsi: "Mie ayam dengan bakso, bumbu rempah, dan sayuran segar.", image: ''),
    ModelMakanan(id: '3', nama: 'Sate Ayam Madura', harga: 30000,deskripsi: "Sate ayam khas Madura dengan bumbu kacang yang lezat.", image: ''),
    ModelMakanan(id: '4', nama: 'Es Teh Manis', harga: 5000,deskripsi: "Minuman teh melati segar dengan gula asli dan es batukristal.Gambar: Gunakan aset lokal atau URL gambarmakanan yang valid.", image: ''),
  ].obs;

  RxList<ModelMakanan> makananList = <ModelMakanan>[].obs;

    @override
  void onInit() { 
    super.onInit();
    makananList.assignAll(daftarMenu); // Inisialisasi makananList dengan daftarMenu
  }

    Future<void> fetchKuliner() async {
    await Future.delayed(const Duration(seconds: 2));
    makananList.assignAll(daftarMenu);
    }

  // List keranjang berisi item yang sudah dipilih beserta jumlahnya
  var keranjang = <ItemKeranjang>[].obs;

  // Fungsi saat makanan dipencet di ListView horizontal
  void tambahKeKeranjang(ModelMakanan makanan) {
    // Cek apakah makanan tersebut sudah ada di keranjang
    var index = keranjang.indexWhere((item) => item.makanan.id == makanan.id);

    if (index >= 0) {
      // Jika sudah ada, tambahkan jumlah porsinya (+1)
      keranjang[index].jumlah.value++;
    } else {
      // Jika belum ada, masukkan sebagai item baru dengan jumlah 1
      keranjang.add(ItemKeranjang(makanan: makanan));
    }

    Get.snackbar(
      'Berhasil', 
      '${makanan.nama} ditambahkan ke pesanan',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  // Fungsi menambah jumlah porsi dari dalam ringkasan
  void tambahJumlah(ItemKeranjang item) {
    item.jumlah.value++;
  }

  // Fungsi mengurangi jumlah porsi dari dalam ringkasan
  void kurangJumlah(ItemKeranjang item) {
    if (item.jumlah.value > 1) {
      item.jumlah.value--;
    } else {
      // Jika jumlah 1 lalu dikurangi, hapus item dari keranjang
      keranjang.remove(item);
    }
  }

  // --- LOGIKA MATEMATIKA TRANSAKSI (MTK) ---
  double get subtotal {
    double total = 0;
    for (var item in keranjang) {
      total += item.totalHargaItem;
    }
    return total;
  }

  double get diskon {
    // Diskon 10% jika subtotal >= Rp 50.000
    if (subtotal >= 50000) {
      return subtotal * 0.10;
    }
    return 0.0;
  }

  double get pajak {
    return (subtotal - diskon) * 0.05; // Pajak/Service 5%
  }

  double get totalBayar {
    return (subtotal - diskon) + pajak;
  }
}