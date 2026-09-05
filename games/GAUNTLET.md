# Viral Oyun Gauntlet — Üretim Loop Protokolü

Bu protokol `rate-me/GAUNTLET.md`'nin **üretim** sürümüdür. Fark: rate-me
loop'u konsepti döver, kod yazmaz; bu loop **hem döver hem inşa eder**. Her
tur bir oyunu bir aşama ilerletir, sonra bir jüri üyesi çıktıyı kırmaya
çalışır, hasar karara çevrilir, `STATE.md`'ye yazılır. Üç oyun sırayla
"yayınlanabilir" olunca ya da kapatılamayan bir P0 çıkınca durur.

## Çalıştırma

```
/loop games/GAUNTLET.md dosyasını oku ve orada tarif edilen tek bir gauntlet
turu çalıştır. Tur bitince dur — sıradaki turu bekle.
```

Aralık verme; model kendi hızını ayarlar. Protokolü turlar arasında
düzenleyebilirsin; her tur dosyayı yeniden okur.

**Her tur başında zorunlu okuma:**
`.claude/skills/viral-game-design/SKILL.md`,
`.claude/skills/motion-graphics/SKILL.md`, `games/STATE.md`,
`games/00-fikirler-ve-puanlama.md` ve aktif oyunun `CONCEPT.md`'si.

## Tur akışı

Her tur **tam olarak** şu yedi adımı yapar:

**1. Durumu yükle.** `STATE.md`'den aktif oyunu, aşamasını, tur numarasını,
açık bulguları ve yakınsama sayacını al. Yoksa "İlk tur" bölümüne bak.

**2. Önce bir bulgu kapat.** Açık P0/P1 varsa en yüksek şiddetliyi seç ve
**çöz**: koda ya da CONCEPT'e somut değişiklik, bulguyu `Çözülmüş`e taşı.
Açık P0 varken aşama ilerlemez (3. adım atlanır, doğrudan 4'e geçilir).

**3. İnşa et.** Aktif oyunun aktif aşamasındaki kontrol listesinden
**tamamlanmamış ilk 1–3 maddeyi** uygula. Kod `games/<oyun>/web/` altına
yazılır. Her madde için kanıt üret: Playwright ekran görüntüsü
(`games/<oyun>/qa/`), test çıktısı, dosya boyutu. Kanıtsız madde tamamlanmış
sayılmaz. Aşama listesi biterse ve tüm kabul kriterleri kanıtlıysa aşamayı
ilerlet.

**4. Jüriyi seç ve saldır.** `tur % 10` ile rotasyondan üyeyi al. Jüri **bu
turda üretilen çıktıya** (kod, ekran görüntüsü, kart, metin) bakar; yalnızca
konsepte değil. En fazla 3 bulgu. Az ve keskin.

**5. Kendini doğrula.** Her bulgu için: Gerçekten kırılır mı? Somut senaryo
yazabiliyor muyum (kim, ne yapıyor, ne bozuluyor)? Kesinleşmiş bir kararı
(CONCEPT §9) yeniden mi açıyorum, açıyorsam P0 var mı? Bir "hayır" varsa
bulguyu at.

**6. Ölç.** Aşama 2 ve sonrasında oyunun kabul testlerini (motion-graphics
§10) çalıştır; geçmeyen test otomatik P1 bulgudur.

**7. Yaz.** `STATE.md`: tur, aktif oyun/aşama, tamamlanan maddeler ve
kanıtları, kapatılan bulgu, yeni bulgular, yakınsama sayacı. CONCEPT
değiştiyse değişikliği ve gerekçesini yaz. Commit at: `gauntlet(<oyun>): tur
N — <aşama> — <özet>`.

## Aşamalar (her oyun için sırayla)

| Aşama | Ad | Bitmiş sayılır ki |
|---|---|---|
| 0 | Konsept kilidi | CONCEPT §1–§11 dolu, K kararları yazılı, paylaşım artefaktı ve geri dönüş sebebi somut, rubrik puanı yeniden hesaplanmış |
| 1 | Çekirdek döngü | `web/index.html` oynanabilir; girdi → sonuç → sayı; ilk sonuç ≤ 20 sn (Otobüs ≤ 30 sn); mobil viewport'ta çalışır |
| 2 | Juice ve motion | motion-graphics §3'ten ≥ 8 madde (Otobüs ≥ 10), kayıp/kazanç sekansı §4'e uygun, `prefers-reduced-motion` |
| 3 | Paylaşım motoru | Metin bloğu + PNG kart (+ Otobüs'te replay); `navigator.share` + fallback; kartta ad, link, tohum; presuasion sırası (kart → 400 ms → ask) |
| 4 | Geri dönüş ve veri | Günlük tohum, streak, kariyer sayacı, tohum linki; Supabase sayaç/tablo RLS ile (opsiyonel, kapalıyken oyun tam çalışır); ölçüm olayları |
| 5 | Klip paketi ve lansman kiti | 6 klip formatı için oyun içinden 9:16 kayıt; itch.io metni (AIDA), Reddit metni (dürüst tanım), og:image, 5 ekran görüntüsü, durdurma kuralları yazılı |
| 6 | Yayın hazır | Tüm kabul kriterleri kanıtlı, 2 ardışık turda P0/P1 yok |

**Sıra kilidi:** Aktif oyun 6. aşamaya ulaşmadan sonraki oyuna geçilmez.
Sıra: `01-zam-kahini → 02-otobus → 03-lugat`. Tek istisna: insan
`STATE.md`'de sırayı elle değiştirirse.

## Jüri rotasyonu

| # | Jüri | Neyi kırmaya çalışır |
|---|---|---|
| 0 | **19 yaşında TR oyuncu** | "Bunu neden açayım", ilk 10 sn sıkıcı mı, arkadaşıma nasıl anlatırım, 3. gün neden dönmem |
| 1 | **TikTok/Reels editörü** | İlk 1,5 sn, sessiz izlenebilirlik, 9:16 güvenli alan, klip başına tek fikir, kanca metni |
| 2 | **Mobil performans mühendisi** | FPS, ilk boyama, dosya boyutu, dokunma gecikmesi, düşük cihaz, pil |
| 3 | **Nöropazarlama / Cialdini uzmanı** | Presuasion açıcı, ask anının yeri, sosyal kanıtın gerçekliği, peak-end sekansı, kıtlığın sahte olup olmadığı |
| 4 | **Büyüme mühendisi** | Paylaşım oranı, K faktörü, tohum linki, soğuk başlangıç, ölçüm olayları, durdurma kuralları |
| 5 | **Red team** | Sahte skor, XSS (isim alanı), veri manipülasyonu, RLS delikleri, spam paylaşım |
| 6 | **Hukuk / içerik editörü** | Veri kaynağı ve lisans, politik okunma, hassas kelime, marka/telif, KVKK (isim, sayaç) |
| 7 | **Rakip** | Wordle/Contexto/BitLife/Sepetçi kopyalarsa ne olur; moat gerçek mi; fark bir cümlede anlatılıyor mu |
| 8 | **Motion/juice yönetmeni** | Zamanlama tablosu, hit-stop, sekans süreleri, tek orkestre an, cansız kare var mı |
| 9 | **Solo-dev CFO (zaman)** | Kalan iş × saat, kürasyon yükü (aylık veri), bakım maliyeti, "bu aşama 2 haftayı geçerse kes" |

10 tur = bir tam geçiş. İkinci geçişte aynı jüri **yeni** açıdan saldırır.

## Bulgu formatı

```markdown
### B-007 · P1 · TikTok editörü · Tur 4 · 01-zam-kahini
**İddia:** İlk kare ürün görselini değil menüyü gösteriyor.
**Senaryo:** Klip 0–1,5 sn'de "Başla" butonu görünüyor; izleyici kaydırıyor.
**Etki:** Kanca yok; klip formatı 1–6 çalışmaz.
**Önerilen düzeltme:** Menüyü kaldır; sayfa doğrudan 1. ürünle açılsın,
kaydırıcı ilk dokunuşta aktif olsun.
**Kanıt gereksinimi:** Playwright 390×844 ilk kare ekran görüntüsü.
**Durum:** açık
```

**Şiddet:** P0 yasal/mağaza/güvenlik batırır · P1 ana vaat kırık ya da kabul
kriteri geçmiyor · P2 pahalıya patlar ama yayını engellemez · P3 iyileştirme
(ayrı liste, tur harcamaz).

## Kurallar

1. **Kesinleşmiş kararlara dokunma.** Her CONCEPT'in §9 K kararları
   kapalıdır; yalnızca senaryolu P0 açabilir, o tur orada biter ve insan
   onayı bekler.
2. **Her bulgu düzeltme önerisi ve kanıt gereksinimiyle gelir.**
3. **Kanıtsız ilerleme yok.** Ekran görüntüsü, test çıktısı ya da ölçüm yoksa
   madde tamamlanmadı.
4. **Turu genişletme.** Tek oyun, tek aşama, 1–3 madde, tek jüri, ≤ 3 bulgu,
   bir kapatma.
5. **Sahte sosyal kanıt yasak.** Sayı yoksa gösterilmez; kod sahte sayaç
   içeriyorsa otomatik P0.
6. **Tekrarı bulgu sayma.**
7. **Tek dosya kuralı.** Oyun `web/index.html` (3D için `build.mjs` çıktısı)
   olarak çalışır; CDN bağımlılığı yalnızca artifact izin listesinden.
8. **Skill'ler kaynak.** Bir karar skill'deki tabloyla çelişiyorsa ya skill
   güncellenir (gerekçeyle) ya da karar; sessiz sapma yok.
9. **Marka sesi.** Hiciv damgalarda ve kartta; oyun ekonomi/politika yorumu
   yapmaz (Zam Kâhini K2).

## Yakınsama ve durma

- Bir oyunda tur **hiç yeni P0/P1 üretmez ve aşama 6'daysa** sayaç +1;
  P0/P1 çıkarsa 0. Sayaç 2 → oyun **yayınlanabilir**, `games/<oyun>/RAPOR.md`
  yazılır (hayatta kalan konsept, değişen kararlar, kalan riskler, P3 listesi,
  lansman kontrol listesi) ve sıra sonraki oyuna geçer.
- Üç oyun da yayınlanabilir → loop biter, `games/GAUNTLET-RAPOR.md` yazılır.
- **Kapatılamayan P0** → sayaç ne olursa olsun dur; insan kararı.
- **Zaman kesme:** Solo-dev CFO turunda bir aşama tahmini 2 haftayı aştıysa
  bulgu P1 olarak "kapsam kes" önerisiyle gelir; kesilen kapsam P3'e düşer.

## İlk tur

`STATE.md` mevcut ve tur 0'da. Aktif oyun `01-zam-kahini`, aşama 0. Kapatılacak
bulgu yok; 3. adımda Aşama 0 kontrolü (CONCEPT tamlığı, rubrik yeniden hesabı)
yapılır, 4. adımda jüri #0 saldırır.
