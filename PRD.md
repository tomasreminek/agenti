================================================================================
**ČÁST 1: MASTER PROMPT PRO AI – INTERAKTIVNÍ TVORBA PRD (A.N.T. + VIBE CODING)**
================================================================================

---
**PŘED-PŘÍPRAVA PRO ZAKLADATEL/KA (VYPLŇ PŘED SPUŠTĚNÍM):**
- **Moje role / Zkušenosti:** [např. Nejsou technické / Jsem vývojář / Vibe coder s Cursor/Windsurf]
- **Preferovaný tech-stack (pokud máš preferenci):** [např. Python + Streamlit / Next.js + Supabase / Cloudflare Workers / Nevím, nechám si poradit]
- **Pracovní jazyk projektu:** [např. Čeština / Angličtina]
- **Cílová skupina:** [např. Učitelé / Malé firmy / Interní nástroj pro mě]
---

**INSTRUKCE PRO AI:**
Chci s tebou metodou vibe codingu připravit podklady pro tvorbu nového projektu založeného na **A.N.T. Třívrstvé architektuře spolehlivosti** (Architektura – Navigace – Nástroje).

Vezmi v úvahu výše uvedený **Kontext zakladatele** a tvým úkolem je pokládat mi upřesňující otázky striktně **JEDNU PO DRUHÉ**. Vždy počkej na mou odpověď, než položíš další otázku.

**DŮLEŽITÉ PRAVIDLO:** Pokud u jakékoliv otázky odpovím "Nevím", "Navrhni" nebo odpovím neúplně, okamžitě mi navrhni 3 konkrétní, logické a technicky snadno realizovatelné varianty (přizpůsobené mému tech-stacku a zkušenostem), ze kterých si mohu vybrat.

Projdeme spolu těchto 10 bodů (ptej se na ně přesně v tomto pořadí):

**1. Základní obrysy (Název a Popis)**
"Jak se bude projekt jmenovat a jak bys ho jednou až dvěma větami popsal? Jde o nástroj, web, hru, nebo něco úplně jiného?"

**2. Jádro pudla (North Star / Core Value)**
"Co je jediným hlavním cílem (North Star) tohoto projektu? Co je ten 'Aha moment', kdy uživatel pochopí jeho hodnotu (např. ušetří mu to čas, skvěle se pobaví, nebo se něco naučí)?"

**3. První minuta (User Flow)**
"Když uživatel projekt poprvé otevře, co přesně uvidí na obrazovce a jaký by měl být jeho první logický krok?"

**4. MVP Scope (Ořezání na dřeň)**
"Co je ta nejjednodušší možná funkční verze (Minimum Viable Product), která ti bude stačit pro první spuštění? Které funkce naopak záměrně odložíme na později, abychom se nezasekli hned na začátku?"

**5. UI/UX Vibe (Vizuální styl)**
"Jak má výsledek působit vizuálně? Chceš super-čistý 'Notion' styl, temný herní design (Dark Mode), nebo třeba hravé a barevné rozhraní?"

**6. A.N.T. Architektura (Třívrstvý systém)**
"Jak propojíme A.N.T. architekturu spolehlivosti?
 - **Architektura (Co dělat):** Jaké textové SOPs / instrukce v Markdownu budeme potřebovat?
 - **Navigace (Rozhodování):** Který AI orchestrátor bude řídit tok a logiku rozhodování?
 - **Nástroje (Výkon):** Které deterministické skripty / funkce bude orchestrátor spouštět?"

**7. Data, integrace a ekosystém (The Ecosystem)**
"Bude aplikace žít ve vakuu, nebo mluví s okolním světem? Potřebujeme trvalou databázi (např. Cloudflare D1/SQLite/PostgreSQL) a přihlašování (např. bezheslový Magic Link přes Resend), nebo stačí lokální chod v prohlížeči? Potřebujeme externí API (OpenAI, Anthropic, Stripe na platby)?"

**8. Bezpečnost a guardrails proti zneužití (Rate Limiting)**
"Jak zajistíme, aby nám uživatelé nevyplýtvali drahé tokeny nebo kredity? Potřebujeme hlídat limity (Rate Limiting) nebo omezit přístup jen na konkrétní e-mailové domény, abychom zabránili zneužití systému neautorizovanými uživateli?"

**9. Doručení, pravidla a Samoopravná smyčka (Deployment & Self-Annealing)**
"Kde to poběží (nástěnka, Cloudflare, Coolify, Vercel)? A souhlasíš se zařazením pravidla, že při technické chybě v budoucnu musí AI nejprve analyzovat stack trace, opravit skript, otestovat ho a zapsat ponaučení do 'ústavy' projektu, aby se chyba již neopakovala?"

**10. Křížová validace (The 3 Perspectives Review)**
"Až probereme předchozí body, podíváme se na aplikaci ze tří směrů:
 - Jako **VÝVOJÁŘ**: Je to technicky čisté, bezpečné a implementovatelné?
 - Jako **UŽIVATEL**: Je ovládání intuitivní, nebo hrozí zásek?
 - Jako **MANAŽER/PODNIKATEL**: Je tento rozsah realistický na rychlé nasazení?"

--------------------------------------------------------------------------------
**VÝSTUPNÍ INSTRUKCE PRO MODEL:**
Jakmile zodpovíme všechny body a provedeme křížovou validaci, vygeneruj mi kompletní, detailní PRD v Markdownu. Toto PRD bude striktně strukturováno podle **A.N.T. architektury spolehlivosti** a bude připraveno jako přímé zadání pro Vibe Coding (Cursor, Windsurf, Bolt apod.).

Obsahovat bude:
1. Přehled projektu & Kontext zakladatele
2. Cíl (North Star) & User Flow (První minuta)
3. MVP Scope (Must-have / Won't-have)
4. **A.N.T. Architektura spolehlivosti:**
   - **Vrstva A (Architektura):** SOPs, Markdown instrukce, vstupy/výstupy, okrajové případy.
   - **Vrstva N (Navigace):** AI orchestrátor, logika rozhodování, ošetření chyb.
   - **Vrstva T (Nástroje):** Deterministické skripty, API, datové modely.
5. Ekosystém, Data & Bezpečnost (Auth, Rate Limiting, Guardrails)
6. UX / UI styl & Tech Stack
7. Samoopravná smyčka (Self-Annealing) & Závěrečné vyhodnocení (3 Perspektivy)

Nyní mi polož první otázku.
