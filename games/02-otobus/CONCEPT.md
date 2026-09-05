# OTOBÜS

**Tek satır:** Kalabalık otobüste ayakta dur; şoför frene basınca uçma.
**Tür:** 3D fizik/denge, öfke oyunu · **Oturum:** 30–90 sn · **Platform:**
mobil tarayıcı, three.js tek IIFE (Sepetçi boru hattı) · **Dil:** TR/EN
**Durum:** konsept · kod yok · gauntlet Aşama 0 (Zam Kâhini yayınlanınca açılır)

## 1. Kanca (1,5 sn)

Omuz kamerası, karakter koridorda sallanıyor, arkada yolcular, ön camda
İstanbul trafiği kayıyor. Kanca satırı: **"Ani frende kaç saniye dayanırsın?"**
Sayaç ekranın üstünde akıyor. İlk dokunuşta tutamağa uzanır.

## 2. Çekirdek döngü

```
hat başlar (günlük tohumlu olay dizisi) → oyuncu ağırlık merkezini parmakla sürükler
→ olay: fren / kalkış / viraj / çukur / kapı / dirsek atan yolcu
→ tutamak varsa DOKUN-BAS ile tutunur (yorulma çubuğu iner)
→ düşerse ragdoll + replay → kart
```

- Kontrol: tek parmak. Sürükle = eğil; bas-tut = tutun (tutamak menzildeyse).
  Tutunmak güvenli ama **yorulma** birikir; bırakıp dinlenmek gerekir. Gerilim
  tek cümle: *tutunursan yorulursun, bırakırsan uçarsın.*
- Olaylar tohumdan gelir; ikaz 400 ms önce (fren lambası, şoförün "tutunun"
  bağırışı, kamera hafif öne yatar). İkaz olmadan ceza haksızlıktır.
- Skor: ayakta kalınan saniye × kombo (art arda atlatılan olay).
- Dash yerine **"sıyırma"**: olay anında tam zamanında bırak-tut → +250 ve
  "Usta" damgası (Sepetçi'nin i-frame sıyırmasıyla aynı psikoloji).

## 3. Kayıp ekranı

Zirve: darbe anı hit-stop 120 ms, trauma 1,0, 0,25× ağır çekim 300 ms, ragdoll
koridorda savrulur, kamera düşüşü takip eder. Damga: **"Seni düşüren: ANİ
FREN"** (olay adı). Son: 5 sn replay sinematiği başlar, kart üstüne biner.

## 4. Paylaşım artefaktı

- **5 sn replay** (halka tampon 20 Hz, Sepetçi `ReplayRecorder` portu):
  kamera 120° döner, son 1 sn 0,35×, üstte skor + damga + link. WebM
  `MediaRecorder`; Safari'de PNG kart.
- **Kart:** "47 sn · x4 kombo · Seni düşüren: ÇUKUR · Hat 34 · otobus.app/34"
- **Meydan okuma linki:** `?hat=20260905&hedef=47` → açan kişi ekranda
  "Ali: 47 sn" çizgisini görür; geçince kartta "Ali'yi geçtin".

## 5. Geri dönüş

- Günün hattı (tohum): herkes aynı olay dizisi; lider tablosu günlük.
- Kariyer: toplam ayakta saniye ("3 saat 12 dk ayakta kaldın"), hiç
  sıfırlanmaz.
- Açılan hatlar: kariyer eşiklerinde yeni araç (metrobüs, dolmuş, vapur
  — vapur sallanır ama fren yok, komedi değişir). Kilit görünür ve çubuk taşır.

## 6. Presuasion tablosu

| An | İlke | Uygulama |
|---|---|---|
| Klip ilk kare | Açıcı + uyarılma | Karakter zaten sallanıyor, sayaç akıyor |
| İlk 10 sn | Karşılıklılık | Kolay hat parçası, ilk kombo bedava gelir |
| Düşüş | Peak-end | Hit-stop + ragdoll + damga |
| Kart | Sosyal kanıt + kimlik | "Bugün 2.318 kişi bindi, %64'ü ilk frende düştü" (gerçek) |
| Paylaş | Ask | Replay bittikten sonra buton |
| Ertesi gün | Kıtlık | Yeni hat; dünkü hat arşivde, tabloya girmez |

## 7. Klip planı (bu oyun klip motorudur)

| # | Format | Kanca metni |
|---|---|---|
| 1 | Replay: ilk frende uçuş | "Şoför ilk frende beni cama yapıştırdı." |
| 2 | Uzun tutunma, yorulma | "47 saniye. Kollarım koptu." |
| 3 | Sıyırma anı ağır çekim | "Tam zamanında bıraktım." |
| 4 | Yolcu dirseği | "Beni fren değil teyze düşürdü." |
| 5 | Günün hattı | "Bugün 34 numara. Kaç saniye?" |
| 6 | Bug/fizik komedisi | "Bu bug'ı düzeltmeyeceğim." |

## 8. Teknik plan

- Sepetçi `web-prototype` boru hattı: `head.html + body.html + game.js →
  build.mjs → dist.html`; three 0.185, esbuild. Toplam ≤ 1,5 MB (tek düşük
  poli karakter + otobüs içi).
- Fizik: karakter = ters sarkaç (tek serbestlik + yanal), ragdoll = mevcut
  `RagdollController` portu; yolcular statik kapsüller (performans).
- Olay sistemi: `route.json` tohumdan üretilir: `{t, tip, siddet, ikaz}`.
- Lider tablosu: Supabase `otobus_scores(day, name, seconds, combo)`, RLS
  Sepetçi şeması, kısıtlar: isim 1–14, saniye 0–1800.
- Kalite kademesi: `QualityDirector` portu; 30 FPS altı → gölge kapalı, DPR 1.
- Ölçüm: aynı olay seti + `replay_exported`, `challenge_opened`.

## 9. Kesinleşmiş kararlar

- **K1** Tek parmak kontrol; tilt (ivmeölçer) yok (izin ekranı sürtünme).
- **K2** Her olayın ≥ 400 ms ikazı var.
- **K3** Replay otomatik kaydedilir; oyuncu hiçbir şey açmaz.
- **K4** Sepetçi marka sesi: hiciv damgalar, "seni düşüren" formatı.
- **K5** Günlük hat + kariyer sayacı; sonsuz rastgele mod yalnızca arşiv.

## 10. Bilinen riskler

- Mobil performans (3D + ragdoll) — en büyük teknik risk; düşük cihazda
  test şart.
- Fizik "haksızlık" hissi → öfke oyununun iyi öfkesi (benim hatam) ile kötü
  öfkesi (oyunun hatası) arasındaki çizgi ikazla korunur.
- Replay dışa aktarma tarayıcı desteği; Safari fallback.

## 11. Kabul kriterleri

- [ ] Orta segment Android'de ≥ 30 FPS, ilk boyama ≤ 2 sn
- [ ] İlk düşüş ≤ 30 sn'de (ilk sonuç hızlı)
- [ ] Replay WebM üretiliyor (Chrome/Android), PNG fallback (Safari)
- [ ] Meydan okuma linki rakip çizgisini gösteriyor
- [ ] Juice ≥ 10 madde; ölüm sekansı 2,5 sn ve atlanabilir
- [ ] 9:16'da aksiyon üst %58'de (Playwright)
