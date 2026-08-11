# MASTER PROMPT PRO AI – INTERAKTIVNÍ TVORBA PRD
## A.N.T. + VIBE CODING + ACCEPTANCE CRITERIA + TESTOVÁNÍ

---

# PŘED-PŘÍPRAVA PRO ZAKLADATEL/KA
## Vyplň před spuštěním

- **Moje role / zkušenosti:**  
  [např. Nemám technické zkušenosti / Jsem vývojář / Vibe coder s Cursor / Claude Code / Codex]

- **Preferovaný tech-stack:**  
  [např. Python + Streamlit / Next.js + Supabase / Cloudflare Workers / Nevím, nechám si poradit]

- **Preferovaný nástroj pro vývoj:**  
  [např. Lovable / Google AI Studio / Cursor / Claude Code / Codex / Antigravity / Nevím]

- **Pracovní jazyk projektu:**  
  [např. Čeština / Angličtina]

- **Cílová skupina:**  
  [např. Učitelé / Malé firmy / Interní nástroj pro mě]

- **Cílové prostředí:**  
  [např. web / mobil / desktop / interní aplikace / API / nevím]

- **Předpokládané nasazení:**  
  [např. Cloudflare / Vercel / Coolify / vlastní VPS / nevím]

- **Citlivost dat:**  
  [žádná citlivá data / osobní údaje / firemní data / platební data / nevím]

- **Rozpočtové omezení:**  
  [např. ideálně zdarma / do 500 Kč měsíčně / nezáleží / nevím]

---

# INSTRUKCE PRO AI

Chci s tebou metodou vibe codingu připravit podklady pro tvorbu nového projektu založeného na **A.N.T. Třívrstvé architektuře spolehlivosti**:

- **A – Architektura:** Co má systém dělat a podle jakých pravidel.
- **N – Navigace:** Jak AI rozhoduje, plánuje a vybírá další krok.
- **T – Nástroje:** Deterministické funkce, skripty, API a další prostředky, které skutečně vykonávají práci.

Tvým úkolem je pomoci mi nejprve projekt **promyslet a specifikovat**, nikoli okamžitě generovat kód.

## ZÁKLADNÍ PRAVIDLA KONVERZACE

1. Pokládej mi otázky striktně **JEDNU PO DRUHÉ**.
2. Vždy počkej na mou odpověď.
3. Pokud odpovím **„Nevím“**, **„Navrhni“** nebo odpovím neúplně, nabídni mi **3 konkrétní a realistické možnosti**.
4. Varianty přizpůsob mým technickým zkušenostem, rozpočtu a zvolenému stacku.
5. Preferuj **jednodušší, standardní a dlouhodobě udržitelné řešení** před zbytečně složitou architekturou.
6. Kritické informace si nikdy potichu nedomýšlej. Pokud něco nevíme, označ to jako **TBD – nutno rozhodnout**.
7. Rozlišuj:
   - **Fakt / potvrzený požadavek**
   - **Předpoklad**
   - **Doporučení AI**
8. Nevytvářej funkce jen proto, že „by mohly být užitečné“. Každá funkce musí mít vazbu na cíl projektu.
9. Mysli i na chybové a okrajové scénáře, ne pouze na ideální **happy path**.
10. Než doporučíš technologii nebo externí službu, zvaž:
    - složitost,
    - cenu,
    - vendor lock-in,
    - bezpečnost,
    - dlouhodobou udržitelnost.
11. **Nezačínej implementaci**, dokud není splněna Definition of Ready uvedená níže.

---

# PROJDEME SPOLU TĚCHTO 12 BODŮ

## 1. Základní obrysy projektu
### Název a popis

Ptej se:

> „Jak se bude projekt jmenovat a jak bys ho jednou až dvěma větami popsal?  
> Jde o nástroj, web, aplikaci, automatizaci, hru, AI agenta nebo něco jiného?“

Z odpovědi vytvoř stručnou definici projektu.

---

## 2. Jádro pudla
### North Star / Core Value

Ptej se:

> „Jakou jednu hlavní hodnotu má projekt uživateli přinést?  
> Co je ten moment, kdy si uživatel řekne: ‚Tohle mi opravdu pomohlo‘?“

Výsledkem musí být **jedna hlavní věta**, podle které budeme později posuzovat všechny funkce.

---

## 3. Uživatel a první minuta
### User Flow

Ptej se:

> „Představ si, že uživatel aplikaci právě poprvé otevřel.  
> Co přesně vidí a jaký je jeho první krok? Co následuje potom?“

Společně definuj:

- hlavního uživatele,
- vstupní obrazovku,
- první akci,
- hlavní uživatelskou cestu,
- očekávaný výsledek.

Vytvoř jednoduchý hlavní tok:

`VSTUP → AKCE → ZPRACOVÁNÍ → VÝSLEDEK`

---

## 4. MVP Scope
### Ořezání projektu na dřeň

Ptej se:

> „Jaká je absolutně nejmenší verze produktu, která už přinese uživateli hlavní hodnotu?  
> Co musí být ve verzi 1 a co vědomě odložíme?“

Rozděl funkce na:

### MUST HAVE
Bez těchto funkcí MVP nedává smysl.

### SHOULD HAVE
Užitečné, ale není nutné pro první verzi.

### WON'T HAVE NOW
Vědomě odložené do další fáze.

Pokud navrhované MVP obsahuje příliš mnoho funkcí, upozorni mě a navrhni jednodušší variantu.

---

## 5. Acceptance Criteria
### Jak objektivně poznáme, že funkce funguje?

Pro každou **MUST HAVE** funkci vytvoř konkrétní, měřitelné a testovatelné Acceptance Criteria.

Nepoužívej vágní formulace jako:

- „funguje správně“
- „je intuitivní“
- „je rychlé“

Místo toho vytvářej ověřitelné podmínky.

Příklad:

**Funkce: Přihlášení uživatele**

- AC-01: Uživatel může zadat platný e-mail a úspěšně se přihlásit.
- AC-02: Neplatný e-mail zobrazí srozumitelnou chybovou zprávu.
- AC-03: Nepřihlášený uživatel nemůže otevřít chráněnou stránku.
- AC-04: Po odhlášení není možné dál přistupovat k chráněným datům.

Pokud je vhodné, používej také strukturu:

**GIVEN** – výchozí stav  
**WHEN** – uživatel provede akci  
**THEN** – očekávaný výsledek

Acceptance Criteria budou později sloužit jako základ testů.

---

## 6. UI / UX Vibe + nefunkční požadavky

Ptej se:

> „Jak má aplikace působit vizuálně a jaká zařízení budou uživatelé používat?“

Definuj:

- vizuální styl,
- barevnost,
- typografii,
- dark/light mode,
- desktop / mobil,
- responzivitu,
- základní přístupnost,
- jednoduchost ovládání.

Současně navrhni **Non-Functional Requirements**, pokud jsou pro projekt relevantní:

- výkon,
- rychlost načtení,
- dostupnost,
- responzivita,
- přístupnost,
- kompatibilita prohlížečů,
- maximální velikost souborů,
- limity API,
- očekávaný počet uživatelů.

Nevymýšlej extrémní enterprise požadavky pro jednoduchý projekt.

---

## 7. A.N.T. Architektura
### Třívrstvý systém

Ptej se:

> „Jak rozdělíme projekt do vrstev Architektura – Navigace – Nástroje?“

### A – ARCHITEKTURA
Definuj:

- cíle,
- SOPs,
- projektová pravidla,
- vstupy a výstupy,
- datové struktury,
- hranice projektu,
- okrajové případy,
- pravidla chování.

Instrukce ukládej do vhodných Markdown souborů projektu.

Podle použitého nástroje doporuč správný systémový soubor, například:

- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- jiný podporovaný projektový kontext.

---

### N – NAVIGACE

Definuj:

- co rozhoduje AI,
- co musí rozhodnout člověk,
- kdy se volá konkrétní nástroj,
- co se děje při chybě,
- kdy se má AI zastavit a požádat uživatele o rozhodnutí.

AI nesmí provádět nevratné nebo rizikové operace jen na základě domněnky.

---

### T – NÁSTROJE

Definuj:

- deterministické skripty,
- funkce,
- API,
- databázové operace,
- validační nástroje,
- import/export,
- automatizované testy.

Pokud lze úlohu spolehlivě řešit obyčejnou deterministickou funkcí, preferuj ji před dalším LLM voláním.

---

## 8. Data, integrace a Zdroj pravdy
### The Ecosystem

Ptej se:

> „Jaká data aplikace potřebuje, kde budou uložená a s jakými službami musí komunikovat?“

Definuj:

- hlavní entity,
- základní datový model,
- databázi,
- persistentní vs. dočasná data,
- externí API,
- platby,
- e-mail,
- AI modely,
- soubory,
- import/export.

Explicitně definuj **Source of Truth**:

> Kde se nachází autoritativní verze jednotlivých dat?

Například:

- PostgreSQL = uživatelská data,
- Stripe = platby,
- GitHub = zdrojový kód,
- PRD.md = produktová specifikace.

---

## 9. Bezpečnost a Guardrails

Ptej se:

> „Jaká nejhorší věc by se mohla stát, kdyby uživatel nebo AI udělali něco špatně?“

Zvaž:

- autentizaci,
- autorizaci,
- role,
- citlivá data,
- rate limiting,
- API limity,
- ochranu proti zneužití,
- validaci vstupů,
- oprávnění k mazání a změnám dat.

### Secrets

Dodržuj pravidla:

- hesla a API klíče nikdy nepatří do zdrojového kódu,
- `.env` nesmí být commitnut do Git repozitáře,
- vytvoř `.env.example` bez skutečných hodnot,
- produkční secrets ukládej jako Environment Variables / Secrets hostingu,
- žádný secret neposílej do klientského frontendového kódu, pokud tam nepatří.

Navrhni `.gitignore`.

---

## 10. Testování a kontrola kvality

Ptej se:

> „Co musí fungovat tak spolehlivě, že to potřebujeme automaticky testovat?“

Navrhni přiměřenou kombinaci:

### Unit tests
Testují jednotlivé funkce a logiku.

### Integration tests
Testují propojení komponent, databází a API.

### E2E tests
Testují skutečné uživatelské scénáře od začátku do konce.

### Smoke tests
Rychlá kontrola po nasazení, zda aplikace vůbec funguje.

Pro jednoduchý projekt nepřidávej obrovskou testovací infrastrukturu bez důvodu.

Testy prioritizuj podle rizika.

Každá kritická chyba opravená v budoucnu má pokud možno dostat **regresní test**, aby bylo možné ověřit, že se problém nevrátil.

---

## 11. Deployment, Observability, Rollback a Self-Annealing

Ptej se:

> „Kde aplikace poběží, jak poznáme, že funguje, a co uděláme, když nové nasazení něco rozbije?“

Definuj:

### Deployment
- hosting,
- doménu,
- build,
- produkční proměnné,
- databázové migrace.

### Logging
Aplikace musí poskytovat dostatek informací pro diagnostiku chyb.

Logy mají podle potřeby obsahovat:

- typ události,
- čas,
- error message,
- request / trace ID,
- kontext chyby.

Citlivé údaje se nesmí zbytečně zapisovat do logů.

### Monitoring
Pokud je relevantní, definuj:

- dostupnost,
- chybovost,
- výkon,
- využití API,
- náklady.

### Rollback

Musí být jasné:

> „Jak se vrátíme k poslední funkční verzi, pokud deployment selže?“

Preferuj malé změny a časté commity.

---

# SELF-ANNEALING LOOP

Pokud během vývoje nebo provozu vznikne chyba:

### 1. OBSERVE
Získej skutečné informace:

- chybovou hlášku,
- console,
- logy,
- stack trace,
- vstupy,
- kroky vedoucí k chybě.

### 2. ANALYZE
Urči nejpravděpodobnější root cause.

Pokud není příčina jistá, jasně řekni, že jde o hypotézu.

### 3. PATCH
Proveď nejmenší možnou opravu.

Neprováděj zbytečný rozsáhlý refactoring kvůli lokální chybě.

### 4. TEST
Spusť relevantní testy.

### 5. REGRESSION TEST
Pokud je to možné, přidej test reprodukující původní chybu.

### 6. DOCUMENT
Pokud chyba odhalila obecné pravidlo nebo architektonický problém, aktualizuj projektovou dokumentaci nebo instrukční Markdown.

Cílem není tvrdit, že se chyba „už nikdy nemůže stát“, ale **systematicky snižovat pravděpodobnost jejího opakování**.

---

## 12. Křížová validace
### The Multi-Perspective Review

Po dokončení návrhu zhodnoť projekt minimálně ze čtyř perspektiv.

### VÝVOJÁŘ

- Je architektura implementovatelná?
- Není zbytečně složitá?
- Jsou jasné datové modely?
- Jsou řešené chybové stavy?
- Lze projekt dlouhodobě udržovat?

### UŽIVATEL

- Je jasné, co má udělat?
- Je hlavní workflow jednoduché?
- Jsou chyby srozumitelně komunikované?
- Dostane skutečně slíbenou hodnotu?

### MANAŽER / PODNIKATEL / PRODUCT OWNER

- Je MVP realistické?
- Neobsahuje zbytečné funkce?
- Jsou náklady přijatelné?
- Je možné projekt rychle ověřit s uživateli?

### SECURITY / OPERATIONS

- Nejsou secrets v kódu?
- Jsou správně nastavená oprávnění?
- Jsou citlivá data chráněna?
- Víme, jak diagnostikovat chybu?
- Víme, jak provést rollback?

Výsledkem bude seznam:

- kritických problémů,
- doporučených úprav,
- otevřených rozhodnutí,
- rizik před implementací.

---

# DEFINITION OF READY
## Kdy smí AI začít stavět

Projekt je připraven k implementaci pouze pokud:

- [ ] Je jasně definovaný North Star cíl.
- [ ] Je definovaný hlavní uživatel.
- [ ] Je znám hlavní User Flow.
- [ ] Je definované MVP.
- [ ] Must-have funkce mají Acceptance Criteria.
- [ ] Jsou definována hlavní data a Source of Truth.
- [ ] Je zvolen základní tech stack.
- [ ] Jsou známé externí integrace.
- [ ] Jsou identifikována hlavní bezpečnostní rizika.
- [ ] Je rozhodnuto, kam se aplikace nasadí.
- [ ] Kritické nejasnosti nejsou skryté – jsou označené jako TBD.

Pokud tyto podmínky nejsou splněné, nejprve pokračuj v návrhu a ptej se na chybějící informace.

---

# DEFINITION OF DONE
## Kdy můžeme funkci nebo MVP označit za hotové

Funkce / MVP je hotové pouze tehdy, pokud:

- [ ] Všechna relevantní Acceptance Criteria jsou splněná.
- [ ] Hlavní uživatelský scénář funguje od začátku do konce.
- [ ] Kritické chybové scénáře jsou ošetřené.
- [ ] Automatické testy jsou zelené.
- [ ] Build probíhá bez chyby.
- [ ] V konzoli nejsou nevysvětlené kritické chyby.
- [ ] Kód je uložený a verzovaný v Git.
- [ ] Změny mají smysluplný commit.
- [ ] Secrets nejsou součástí repozitáře.
- [ ] `.env.example` odpovídá potřebné konfiguraci.
- [ ] Dokumentace odpovídá skutečné implementaci.
- [ ] Nové nebo změněné API/datové struktury jsou zdokumentované.
- [ ] Aplikace byla otestována v cílovém prostředí.
- [ ] Smoke test po deploymentu prošel.
- [ ] U kritických funkcí je znám způsob rollbacku.
- [ ] Funkci / MVP lze podle Acceptance Criteria objektivně předvést a přijmout.

**„AI říká, že je hotovo“ není Definition of Done.**

Hotovo znamená, že výsledek byl **ověřen**.

---

# PRAVIDLA PRO IMPLEMENTACI

Až bude PRD schváleno:

1. Rozděl implementaci do malých logických kroků.
2. Nevytvářej celý projekt jedním gigantickým promptem.
3. Po každé významné změně:
   - spusť relevantní testy,
   - zkontroluj chyby,
   - proveď commit.
4. Před změnou fungující architektury vysvětli důvod.
5. Neodstraňuj funkční části projektu jen kvůli jednoduššímu řešení jiné chyby.
6. Při nejasnosti se nejprve zeptej.
7. Nedeklaruj úkol jako hotový bez ověření Acceptance Criteria.
8. Po dokončení každé větší funkce stručně vypiš:
   - co bylo vytvořeno,
   - co bylo otestováno,
   - které AC jsou splněné,
   - co případně zůstává otevřené.

---

# VÝSTUPNÍ INSTRUKCE PRO MODEL

Jakmile projdeme všech 12 částí a provedeme křížovou validaci, vytvoř kompletní `PRD.md`.

PRD musí obsahovat:

## 1. Přehled projektu
- název,
- stručný popis,
- kontext zakladatele,
- cílovou skupinu.

## 2. North Star
- hlavní problém,
- hlavní hodnota,
- očekávaný „Aha moment“.

## 3. User Flow
- hlavní uživatelskou cestu,
- happy path,
- důležité edge cases.

## 4. MVP Scope
- Must Have,
- Should Have,
- Won't Have Now.

## 5. Acceptance Criteria
Pro každou Must-Have funkci vytvoř očíslovaná kritéria:

- AC-01
- AC-02
- AC-03
- ...

Každé kritérium musí být jednoznačně testovatelné.

## 6. UI / UX
- styl,
- rozložení,
- responzivita,
- zařízení,
- základní UX pravidla.

## 7. Non-Functional Requirements
Pouze relevantní požadavky:
- výkon,
- přístupnost,
- škálování,
- kompatibilita,
- limity.

## 8. A.N.T. Architektura

### A – Architektura
- SOPs,
- pravidla,
- datové struktury,
- vstupy/výstupy,
- edge cases.

### N – Navigace
- rozhodovací logika,
- odpovědnost AI,
- odpovědnost člověka,
- error handling.

### T – Nástroje
- skripty,
- funkce,
- API,
- automatizace,
- testy.

## 9. Data & Integrace
- datový model,
- databáze,
- externí služby,
- Source of Truth.

## 10. Security & Guardrails
- autentizace,
- autorizace,
- secrets,
- rate limiting,
- ochrana dat,
- validace vstupů.

## 11. Testovací strategie
- unit,
- integration,
- E2E,
- smoke tests,
- mapování testů na Acceptance Criteria.

## 12. Deployment & Operations
- hosting,
- environment variables,
- logging,
- monitoring,
- rollback.

## 13. Self-Annealing Loop
- Observe,
- Analyze,
- Patch,
- Test,
- Regression Test,
- Document.

## 14. Definition of Ready
Checklist podmínek před implementací.

## 15. Definition of Done
Checklist podmínek před označením projektu za hotový.

## 16. Rizika, předpoklady a TBD
Samostatně vypiš:

### Rizika
Co se může pokazit?

### Předpoklady
Co zatím předpokládáme, ale není to potvrzeno?

### TBD
Co musí člověk ještě rozhodnout?

## 17. Závěrečná křížová validace
Projekt zhodnoť z pohledu:

- vývojáře,
- uživatele,
- product ownera / podnikatele,
- bezpečnosti a provozu.

Na úplný konec napiš:

### READY TO BUILD
- **ANO**, pokud je Definition of Ready splněná.

nebo

- **NE**, a explicitně vypiš, co ještě chybí.

---

# ZAČÁTEK INTERAKCE

Teď ještě nic neimplementuj.

Polož mi pouze **první otázku z bodu 1 – Základní obrysy projektu** a počkej na moji odpověď.
