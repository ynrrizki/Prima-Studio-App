import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Film extends Equatable {
  const Film({
    this.id,
    this.title = '',
    this.genre = '',
    this.description = '',
    this.thumbnail = '',
    this.video = '',
    this.starRating,
    // category
    this.isRecomended = false,
    this.isLatest = false,
    this.isComingSoon = false,
    // genre
  });

  final dynamic id;
  final String? title;
  final String? genre;
  final String? description;
  final String? thumbnail;
  final dynamic video;
  final dynamic starRating;
  // category
  final bool isRecomended;
  final bool isLatest;
  final bool isComingSoon;
  // genre

  @override
  List<Object?> get props => [genre, description, thumbnail, video];

  factory Film.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Film(
      id: data.id,
      title: data['title'],
      genre: data['genre'],
      description: data['description'],
      thumbnail: data['thumbnail'],
      video: data['video'],
      isRecomended: data['isRecomended'],
      isLatest: data['isLatest'],
      isComingSoon: data['isComingSoon'],
      starRating: data['starRating'],
    );
  }

  factory Film.fromRating(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Film(
      starRating: data['starRating'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'description': description,
      'thumbnail': thumbnail,
      'video': video,
      'isRecomended': isRecomended,
      'isLatest': isLatest,
      'isComingSoon': isComingSoon,
      'starRating': starRating,
    };
  }

  Map<String, dynamic> toRating(dynamic uid, dynamic email, num rating) {
    return {
      'starRating': {
        uid: {
          'email': email,
          'rating': rating,
        }
      },
    };
  }

  Map<String, dynamic> delRating(dynamic uid, dynamic email, num rating) {
    List<Map> modifiedUsersRating = [];

    modifiedUsersRating.removeWhere((element) => element['uid'] == uid);

    return {
      'starRating': {
        modifiedUsersRating.toString(): {
          'email': email,
          'rating': rating,
        }
      },
    };
  }

  static List<Film> films = const [
    Film(
      id: 1,
      title: 'Miracle in cell no. 7',
      genre: 'Drama, Komedi',
      description:
          'Dodo Rozak hanya ingin menjadi ayah yang baik bagi anaknya, Kartika, sekalipun dia hanyalah pria dengan kecerdasan terbatas, bertingkah dan berperilaku seperti anak-anak. Pada kenyataannya, justru Kartika yang lebih sering menjaga dan merawat ayahnya. Tapi keduanya hidup bahagia. Kartika bangga pada ayahnya yang berjualan balon sehari-harinya.',
      thumbnail:
          'https://firebasestorage.googleapis.com/v0/b/prima-1d716.appspot.com/o/Film%2Fmiracle%20in%20cell%20no7.jpg?alt=media&token=aad9b2d6-c9c3-424a-9c5f-fa893b384d2b',
      video: '[]',
      isRecomended: true,
      isComingSoon: false,
      isLatest: true,
      starRating: {},
    ),
    Film(
        id: 2,
        title: 'Ivanna',
        genre: 'Horor, Mystery',
        description:
            'Ketika Ambar & Dika pindah setelah kematian orang tua mereka, tidak pernah terpikirkan apa yang seharusnya menjadi awal baru berubah menjadi awal kesengsaraan terbesar dalam hidup mereka. Semua akibat kemampuan Ambar merasakan yang tak terlihat, yang didapatkan setelah mengalami gangguan penglihatan.',
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/prima-1d716.appspot.com/o/Film%2Fivanna.jpg?alt=media&token=30fd3e54-895d-4b25-b58a-8f0480758a3e',
        video: '[]',
        isRecomended: true,
        isComingSoon: false,
        isLatest: true,
        starRating: {}),
    Film(
        id: 3,
        title: 'Mencuri Raden Saleh',
        genre: 'Laga, Perampokan, Komedi',
        description:
            'Pencurian terbesar abad ini tinggal menghitung hari menjelang tanggal eksekusinya. Komplotan sudah lengkap dan siap menjalankan misi untuk mencuri lukisan sang maestro, Raden Saleh, yang berjudul Penangkapan Diponegoro. Pemalsuan, peretasan, pertarungan, dan manipulasi terjadi dalam pencurian berencana yang dijalankan oleh sekelompok anak muda amatiran.',
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/prima-1d716.appspot.com/o/Film%2FMencuri%20Raden%20Saleh.jpeg?alt=media&token=09e94fe3-ef44-4ffa-bb2f-3a9977ce7b0b',
        video: '[]',
        isRecomended: true,
        isComingSoon: true,
        isLatest: false,
        starRating: {}),
    Film(
        id: 4,
        title: 'Pamali',
        genre: 'Horor',
        description:
            'Jaka Sunarya yang baru saja kehilangan pekerjaan, bersama dengan sang istri, Rika ingin menjual rumah peninggalan orang tuanya untuk memulai hidup baru. Di desa tersebut, mereka tanpa sengaja melanggar adat yang telah menjadi tradisi, sehingga menghadapi keberadaan makhluk halus yang mengancam nyawa mereka.',
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/prima-1d716.appspot.com/o/Film%2Fpamali.jpg?alt=media&token=17220fcf-fdf5-4411-a6f0-6764131f222d',
        video: '[]',
        isRecomended: false,
        isComingSoon: true,
        isLatest: false,
        starRating: {}),
  ];
}
