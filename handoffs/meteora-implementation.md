# Serah-terima pekerjaan Meteora
Status: BERJALAN · Service: Flutter app · Diperbarui: 2026-11-25

## Sedang dikerjakan
Verifikasi toolchain dan uji runtime setelah implementasi MVVM.

## Status terakhir (apa yang sudah terbukti / sudah deploy)
Implementasi kode sudah ditulis: API Open-Meteo, pencarian berbasis koordinat, favorit SharedPreferences, Home/Search, parsing model, dokumentasi, dan test parser. Belum deploy.

## Keputusan penting
Tidak memakai data cuaca hardcoded. Forecast dihapus saat pemilihan/load lokasi baru agar cuaca kota lama tidak tampil sebagai kota baru. Screenshot tidak dibuat palsu; folder `screenshots/` disiapkan untuk screenshot asli.

## Langkah berikutnya
1. Jalankan `flutter pub get` sampai selesai.
2. Jalankan `dart format .`, `flutter analyze`, dan `flutter test` pada terminal Flutter yang responsif.
3. Jalankan di Android, uji pencarian dua kota, favorit restart, refresh, empty/error/retry, dan screenshot asli.
4. Jika semua lulus, update `CHANGELOG_FIXES.md` menjadi LIVE dan hapus handoff ini.

## Jangan lakukan (jebakan yang sudah ditemukan)
Jangan mengklaim analyze/test lulus berdasarkan percobaan yang timeout. Jangan memasukkan screenshot atau link video fiktif. Jangan memakai reset database atau perintah destruktif.
