---
name: motion-graphics
description: Oyun ve kısa video için hareket tasarımı. Juice (hit-stop, ekran sarsıntısı, squash-stretch, pop-up sayılar), easing ve zamanlama tabloları, kayıp/kazanç sekansları, paylaşım kartı ve replay animasyonu, 9:16 klip kompozisyonu, ilk 1,5 saniye kanca karesi, CSS/canvas/three.js uygulama kalıpları. "Motion", "animasyon", "juice", "hit-stop", "screen shake", "easing", "klip", "reels/tiktok kompozisyonu", "geçiş", "UI animasyonu" istendiğinde kullan.
---

# Motion Graphics (oyun + klip)

Hareket, oyunun **hissini** ve klibin **izlenebilirliğini** belirler. Cansız
kare dizisi izlenmez; aşırı hareket de okunmaz. Bu skill iki soruya cevap
verir: *ne zaman ne kadar hareket* ve *bunu tek dosyada nasıl yazarım*.

## 1. Üç kural

1. **Her olayın üç fazı var:** hazırlık (anticipation) → vuruş (impact) →
   toparlanma (follow-through). Vuruşu olmayan hareket "kayıyor" hissi verir.
2. **Önemli olay = zaman manipülasyonu.** Hit-stop (60–120 ms donma) ve
   ağır çekim (0,25× 300 ms) en ucuz ve en güçlü juice. Sepetçi `HitStop.cs`
   ve `cam.trauma²` sarsıntı modeli örnek.
3. **Bir ekranda tek orkestre edilmiş an.** Her şey aynı anda hareket ederse
   hiçbir şey hareket etmez. Sepetçi: perde açıkken kamera arenada yavaşça
   döner, oyuna geçişte omuz açısına oturur; başka hiçbir şey kıpırdamaz.

## 2. Zamanlama tablosu (varsayılanlar, ms)

| Olay | Süre | Easing | Not |
|---|---|---|---|
| Buton basma | 80 in / 160 out | `cubic-bezier(.2,.9,.3,1.2)` | Scale 0,96 → 1,0; overshoot küçük |
| Panel açılış | 220 | `cubic-bezier(.16,1,.3,1)` (expo-out) | Y 12 px + opacity |
| Panel kapanış | 140 | ease-in | Kapanış her zaman açılıştan kısa |
| Skor pop-up "+400" | 600 | out-back yukarı, sonra fade | Font mono; büyük değer = büyük başlangıç scale |
| Kombo artışı | 120 | out-back | Sayı 1,3× büyür, renk `signal`; perde tırmanır |
| Hit-stop (küçük vuruş) | 60 | — | `timeScale = 0` |
| Hit-stop (ölüm) | 120 + 300 ağır çekim 0,25× | — | Sonra kamera ölüme yaklaşır |
| Ekran sarsıntısı | trauma 0,4–1,0, sönüm 1,2/sn | shake = trauma² | Rotasyon ± 2°, ofset ± 0,5 birim |
| Squash-stretch | 90 | out-quad | Zıplama/iniş: x 1,15 / y 0,85 |
| Sayaç sayma (0 → 4.212) | 700 | out-expo | Büyük sayılar hızlı başlar yavaş biter |
| Günlük kart açılma | 400 | expo-out | Aşağıdan; ilk 100 ms ekran hafif kararır |
| Streak ateşi | sürekli, 1,1 sn döngü | sine | Sadece streak ≥ 3'te |
| Sayfa geçişi | 260 | expo-out | Ters yönde kapanma 180 ms |

Kural: **kullanıcı tetikledi → hızlı (≤ 200 ms); sistem tetikledi → biraz
yavaş (250–400 ms)**; hiçbir UI hareketi 500 ms'yi geçmez. Oyun içi
sinematik (ölüm, replay) istisna.

`prefers-reduced-motion` açıksa: sarsıntı ve hit-stop kalır (oyun hissi),
dekoratif döngüler ve paralaks kapanır.

## 3. Juice kontrol listesi (bir oyun bunların en az 8'i olmadan çıkmaz)

- [ ] Hit-stop (vuruş ve ölüm)
- [ ] Trauma tabanlı ekran sarsıntısı (lineer değil, kare)
- [ ] Squash-stretch (karakter/nesne)
- [ ] Skor pop-up dünya uzayında (UI köşesinde değil, olayın üstünde)
- [ ] Kombo sayacı büyüyüp küçülür, sesi tırmanır
- [ ] Parçacık/enkaz (10–30 adet, 400–800 ms, yerçekimli)
- [ ] Ölüm anında kamera yaklaşır ve ağır çekim
- [ ] Kayıp ekranı sayaçları sayarak gelir (sayı anında görünmez)
- [ ] Nadir ödülün ayrı rengi, ayrı sesi, ayrı ölçeği var
- [ ] Butonlar basınca tepki verir (80 ms)
- [ ] Yükleme yok: ilk kare aksiyon (splash yerine doğrudan sahne)
- [ ] Renk flaşı: ödül `signal`, tehdit `hazard`, hazır `ok`; flaş ≤ 90 ms

## 4. Kayıp/kazanç sekansı (peak-end için sıra)

```
t=0      vuruş: hit-stop 120 ms, flaş hazard 90 ms
t=120    ağır çekim 0,25×, kamera 300 ms'de yaklaşır, trauma 1,0
t=420    normal hız, ragdoll/parça 800 ms serbest
t=900    ekran %40 kararır (200 ms), "Seni bitiren: KREDİ KARTI" damgası
         out-back 260 ms, damga sesi
t=1300   skor sayacı sayar (700 ms), kombo/ streak satırları 80 ms arayla
t=2100   paylaşım kartı önizlemesi aşağıdan (400 ms) — ask burada
t=2500   "Tekrar" butonu belirir (kart 400 ms görünür kaldıktan sonra)
```

"Tekrar" butonu karttan **sonra** gelir: peak-end'in "son"u kart olsun,
buton değil. Toplam 2,5 sn; daha uzun sıkar, atlanabilir olmalı (dokunma).

## 5. 9:16 klip kompozisyonu

| Alan | Y aralığı (1080×1920) | İçerik |
|---|---|---|
| Üst tampon | 0–150 | Boş; TikTok kullanıcı adı burada |
| Kanca satırı | 150–330 | 1 satır, 72–84 px, beyaz + siyah kontur, ≤ 6 kelime |
| Aksiyon | 330–1120 | Oyunun kendisi; en önemli şey merkez-üst |
| Alt yazı / sayı | 1120–1470 | Skor, kombo, "seni bitiren" damgası |
| Alt tampon | 1470–1920 | Boş; TikTok butonları ve açıklama |

- **İlk kare** (0–1,5 sn): aksiyon zaten oluyor + kanca satırı ekranda.
  Logo, intro, "merhaba" yok.
- Her klip **tek fikir**; 8–15 sn; sonda 1 sn "linke tıkla, oyna" kartı.
- Oyun 9:16'da doğal çalışmalı (bkz. `viral-game-design` §6); klip, oyunun
  kırpılması değil, oyunun kendisidir.
- Sesi kapalı izlenir: her önemli olayın görsel karşılığı olmalı.

## 6. Paylaşım kartı (PNG) tasarımı

- Boyutlar: 1080×1920 (story) ve 1080×1080 (feed); ikisi de canvas'ta
  aynı çizim fonksiyonundan.
- Katmanlar: arka plan (marka rengi, gürültü dokusu) → büyük tek sayı
  (skor/ gün/ yüzde) → damga satırı ("Seni bitiren: …" / "Bugün 4/6") →
  spoilersız grid → alt şerit: oyun adı + kısa URL + tohum kodu.
- Tipografi: tek display font + mono sayılar (Sepetçi: Big Shoulders +
  IBM Plex Mono). Canvas'ta font yüklenmesini `document.fonts.ready` ile bekle.
- Kart oyunun paletiyle **aynı yerden** renk alır (tek `PALETTE` nesnesi).
- Kart, kayıp ekranında animasyonla önizlenir; `navigator.share({files})`
  yoksa indirme + "kopyalandı" fallback.

## 7. Replay (5 sn) sinematiği

- Kayıt: halka tampon, 20 Hz × 5 sn (Sepetçi `REPLAY_HZ`, `REPLAY_SECONDS`).
- Oynatım: kamera yörüngesi olayın etrafında 120° döner, son 1 sn 0,35×.
- Üstüne bindirme: skor, kombo, damga; klip formatında (bkz. §5) çizilir.
- Dışa aktarma: `canvas.captureStream(30)` + `MediaRecorder` (WebM);
  Safari için kart PNG fallback. Tarayıcı destek tablosunu kontrol et.

## 8. Uygulama kalıpları

**Trauma sarsıntısı (JS):**
```js
cam.trauma = Math.min(1, cam.trauma + amount);      // olayda
cam.trauma = Math.max(0, cam.trauma - 1.2 * dt);    // her karede
const s = cam.trauma * cam.trauma;
offset.set((rnd()-.5)*s, (rnd()-.5)*s, 0).multiplyScalar(0.5);
```

**Hit-stop (JS):**
```js
function hitStop(ms, scale = 0) { timeScale = scale; setTimeout(() => timeScale = 1, ms); }
// game loop: const dt = rawDt * timeScale;  // replay ve UI rawDt kullanır
```

**Skor pop-up (CSS):**
```css
.pop { animation: pop .6s cubic-bezier(.34,1.56,.64,1) forwards; font-family: "IBM Plex Mono", monospace; }
@keyframes pop { 0% { transform: translateY(0) scale(.6); opacity: 0 }
  20% { transform: translateY(-8px) scale(1.15); opacity: 1 }
  100% { transform: translateY(-40px) scale(1); opacity: 0 } }
```

**Sayaç sayma (JS):**
```js
function countTo(el, target, ms = 700) {
  const t0 = performance.now();
  (function f(t) { const k = Math.min(1, (t - t0) / ms), e = 1 - Math.pow(2, -10 * k);
    el.textContent = Math.round(target * e).toLocaleString("tr-TR");
    if (k < 1) requestAnimationFrame(f); })(t0);
}
```

**Easing seti (tek yerde tanımla):** `expoOut`, `backOut(1.7)`, `quadOut`,
`sine`. Başka easing ekleme; tutarlılık hissi buradan gelir.

## 9. Performans bütçesi (mobil tarayıcı)

- 60 FPS hedef, 30 FPS'in altına düşerse kalite kademesi düşer (Sepetçi
  `QualityDirector`): parçacık sayısı yarıya, gölge kapalı, DPR 1.
- DOM animasyonu yalnızca `transform` ve `opacity`; `top/left/width` yok.
- Canvas: tek `requestAnimationFrame`, sabit adım fizik (1/60), render
  interpolasyonlu.
- Font: en fazla 2 aile, `font-display: swap`; kart çiziminde `fonts.ready`.
- Sayfa ilk boyama < 1 sn (3G'de); toplam tek dosya ≤ 300 KB gz (2D),
  ≤ 1,5 MB (3D, modeller dahil).

## 10. Kabul testi (her oyun için, Playwright ile otomatikleştir)

1. 390×844 ve 1080×1920 viewport'ta ekran görüntüsü; aksiyon üst %58'de mi?
2. İlk kare ≤ 1,5 sn'de aksiyon + kanca satırı içeriyor mu?
3. Ölüm sekansı 2,5 sn'de kartı gösteriyor mu, dokunmayla atlanıyor mu?
4. Kart PNG'si üretiliyor ve oyun adı + URL içeriyor mu?
5. `prefers-reduced-motion` ile dekoratif döngüler duruyor mu?
6. Düşük cihaz emülasyonunda (CPU 4× yavaş) FPS ≥ 30 mu?
