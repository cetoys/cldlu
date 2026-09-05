# Viral tarayıcı oyunları — 7 fikir, puanlama, ilk 3

Tarih: 2026-09-05 · Yöntem: `.claude/skills/viral-game-design/SKILL.md` §5 rubriği
· Girdi: Sepetçi (ragdoll-gauntlet), Crownfault MARKETING.md, portfolio-marketing/04,
rate-me GAUNTLET protokolü.

---

## 0. Önce şüphe: "viral olma ihtimali yüksek" ne demek, ne demek değil

Kimse viral oyun tasarlayamaz; **paylaşılabilir** oyun tasarlanır, sonra hacimle
denenir. Senin kendi Crownfault dokümanın bunu zaten yazmış: TikTok organik
erişim 2026'da %4–8 bandında, 20 klipten sonra medyan izlenme 500'ün altındaysa
görsel kanca yetersizdir. O yüzden buradaki her fikir üç şeyle ölçüldü:

1. Oyun kendi **paylaşım artefaktını** üretiyor mu (oyuncu hiçbir şey yazmadan)?
2. **İlk 1,5 saniye** sessiz ve 9:16'da anlaşılıyor mu?
3. **Yarın neden döner?** (tohum / streak / kayıptan sonra kalan sayı)

Senin portföyünde sana özgü üç avantaj var, fikirler bunlara yaslanıyor:

- **Ses tonu:** Sepetçi'nin hicvi ("Seni bitiren: KREDİ KARTI") çalışan bir
  marka sesidir; Türkiye'de ekonomik hiciv birlik (unity) etkisi üretir.
- **Altyapı:** three.js + esbuild tek dosya boru hattı, 5 sn replay tamponu,
  Supabase anon lider tablosu + RLS, artifact self-publish. Sıfırdan değil.
- **Protokol:** rate-me gauntlet'i. Bu dosyanın devamı `GAUNTLET.md`.

Kısıtlar sabit: solo geliştirici, 0 $ reklam, tek dosya HTML, mobil tarayıcı
şart, realtime çok oyunculu yok.

---

## 1. Yedi fikir

### F1 · ZAM KÂHİNİ — günlük fiyat tahmini

**Tek satır:** "Bu ürün 2019'da kaç liraydı?" Günde 6 ürün, tahmin et, yüzde
sapmanı gör, spoilersız grid paylaş.
**Motor:** Wordle iskeleti × enflasyon öfkesi. Günlük tohum, 6 satırlık emoji
grid (🟩 ±%10, 🟨 ±%30, 🟥 daha kötü), "Türkiye'nin %71'i senden kötü tahmin
etti" sosyal kanıtı.
**Kanca karesi:** Büyük bir ürün fotoğrafı + "2019: ? TL" + kayan sayı.
**Kayıp/son:** "Cüzdan Yılı" kartı: "Sen 2021'de kaldın." (kimlik etiketi).
**Neden yarın:** Yeni 6 ürün; streak; aylık "enflasyon sezgin" reytingi.
**Kaynak riski:** Fiyat verisi elle kürasyon (TÜİK madde sepeti + market
arşivleri); ayda ~180 veri noktası. Politik ton: sayılar resmi kaynaktan,
yorum yok. Oyun yorum yapmaz, oyuncu yapar.

### F2 · OTOBÜS — ayakta tutunma simülatörü (3D ragdoll)

**Tek satır:** Kalabalık otobüste ayakta dur; şoför frene basınca uçma.
**Motor:** Öfke oyunu × fizik komedisi. Parmakla ağırlık merkezi kontrolü,
tutamak yakalama (dokun-bas), ani fren/ viraj/ çukur olayları günlük tohumlu
"hat" olarak gelir (34 numara, 500T…). Düşünce ragdoll, 5 sn replay otomatik
kaydedilir, kart: "Seni düşüren: ANİ FREN · 47 sn ayakta kaldın."
**Kanca karesi:** Karakter otobüste sallanıyor, arkada yolcu yüzleri.
**Neden yarın:** Günün hattı (herkes aynı olay dizisi), lider tablosu, "en
uzun tutunan" damgası; kayıptan sonra kalan: toplam ayakta saniye "kariyer"i.
**Altyapı:** Sepetçi'nin motoru, replay tamponu, ragdoll ve lider tablosu
doğrudan taşınır. En pahalı kalemi fizik ayarı ve mobil performans.

### F3 · LÜGAT — Türkçe anlamsal kelime avı

**Tek satır:** Gizli kelimeyi bul; her tahmin sana "anlamca kaçıncı sırada"
olduğunu söyler (Contexto/Semantle iskeleti).
**Motor:** Günlük tohum, tahmin sayısı paylaşımı ("LÜGAT #142 · 37 tahmin"),
sonsuz "bir tahmin daha". Türkçe için sağlam bir örneği yok; dil bariyeri
moat'tır.
**Kanca karesi:** Zayıf. Kelime oyunları klip üretmez, ekran görüntüsü
üretir. Bu dürüstçe puanda görünür.
**Neden yarın:** Streak, "ipucu" ekonomisi (günde 3), haftalık ortalama sıra.
**Teknik:** Günlük kelime için 20k kelimelik sıra listesi offline hesaplanır
(embedding modeli tek seferlik), günlük JSON ~80 KB; oyun tek dosya + günlük
veri. Supabase gerekmez, statik dosya yeter.

### F4 · KİM YALANCI — WhatsApp grubunda oynanan ihanet oyunu

**Tek satır:** Link at, 4–8 kişi aynı odada telefondan oynar, biri yalancı.
**Motor:** Sosyal ihanet konuşma üretir; davet mekanik olarak zorunlu (K>1
mümkün). Sıfır reklamla en yüksek doğal yayılım.
**Karşı gerçek:** Realtime (Supabase Realtime), oda yönetimi, sohbet
moderasyonu, soğuk başlangıç (tek başına oynanamaz). Solo geliştirici için
hazırlık süresi ve bakım maliyeti en yüksek fikir bu. Türkçe pazarda "Gartic
Phone" ve "Among Us" rekabeti doğrudan.

### F5 · TEK ÇİZGİ — 20 saniyelik beceri testi

**Tek satır:** Tek hamle, yüzde skor: mükemmel daire çiz / tam 10 saniyede
bırak / ipi dengede tut. Günde 3 test.
**Motor:** neal.fun iskeleti; giriş sürtünmesi sıfır, skor anında
karşılaştırılabilir, klip 10 sn'de biter.
**Karşı gerçek:** Derinlik yok; D7 retention düşük. Ürün değil, **trafik
kanalı**: diğer oyunların linkini taşıyan bir vitrin.

### F6 · BİR ÖMÜR — hiciv hayat simülasyonu

**Tek satır:** Türkiye'de doğ, seçim yap, "Öldün: 47 yaşında, kira yüzünden."
**Motor:** BitLife iskeleti × Sepetçi ses tonu. Son kart en güçlü paylaşım
artefaktı (kimlik + kahkaha). Her hayat 3–5 dk.
**Karşı gerçek:** İçerik ağır: en az 300 olay, 40 son, dallanma. Kalite metin
yazarlığına bağlı; LLM ile taslak, elle rötuş. Karanlık temalar (hastalık,
ölüm, borç) mağaza değil ama topluluk riski taşır; ton kaymasında oyun
"zalim" görünür.

### F7 · SEN OLSAN — ikilem + sosyal kanıt profili

**Tek satır:** Günde 5 ikilem, seç, "%73 aynısını seçti"; hafta sonunda
"karakter kartın".
**Motor:** Kimlik kartı × sosyal kanıt; üretim maliyeti en düşük.
**Karşı gerçek:** Format en çok klonlanan format; moat yok; 3. haftada sıkar.
Sosyal kanıt yüzdesi için gerçek veri gerekir (Supabase sayaç), ilk gün
sayı yok = ilk gün oyun yok (soğuk başlangıç).

---

## 2. Puanlama

Ağırlıklar: Kanca %20 · Paylaşım %20 · Duygu %15 · Geri dönüş %15 · Solo
üretim %15 · Pazar %10 · Risk(ters) %5. Puanlar 1–10. Kanıt yoksa 7'de kaldım;
10 sadece kanıtlanmış iskelet varsa.

| Fikir | Kanca | Paylaşım | Duygu | Geri dönüş | Solo | Pazar | Risk | **Toplam** |
|---|---|---|---|---|---|---|---|---|
| F1 Zam Kâhini | 8 | 9 | 9 | 8 | 8 | 6 | 5 | **8,00** |
| F2 Otobüs | 9 | 8 | 9 | 6 | 6 | 8 | 8 | **7,75** |
| F3 Lügat | 5 | 8 | 6 | 9 | 7 | 7 | 8 | **7,00** |
| F5 Tek Çizgi | 8 | 7 | 5 | 3 | 10 | 8 | 10 | **7,00** |
| F6 Bir Ömür | 6 | 9 | 8 | 7 | 5 | 6 | 6 | **6,90** |
| F7 Sen Olsan | 6 | 8 | 6 | 5 | 9 | 6 | 7 | **6,75** |
| F4 Kim Yalancı | 7 | 6 | 9 | 5 | 3 | 8 | 5 | **6,20** |

Hesap örneği (F1): 8·0,2 + 9·0,2 + 9·0,15 + 8·0,15 + 8·0,15 + 6·0,1 + 5·0,05 = 8,00.

**Puanların gerekçesi (itiraz edilebilecek yerler):**

- F1 Pazar 6, Risk 5: Enflasyon hicvi TR'de patlar ama ihracatı zayıf;
  "o zaman / şimdi fiyat" formatı ülke başına yeniden kürasyon ister. Politik
  ton riski gerçek; sayılar resmi kaynaktan olmalı, oyun yorum yapmamalı.
- F2 Geri dönüş 6, Solo 6: Beceri oyunlarının D7'si zayıftır; günlük hat
  tohumu ve kariyer sayacı bunu düzeltir ama kanıt yok. 3D + fizik + mobil
  performans solo için en pahalı kalem; altyapının hazır olması 4'ü 6 yapıyor.
- F3 Kanca 5: Kelime oyunu klip üretmez. Bunu kabul edip klip yerine
  ekran görüntüsü + "tahmin sayısı" paylaşımına yaslanır.
- F5 vs F3 eşitliği (7,00): F5 ürün değil kanal. Portföyde "yarın neden
  dönerim" cevabı olmayan üçüncü bir oyun istemiyorum; F5'i F1 ve F2'nin
  içine **mini test** olarak gömmek daha akıllı (ör. Otobüs'te "tutamağı tam
  zamanında yakala" 10 sn'lik meydan okuma). Bu yüzden üçüncü sıra F3.
- F4: Duygu 9 ama Solo 3. Realtime + moderasyon tek kişilik ekibi yer. İleride
  F1/F2 kitle kazandıysa "oda modu" olarak eklenir; ilk üçe girmez.

---

## 3. Seçilen üç oyun ve neden portföy olarak birbirini tamamlıyor

| Sıra | Oyun | Viral motoru | Rolü |
|---|---|---|---|
| 1 | **ZAM KÂHİNİ** | Günlük tohum + öfke + spoilersız grid | Trafik ve kimlik motoru; en hızlı çıkar (2 hafta) |
| 2 | **OTOBÜS** | Fizik komedisi + 5 sn replay + "seni düşüren" damgası | Klip motoru; TikTok/Reels/Shorts için tek görsel kanca |
| 3 | **LÜGAT** | Anlamsal yakınlık + streak | Retention motoru; en uzun ömür, en düşük bakım |

Üçü farklı duyguyu kullanır (öfke, kahkaha, merak), farklı kanalda çalışır
(grid paylaşımı, video, ekran görüntüsü) ve tek marka sesi altında birbirine
link verir (her kayıp ekranında "diğer ikisi" kartı; çapraz trafik bedava).

**Uyarı, dürüstçe:** Üçünü aynı anda yapmak solo için yanlış. Sıra: Zam
Kâhini → Otobüs → Lügat. `GAUNTLET.md` bu sırayla ve her turda tek oyun
üzerinde çalışır; bir oyun "yayınlanabilir" olmadan diğerine geçmez
(sıra kilidi §4'te).

---

## 4. Presuasion ve nöropazarlama uygulaması (üçü için ortak)

| An | İlke | Somut uygulama |
|---|---|---|
| Linke tıklamadan önce | Presuasion açıcı | Paylaşılan kartın ilk satırı **soru** ("2019'da ekmek kaç liraydı?"); logo değil. Soru dikkati kanalize eder, oyun cevabı satar. |
| İlk kare | Yüksek uyarılma | Aksiyon başlamış hâlde açılır; sayı akıyor/karakter sallanıyor. Splash yok. |
| İlk sonuç (≤ 20 sn) | Karşılıklılık | Oyun önce verir: kart bedava, tohum bedava, ipucu bedava. Paylaşım daha sonra istenir. |
| Kayıp anı | Peak-end | Hit-stop + damga ("Seni bitiren: …"). Zirve tasarlanır, sonu kart olur. |
| Kart ekranı | Sosyal kanıt + kimlik | "Bugün 4.212 kişi denedi, %71'i burada düştü" (gerçek sayı) + kimlik etiketi ("Kira Kurbanı"). |
| Paylaş butonu | Ask | En son gelir; kart görüldükten 400 ms sonra. Tek dokunuş, `navigator.share`. |
| Ertesi gün | Kıtlık + tutarlılık | "Dünkü tohum kapandı" (gerçek kıtlık) + streak sayacı ("3 gündür buradasın"). |
| Kayıptan sonra | Kayıp kaçınma | Streak/kombo kaybı ekranda yazar; kariyer sayacı hiç sıfırlanmaz (biriken sayı). |

Etik sınır: Kıtlık ve sosyal kanıt **gerçek** olmak zorunda. Sahte sayaç bir
kez yakalanırsa marka sesi (hiciv = dürüstlük) çöker.

---

## 5. Kanal planı (bütçe 0 $)

Portföy dokümanı `04-oyunlar-crownfault-ve-akin.md`'deki merdiven aynen
geçerli: itch.io → Reddit (r/WebGames, r/Turkey'e uygun ton) → kısa video
haftada 4–5 × 3 platform → Discord (ilk 20 oyuncu) → küçük yayıncılar.
Fark: bu üç oyunun **kendisi** klip ve kart üretir; montaj yok.

Durdurma kuralları (oyun başına): 20 klip sonra medyan izlenme < 500 →
kancayı yeniden tasarla; D1 < %20 → ücretli trafik açma; paylaşım oranı
< %5 → kartı yeniden tasarla, oyunu değil.
