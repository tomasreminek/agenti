================================================================================
ČÁST 1: MASTER PROMPT PRO AI – INTERAKTIVNÍ TVORBA PRD (Zkopíruj do Claude 4.7 Haiku)
================================================================================

Chci s tebou metodou vibe codingu připravit podklady pro tvorbu nové aplikace. Tvým úkolem je pokládat mi upřesňující otázky striktně JEDNU PO DRUHÉ. Vždy počkej na mou odpověď, než položíš další otázku.

DŮLEŽITÉ PRAVIDLO: Pokud u jakékoliv otázky odpovím "Nevím", "Navrhni" nebo odpovím neúplně, okamžitě mi navrhni 3 konkrétní, logické a technicky snadno realizovatelné varianty, ze kterých si mohu vybrat.

Projdeme spolu tyto body:

1. Jádro pudla (Core Value)
"Co je ta jedna hlavní věc, kterou aplikace dělá? Jaký je ten 'Aha moment', kdy uživatel uvidí ušetřenou práci?"

2. První minuta v aplikaci (User Flow)
"Když uživatel aplikaci poprvé otevře, co přesně uvidí na obrazovce a jaký je jeho první krok?"

3. MVP Scope (Ořezání na dřeň)
"Co je ta nejjednodušší možná verze, která ti bude stačit pro první spuštění? Které funkce záměrně odložíme na později, abychom se nezasekli a nevyčerpali API limity?"

4. UI/UX Vibe (Vzhled)
"Jak má aplikace působit? Super-čistý 'Notion' styl, tmavý režim (Dark Mode), nebo jednoduchý a barevný design?"

5. Data a Integrace (Ecosystem)
"Potřebujeme trvalou databázi (např. ukládání uživatelů/dat), nebo stačí, když aplikace bude fungovat lokálně v prohlížeči? Potřebujeme externí API (např. OpenAI pro generování textů, Stripe pro platby)?"

6. Deployment (Kde to poběží)
"Kde chceš aplikaci provozovat? (Např. statický web na Cloudflare Pages/Vercel, nebo plná aplikace připravená pro Docker/Coolify server?)"

7. Samoopravná logika (Self-Annealing)
"Chceš do projektu zahrnout pravidlo, že při jakékoliv chybě musí AI nejprve analyzovat chybu, opravit ji a zapsat ponaučení do ústavy projektu, aby se neopakovala?"

--------------------------------------------------------------------------------
INSTRUKCE PRO MODEL:
Jakmile zodpovíme všechny body, vygeneruj mi kompletní, detailní PRD v Markdownu. Toto PRD bude obsahovat: Cíl, User Flow, MVP Scope (Must-have / Won't-have), Funkční požadavky, Datový model, UX styl a pravidla pro řešení chyb.

Nyní mi polož první otázku.

