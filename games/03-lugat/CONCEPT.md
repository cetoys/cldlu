# LÜGAT

**Tek satır:** Gizli Türkçe kelimeyi bul; her tahmin "anlamca kaçıncı sırada"
olduğunu söyler.
**Tür:** günlük anlamsal kelime bulmacası (Contexto iskeleti) · **Oturum:**
3–10 dk · **Platform:** mobil tarayıcı, tek dosya + günlük statik JSON
**Durum:** konsept · kod yok · gauntlet Aşama 0 (Otobüs yayınlanınca açılır)

## 1. Kanca (1,5 sn)

Ekranda tek giriş kutusu ve altında büyük mono sayı: son tahminin sırası.
Kanca satırı: **"'Çay' 412. sırada. Kelime ne?"** Örnek tahmin önceden
yazılmış gelir (açıcı = merak).

## 2. Çekirdek döngü

```
tahmin yaz → sıra numarası gelir (1 = kelime) → renkli çubuk (yeşil ≤ 100,
sarı ≤ 1000, kırmızı üstü) → liste sıraya göre dizilir → 1 bulunana kadar
```

- Sıralama: gizli kelimeye anlamsal yakınlık (embedding kosinüs), offline
  hesaplanmış 20k kelimelik liste.
- İpucu: günde 3; ipucu sıralamada en yakın kullanılmamış kelimeyi verir.
  İpucu paylaşım bloğunda 💡 olarak görünür (dürüstlük).
- Pes: kelimeyi gösterir, streak kırılmaz ama grid "pes" damgası taşır.

## 3. Bitiş ekranı

Zirve: 1. sıra gelince kutu 1,3× out-back, konfeti 20 parça, tırmanan ses.
Son: kart: **"LÜGAT #142 · 37 tahmin · 💡1"** ve en yakın 5 tahminin yolu.

## 4. Paylaşım artefaktı

```
LÜGAT #142 🟩
37 tahmin · 💡 1
🟥🟥🟨🟨🟨🟩🟩
lugat.app/142
```

Çubuk: tahminlerin sıra dilimlerine göre 7 kutu (yol özeti, spoiler yok).
PNG kart: büyük "37", yol çubuğu, link.

## 5. Geri dönüş

- Günlük kelime, arşiv oynanabilir (tabloya girmez).
- Streak + haftalık ortalama tahmin ("bu hafta ortalaman 41").
- Kariyer: toplam bulunan kelime; "Lügat rütbesi" (kelime sayısı eşikleri).

## 6. Presuasion tablosu

| An | İlke | Uygulama |
|---|---|---|
| Kart | Açıcı | "'Çay' 412. sırada. Kelime ne?" — soru, cevap oyunda |
| İlk tahmin | Karşılıklılık | Örnek tahmin hazır; ilk ipucu bedava |
| Bulma anı | Peak-end | Konfeti + ses + kart |
| Kart | Sosyal kanıt | "Bugün ortalama 52 tahmin; sen 37" (gerçek) |
| Ertesi gün | Kıtlık + tutarlılık | Yeni kelime, streak |

## 7. Klip planı (zayıf kanal; ekran görüntüsü + arkadaş kaydı)

| # | Format | Kanca metni |
|---|---|---|
| 1 | Ekran kaydı, son 5 tahmin | "'Ekmek' 3. sıra. Kelime ne olabilir?" |
| 2 | Arkadaşa oynatma | "Babam 9 tahminde buldu." |
| 3 | Kötü gün | "212 tahmin. Pes ettim." |
| 4 | Tartışma | "Neden 'deniz' 'gemi'den uzak?" (anlam sohbeti) |

## 8. Teknik plan

- Kelime listesi: 20k sık Türkçe lemma (açık lisanslı frekans listesi;
  kaynak ve lisans dokümante edilir). Küfür/hassas kelime filtresi.
- Embedding: tek seferlik offline (çok dilli açık model), gizli kelime
  havuzu 730 kelime (2 yıl). Günlük dosya `data/YYYY-MM-DD.json`:
  `{n, sira: {kelime: sira}}` ~80 KB gz; ya da tek `data/all.bin` + günlük
  ofset. Oyun kodu ≤ 120 KB gz.
- Kelime normalizasyonu: küçük harf, Türkçe İ/ı, çekim ekleri için basit
  lemmatize (ek listesi); listede yoksa "sözlükte yok" (ceza yok).
- Supabase isteğe bağlı: günlük tahmin ortalaması (anon insert, RLS).
- Ölçüm: standart set + `hint_used`, `gave_up`.

## 9. Kesinleşmiş kararlar

- **K1** Günde tek kelime; arşiv var ama tabloya girmez.
- **K2** İpucu 3/gün; paylaşım bloğunda görünür.
- **K3** Sözlükte olmayan tahmin cezasız.
- **K4** Kelime havuzu elle onaylanır (hassas kelime yok).
- **K5** Tek dosya + statik veri; sunucu mantığı yok.

## 10. Bilinen riskler

- Embedding kalitesi Türkçe'de tartışmalı sıralamalar üretir → "neden?"
  tartışması hem risk hem klip malzemesi; sık şikâyetler için manuel düzeltme.
- Kelime listesi lisansı; veri kaynağı belgelenmeli.
- Klip üretmez; büyüme grid + ağızdan ağıza.

## 11. Kabul kriterleri

- [ ] İlk tahmin ≤ 10 sn'de sonuç veriyor
- [ ] Günlük veri ≤ 100 KB gz, offline çalışıyor (yüklendikten sonra)
- [ ] Paylaşım bloğu + PNG kart; link ve tohum var
- [ ] Çekimli tahminler ("çayı", "çaylar") kök kelimeye düşüyor
- [ ] Hassas kelime filtresi testi geçiyor
- [ ] Juice ≥ 8 madde; bulma sekansı ≤ 2 sn
