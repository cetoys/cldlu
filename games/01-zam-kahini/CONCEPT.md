# ZAM KÂHİNİ

**Tek satır:** "Bu ürün 2019'da kaç liraydı?" Günde 6 ürün, tahmin et, sapmanı
gör, spoilersız grid paylaş.
**Tür:** günlük tahmin bulmacası · **Oturum:** 90 sn · **Platform:** mobil
tarayıcı, tek dosya · **Dil:** TR (EN ikinci faz, "then vs now" formatı)
**Durum:** konsept · kod yok · gauntlet Aşama 0

> Gauntlet'in dövdüğü ve inşa ettiği hedef bu dokümandır.

## 1. Kanca (1,5 sn'de ekranda ne var)

Tam ekran ürün görseli (ekmek, çay, benzin, kira, simit…), üstünde büyük mono
sayı hızla dönüyor: `2019 → ? ₺`. Kanca satırı: **"2019'da kaç liraydı?"**
Splash yok, menü yok; ilk dokunuş kaydırıcıyı tutar.

## 2. Çekirdek döngü

```
ürün göster → oyuncu kaydırıcıyla fiyat seçer (log ölçek) → BUL
→ gerçek fiyat sayarak gelir (700 ms) → sapma yüzdesi + renk kutusu
→ 6 üründen sonra: grid + "Cüzdan Yılı" kartı
```

- Kaydırıcı **logaritmik**: 1 ₺ ile 100.000 ₺ aynı çubukta, kira ile simit
  aynı oyunda.
- Renk: 🟩 sapma ≤ %10 · 🟨 ≤ %30 · 🟧 ≤ %60 · 🟥 üstü.
- Günlük 6 ürün sabit sırada, tohum = tarih. Ürün sepeti aylık kürasyon.
- Bonus (7. soru, isteğe bağlı): "Bugün kaç lira?" — yalnızca 4+ yeşilde
  açılır (değişken ödül; nadir).

## 3. Kayıp ekranı (zirve + son)

Zirve: son ürünün gerçek fiyatı sayarak gelirken kaydırıcı **hit-stop** ile
donar (60 ms), sapma büyükse ekran 🟥 flaşı + trauma 0,6 sarsıntı.
Son: kart aşağıdan (400 ms): **"Sen 2021'de kaldın."** (Cüzdan Yılı: tahmin
ortalamalarının hangi yılın fiyatına denk geldiği).

## 4. Paylaşım artefaktı

Metin bloğu (spoilersız):

```
ZAM KÂHİNİ #142 · Cüzdan Yılın: 2021
🟩🟨🟥🟩🟧🟩
Türkiye'nin %71'inden iyi
zamkahini.app/142
```

Ek: PNG kart (1080×1920 ve 1080×1080), canvas'ta çizilir; büyük "2021",
grid, alt şerit link + tohum. `navigator.share` → clipboard fallback.

## 5. Geri dönüş

- Günlük tohum, dünkü tohum kapanır (gerçek kıtlık).
- Streak sayacı ve 🔥; 3. günde "3 gündür buradasın".
- Kariyer: "Sezgi reytingi" (Glicko benzeri değil, basit ortalama sapma
  yüzdesi, düşen iyi). Hiç sıfırlanmaz. Kayıptan sonra kalan sayı bu.
- Haftalık arşiv: geçmiş 7 gün oynanabilir ama grid paylaşımında "arşiv" damgası.

## 6. Presuasion tablosu

| An | İlke | Uygulama |
|---|---|---|
| Kart görülür | Açıcı | İlk satır soru: "2019'da ekmek kaç liraydı?" |
| Açılış | Uyarılma | Dönen sayı, ürün fotoğrafı |
| 1. ürün sonrası | Karşılıklılık | Gerçek fiyat + kaynak + "o günkü asgari ücretle X adet" bilgisi (bedava içerik) |
| 6. ürün | Peak-end | Hit-stop + Cüzdan Yılı kartı |
| Kart | Sosyal kanıt + kimlik | "%71'inden iyi" (Supabase günlük sayaç, gerçek), yıl etiketi |
| Paylaş | Ask | Kart 400 ms göründükten sonra buton |
| Ertesi gün | Kıtlık + tutarlılık | Yeni sepet, streak |

## 7. Klip planı (kelime oyunu; klip zayıf, ekran kaydı güçlü)

| # | Format | Kanca metni |
|---|---|---|
| 1 | Yapımcı ekran kaydı, 6 tahmin | "2019'da benzin kaç liraydı, hatırlıyor musun?" |
| 2 | Sokak röportajı tarzı (arkadaşa oynat) | "Annem 2021'de kaldı." |
| 3 | En kötü tahmin | "%340 saptım." |
| 4 | Arşiv ürün | "Bu simit 2019'da 1 liraydı." |
| 5 | Streak | "12 gündür her sabah bunu oynuyorum." |
| 6 | Bonus soru | "Bugün kaç lira, biliyor musun?" |

## 8. Teknik plan

- `web/index.html` tek dosya ≤ 200 KB gz; ürün görselleri WebP data URI
  (6 × ~12 KB) ya da `data/YYYY-MM-DD.json` statik dosya.
- Veri: `data/items.json` — `{id, ad, birim, fiyat2019, fiyatBugun, kaynak,
  gorsel}`; aylık elle kürasyon; kaynak alanı zorunlu (TÜİK madde fiyatları,
  market arşivi). Kaynaksız ürün oyuna girmez.
- Günlük seçim: `seed = YYYYMMDD`, deterministik karıştırma; ürün 6 farklı
  kategoriden (gıda, ulaşım, barınma, enerji, giyim, hizmet).
- Sosyal kanıt: Supabase `zk_results(day, bucket)` anon insert + günlük
  yüzde sorgusu; RLS: insert + select, update/delete yok (Sepetçi şeması).
  Supabase yoksa kart yüzdesiz çıkar ("ilk gün") — sahte sayı yok.
- Ölçüm: `game_loaded, game_started, first_result, share_completed,
  seed_link_opened, return_d1, streak_3` (Plausible).
- i18n: `STR.tr / STR.en` tek nesne.

## 9. Kesinleşmiş kararlar

- **K1** Günde tek sepet, 6 ürün, tarih tohumu. Sonsuz mod yok.
- **K2** Oyun yorum yapmaz; yalnızca kaynaklı sayı gösterir. Politik metin yok.
- **K3** Sosyal kanıt yüzdesi gerçek veriden gelir; veri yoksa gösterilmez.
- **K4** Paylaşım bloğu spoiler içermez (fiyat yok, renk var).
- **K5** Tek dosya, mobil öncelikli, realtime yok.

## 10. Bilinen riskler

- Fiyat verisinin doğruluğu ve kaynak gösterimi; itiraz gelirse düzeltme
  akışı (formda "yanlış fiyat bildir").
- Politik okunma: hiciv ürün adlarında değil, kimlik etiketinde ("2021'de
  kaldın"); ekonomi yorumu yok.
- Format klonlanabilir; moat = veri kürasyonu + marka sesi + hız.

## 11. Kabul kriterleri

- [ ] 390×844'te ilk kare ≤ 1,5 sn: ürün + soru + dönen sayı
- [ ] İlk sonuç ≤ 20 sn (loaded → first_result)
- [ ] Grid metni ve PNG kart üretiliyor; kartta link + tohum var
- [ ] Tohum linki açıldığında aynı 6 ürün geliyor
- [ ] Supabase kapalıyken oyun tam çalışıyor, yüzde gizli
- [ ] Juice listesinden ≥ 8 madde (motion-graphics §3)
- [ ] Playwright: 9:16'da aksiyon üst %58'de
