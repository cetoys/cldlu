---
name: viral-game-design
description: Tarayıcı oyunları için paylaşılabilirlik odaklı oyun tasarımı. Fikir üretme, kanca (hook) tasarımı, çekirdek döngü, günlük tohum/streak, paylaşım artefaktı (emoji grid, son kart, 5 sn replay), nöropazarlama ve Cialdini presuasion uygulaması, klip-öncelikli 9:16 tasarım kısıtları, retention ölçümü. "Viral oyun", "oyun fikri", "kanca", "paylaşım mekaniği", "günlük oyun", "core loop", "GDD", "oyun puanlama" istendiğinde kullan.
---

# Viral Game Design

Bu skill "viral" kelimesine şüpheyle yaklaşır. Viral olma bir tasarım çıktısı
değil, bir **dağılım olasılığıdır**. Tasarlanabilen şey üç şeydir:

1. Oyunun kendi ürettiği **paylaşım artefaktı** (oyuncu hiçbir şey yazmadan
   paylaşabilecek bir nesne: emoji grid, son kart, 5 saniyelik replay).
2. İlk 1,5 saniyede **anlaşılan ve hissedilen kanca**.
3. **Geri dönüş sebebi** (günlük tohum, streak, kayıptan sonra ekranda kalan sayı).

Gerisi hacim ve ölçümdür. Tek viral an beklemek plan değildir (bkz. Crownfault
MARKETING.md §3: 2026'da oyun hesaplarında TikTok organik erişim %4–8 bandına
indi; haftada 5–7 klip × 3 platform, 20 klipten sonra medyan 500 izlenmenin
altındaysa üretimi durdur ve görsel kancaya geri dön).

## 1. Fikir üretme protokolü

Her fikir **tek satır** ile başlar ve o satır üç soruya aynı anda cevap verir:

| Soru | Test |
|---|---|
| Ne yapıyorum? | 5 kelimede fiil + nesne. "Otobüste ayakta dur." |
| Neden paylaşırım? | Paylaşım artefaktı ne? Ekranda somut bir nesne olmalı. |
| Neden yarın dönerim? | Günlük tohum mu, streak mi, kayıptan sonra kalan sayı mı? |

Üç cevaptan biri boşsa fikir henüz fikir değildir. Yedi fikir üret, hepsini
bu üç soruyla ele, sonra §5'teki rubriğe sok.

**Kanıtlanmış viral iskeletler** (kopyala, ama Türkiye bağlamına *tercüme et*,
çevirme):

| İskelet | Motor | Örnek | Türkiye tercümesi |
|---|---|---|---|
| Günlük tek bulmaca + spoilersız grid | Kıtlık + sosyal kanıt + spoilersız övünme | Wordle, Contexto, Connections | Enflasyon tahmini, kelime yakınlığı |
| Öfke oyunu (rage) | Yüksek uyarılma → paylaşım (Berger, STEPPS) | Flappy Bird, Getting Over It | Fizik komedisi, "seni bitiren: KREDİ KARTI" |
| Kimlik kartı | Kendini anlatma ("ben buyum") | BitLife son kartı, "hangi X'sin" | Hiciv hayat simülasyonu son kartı |
| Tek mekanik, 20 saniye, yüzde skoru | Düşük giriş, anında karşılaştırma | neal.fun "perfect circle" | Skor kartı + günlük tohum |
| Sosyal ihanet | Konuşma üretir | Among Us, Gartic Phone | Aile grubu WhatsApp'ta oynanır — ama realtime pahalı |
| Kombinatoryal keşif | "Ben bunu yaptım" ekran görüntüsü | Infinite Craft, Suika | Türkçe kelime/yemek birleştirme |

## 2. Çekirdek döngü kuralları

- **Tek karar, tek gerilim.** Sepetçi'nin kuralı örnek: "sepet önde, tehdit
  arkada; toplamak için dön, korunmak için dönme." Oyun bir cümlelik gerilime
  indirilemiyorsa klip de indirilemez.
- **İlk oturum ≤ 60 saniye, ilk anlamlı sonuç ≤ 20 saniye.** Tarayıcı
  oyununda öğretici yoktur; ilk tur öğreticidir.
- **Kayıp ekranı oyunun en önemli ekranıdır** (peak-end kuralı, Kahneman).
  Kayıp ekranında üç şey olmalı: (a) seni ne bitirdi (isimli, mizahlı),
  (b) paylaşım artefaktı hazır, (c) tek dokunuşla tekrar. Menüye dönüş yok.
- **Kayıptan sonra ekranda kalan sayı** (Crownfault "Hanedan Defteri" ilkesi):
  kaybeden oyuncu da bir şey biriktirmiş olmalı. Kilit görünür, ilerleme
  çubuğu taşır; gizli kilit motive etmez.
- **Kombo ve tırmanan ses**: Sepetçi'de kombo yükseldikçe pentatonik perde
  tırmanır. Ödülün sesi olmalı; sessiz ödül yoktur.

## 3. Paylaşım motoru (oyunun içine gömülü pazarlama)

Paylaşım artefaktı **oyuncu tarafından üretilmez, oyun tarafından üretilir**:

| Artefakt | Ne zaman | Teknik |
|---|---|---|
| Emoji grid / metin bloğu | Günlük oyunlar | `navigator.share` → clipboard fallback; spoiler yok, sayı var |
| Son kart (PNG, 9:16 ve 1:1) | Kayıp/bitiş ekranı | Canvas'ta çizilir, `canvas.toBlob` → `navigator.share({files})`; oyun adı + URL kartın içinde |
| 5 sn replay | Fizik/aksiyon oyunları | Halka tampon (Sepetçi `ReplayRecorder`: 20 Hz × 5 sn), sinematik kamera, `MediaRecorder` ile WebM |
| Tohum kodu | Her oyun | Ekranda görünür, URL'ye yazılır: `?s=2026-09-05` → arkadaşa aynı harita |
| Meydan okuma linki | Skor sonrası | "Beni geç" URL'si; alan giren kişi rakibin skorunu ekranda görür |

**Paylaşım anı = Cialdini'nin "ask" anıdır.** Ondan önce gelen ekran
(presuasion) paylaşımı hazırlar: ekranda sosyal kanıt ("bugün 4.212 kişi
denedi, %71'i burada öldü"), kimlik ("Sen bir *Kira Kurbanı*sın") ve kıtlık
("yarın yeni tohum") görünür olmalı. Buton en son gelir.

## 4. Nöropazarlama ve presuasion uygulaması

Kullanılacak ilkeler ve **oyundaki somut karşılığı** (soyut bırakma):

| İlke | Kaynak | Oyundaki yeri |
|---|---|---|
| Presuasion: "açıcı" dikkati ve çerçeveyi kurar | Cialdini, *Pre-Suasion* | Oyunun ilk karesi bir soru veya sayı olmalı ("2019'da ekmek kaç liraydı?"). Logo değil. |
| Birlik (unity) | Cialdini | Yerel mizah, "biz" dili: kira, zam, aidat. Oyuncu "bu benim hikâyem" der. |
| Sosyal kanıt | Cialdini | Bugünkü oyuncu sayısı, yüzdelik dilim, "arkadaşın X skor yaptı" |
| Kıtlık | Cialdini | Günde tek tohum; kaçırılan gün geri gelmez (streak kaybı = kayıp kaçınma) |
| Tutarlılık / bağlılık | Cialdini | Streak sayacı görünür; 3. günde "3 gündür buradasın" cümlesi |
| Karşılıklılık | Cialdini | Oyun önce verir: bedava kart, bedava tohum; paylaşım sonra istenir |
| Yüksek uyarılma paylaştırır | Berger, *Contagious* (STEPPS) | Öfke, hayret, kahkaha. Hüzün paylaştırmaz; "vay be" paylaştırır. |
| Peak-end | Kahneman | Zirve = ölüm anı (hit-stop + ragdoll), son = kart. İkisi de tasarlanır. |
| Zeigarnik / açık döngü | Zeigarnik | "Yarın: Bölüm 5" ya da kilitli görünür ferman |
| Değişken ödül | Skinner | Nadir ödül türü (Sepetçi'de KARİYER 600 puan, nadir); nadirliğin sesi ve rengi ayrı |
| Kayıp kaçınma | Kahneman–Tversky | Streak, kombo çarpanı; "x8 kombonu kaybettin" ekranda yazar |
| Çaba gerekçesi (IKEA etkisi) | Norton ve ark. | Oyuncunun kendi kurduğu şey (build, formasyon) kartta görünür |

**Uyarı:** Bu ilkeler manipülasyon aracı olarak kullanıldığında ürün nefret
toplar (loot box, sahte kıtlık). Kural: oyuncunun sonradan öğrenince "beni
kandırmışlar" diyeceği hiçbir şey yok. Kıtlık gerçek olmalı (tohum gerçekten
günde bir), sosyal kanıt gerçek sayı olmalı.

## 5. Puanlama rubriği (7 kriter, ağırlıklı)

| # | Kriter | Ağırlık | 10 puan ne demek |
|---|---|---|---|
| 1 | Kanca netliği (1,5 sn) | %20 | Sessiz, altyazısız, 9:16 kırpımda ne olduğu anlaşılır ve bir duygu tetikler |
| 2 | Paylaşım motoru | %20 | Oyun kendi artefaktını üretir; oyuncu tek dokunuşla paylaşır; artefakt oyun adı ve linki taşır |
| 3 | Duygusal yoğunluk | %15 | Yüksek uyarılmalı duygu (öfke, kahkaha, hayret, öfkeli hayret) |
| 4 | Geri dönüş döngüsü | %15 | Günlük tohum + streak + kayıptan sonra kalan sayı, üçü de var |
| 5 | Solo üretilebilirlik | %15 | Tek dosya HTML, realtime yok, moderasyon yok, ≤ 3 hafta çekirdek |
| 6 | Pazar tavanı | %10 | TR'de ve en az bir dilde daha çalışır; format klonlanmamış |
| 7 | Risk (ters) | %5 | Hukuki, politik, içerik ve mağaza riski düşük |

Hesap: Σ(puan × ağırlık). 7,5 üstü "yap"; 6,5–7,5 "kanal olarak dene";
altı "bırak". Puanlarken **kendi fikrini cezalandır**: her kritere "10 vermemin
nedeni ne?" sorusunu sor; kanıt yoksa 7'de kal.

## 6. Klip-öncelikli tasarım kısıtları (tasarım, montaj değil)

- Oyun **9:16 kırpımda** okunabilir olmalı: ana aksiyon ekranın üst %58'inde,
  alt kısım altyazı/UI için boş. Ölç, varsayma (Crownfault: 9×7 hex, 28 px).
- TikTok güvenli alanı 1080×1920'de X:40–940, Y:150–1470. Kritik metin
  dışarı taşarsa arayüz örter.
- İlk 1,5 saniyede kanca ekranda: oyun açılışta doğrudan aksiyona girer,
  splash yok.
- Her klip tek fikir. Klip formatları oyundan önce yazılır (bkz. Crownfault
  §3 tablosu): "en iyi anım", "yanlış yaptım", "bug", "yapımcı günlüğü",
  "günün tohumu".
- Ekran sarsıntısı, hit-stop, hasar sayıları: cansız kare dizisi izlenmez.
  Motion tarafı için `motion-graphics` skill'ine bak.

## 7. Ölçüm sözleşmesi (gün 1'de kurulur)

Olaylar: `game_loaded`, `game_started`, `first_result` (≤20 sn hedef),
`share_opened`, `share_completed`, `seed_link_opened`, `return_d1`, `return_d7`,
`streak_3`. Araç: Plausible/PostHog ücretsiz katman. Eşikler:

| Metrik | Eşik | Altındaysa |
|---|---|---|
| loaded → started | %70+ | Açılış ağır ya da kanca yok |
| started → first_result | %80+ | İlk tur çok uzun |
| share_completed / first_result | %5+ | Artefakt zayıf ya da ask anı erken |
| D1 return | %20+ | Geri dönüş sebebi yok; ücretli trafik açma |
| K faktörü (seed_link_opened / share_completed) | 0,3+ | Link kartın içinde değil |

## 8. Solo üretim kısıtları (varsayılan)

- Tek dosya `index.html`; bağımlılık yoksa daha iyi. 3D için Sepetçi
  `build.mjs` deseni (three + esbuild → tek IIFE).
- Mobil tarayıcıda çalışmayan oyun tanıtılmaz (portföy dokümanı §2, bir
  numaralı teknik ön koşul).
- Realtime çok oyunculu yok; **asenkron rekabet** var (tohum + skor tablosu).
- Lider tablosu: Supabase anon insert + RLS, güncelleme/silme politikası yok
  (Sepetçi şeması). Sahte skor tamamen engellenemez; kabul et, ya da edge
  function ile doğrula.
- Metinler TR + EN tablo olarak tek yerde; hiciv TR'de yazılır, EN'e uyarlanır.

## 9. Çıktı formatı — CONCEPT.md şablonu

```
# <Oyun adı>
Tek satır · Tür · Oturum süresi · Platform
## 1. Kanca (1,5 sn'de ekranda ne var)
## 2. Çekirdek döngü (girdi → karar → sonuç → sayı)
## 3. Kayıp ekranı (zirve + son)
## 4. Paylaşım artefaktı (ne, nasıl üretilir, içinde ne yazar)
## 5. Geri dönüş (tohum, streak, kalan sayı)
## 6. Presuasion tablosu (açıcı, sosyal kanıt, kimlik, kıtlık, ask)
## 7. Klip planı (6 format, kanca metinleri)
## 8. Teknik plan (dosya, boyut bütçesi, veri, ölçüm)
## 9. Kesinleşmiş kararlar K1..Kn
## 10. Bilinen riskler
## 11. Kabul kriterleri (ölçülebilir)
```
