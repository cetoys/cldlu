# Viral Oyun Gauntlet — Durum

> Bu dosyayı gauntlet turları günceller. Elle düzenlemek serbest — özellikle
> sırayı değiştirmek ya da bir bulguyu "insan kararı" olarak işaretlemek için.

**Tur:** 0 (gauntlet henüz çalışmadı; insan isteğiyle iki prototip elle üretildi)
**Aktif oyun:** `01-zam-kahini` · **Aşama:** 1 — Çekirdek döngü (prototip var, kanıt bekliyor)
**Sıra:** 01-zam-kahini → 02-otobus → 03-lugat · _İnsan kararı (05.09.2026): Otobüs sıra kilidini beklemeden prototiplendi; iki oyun paralel Aşama 1'de._
**Sıradaki jüri:** #0 — 19 yaşında TR oyuncu
**Yakınsama sayacı:** 0 / 2
**Durum:** çalışıyor — 1 açık P1

---

## Aşama ilerlemesi

| Oyun | Aşama | Tamamlanan maddeler | Kanıt |
|---|---|---|---|
| 01-zam-kahini | 1 | Oynanabilir tek dosya; log kaydırıcı, 6 ürün/gün tohumlu sepet, grid + PNG kart, streak, sezgi sayacı, hit-stop/flaş/sarsıntı | `web/index.html`; Playwright 390×844 tur + kart ekranı alındı (yerel), artifact: https://claude.ai/code/artifact/0407b276-6d76-45ba-8bc6-0bd0b0aaf6bc |
| 02-otobus | 1 (2D hissiyat prototipi) | Ters sarkaç + tutunma/yorulma, tohumlu olay dizisi (fren, kalkış, çukur, dirsek, kapı, viraj), 400 ms ikaz, verlet ragdoll, hit-stop + ağır çekim, 5 sn replay, damga, kart, meydan okuma linki | `web/index.html`; Playwright ölüm→replay→kart akışı doğrulandı (yerel), artifact: https://claude.ai/code/artifact/94022749-7f9d-4a3d-bd46-7761f1643b2c |
| 03-lugat | 0 (kilitli) | — | — |

## Açık bulgular

### B-001 · P1 · Hukuk / içerik editörü (ön bulgu) · Tur 0 · 01-zam-kahini
**İddia:** Fiyat verisi (`ITEMS`, 30 kalem) yaklaşık bellek değerleridir; K2/K3 kaynaklı sayı şartını karşılamıyor.
**Senaryo:** Oyuncu "2019'da kıyma 48 ₺ değildi" der, ekran görüntüsüyle yayar; marka sesi (hiciv = dürüstlük) ilk haftada çöker.
**Etki:** Yayın engeli; oyun içi "Veri taslak" uyarısı geçici yama.
**Önerilen düzeltme:** Her kaleme `kaynak` alanı (TÜİK madde ortalama fiyatları, İBB/İETT tarife arşivi, EPDK/BOTAŞ, resmi asgari ücret) ve ay bilgisi; kaynaksız kalem sepete girmez. TÜFE çarpanları da yıllık TÜİK oranlarıyla yeniden hesaplanır.
**Kanıt gereksinimi:** `data/items.json` + kaynak sütunu dolu; oyun bu dosyadan okur.
**Durum:** açık

### B-002 · P2 · Mobil performans mühendisi (ön bulgu) · Tur 0 · 02-otobus
**İddia:** 2D prototip CONCEPT §8'deki three.js planından sapıyor.
**Gerekçe:** Sepetçi'nin web-prototip yaklaşımı: hissiyat önce 2D'de doğrulanır, 3D port sonra. K kararlarının hiçbiri 3D'yi şart koşmuyor.
**Önerilen düzeltme:** Aşama 2 sonunda karar: 2D kalır (performans, tek dosya ≤ 300 KB) ya da three.js portu ayrı aşama olur. CONCEPT §8 buna göre güncellenir.
**Durum:** açık

## Çözülmüş bulgular

_(yok)_

## P3 listesi

_(yok)_

## İnsan kararı bekleyenler

_(yok)_

## Tur günlüğü

| Tur | Oyun | Aşama | Jüri | Yapılan | Yeni bulgu |
|---|---|---|---|---|---|
| 0 (elle) | 01, 02 | 0→1 | — | İki oynanabilir prototip, build.sh, artifact yayını | B-001 (P1), B-002 (P2) |
