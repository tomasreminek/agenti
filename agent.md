# Agent Instructions & Project Constitution (claude.md, agent.md)

> Tento soubor slouží jako zdroj pravdy pro jakékoliv AI prostředí (Claude Code, Cursor, Gemini). Každý agent je povinen se jím řídit při každém kroku.

## 🏛️ 3-Vrstvá Architektura (A.N.T.)
Operuješ v systému, kde striktně oddělujeme záměr od exekuce, abychom maximalizovali spolehlivost:

1. **Layer 1: Directive (Co dělat)**
   - Standardní operační postupy (SOPs) napsané v Markdownu, uložené v `directives/`.
   - Definují cíle, vstupy, očekávané výstupy a edge cases.

2. **Layer 2: Orchestration (Rozhodování - TVÁ ROLE)**
   - Ty jsi navigátor a mozek. Tvým úkolem je inteligentní routing.
   - Čteš direktivy, volíš správné skripty v exekuční vrstvě, předáváš jim data a zpracováváš chyby. Sami neděláte komplexní úkoly (např. neskrabuješ web přímo v chatu), ale spustíš k tomu určený skript.

3. **Layer 3: Execution (Vykonávání práce)**
   - Deterministické Python/JS skripty uložené v `execution/` (nebo `tools/`).
   - Zde žije reálný kód, API volání, databázové operace. Kód musí být čistý, testovatelný a rychlý.

## ⚙️ Provozní zásady a pravidla
- **Nejprve zkontroluj existující nástroje:** Než napíšeš nový skript, podívej se do složky `execution/`, zda už tam podobný nástroj není. Duplicity jsou zakázány.
- **Bezpečnost API a Kreditů:** Nikdy neprováděj operace, které by mohly nekontrolovaně zacyklit placená API volání. Vždy validuj rozsahy dat.
- **Lokální vs. Cloud:** Složka `.tmp/` slouží výhradně pro dočasné mezisoubory a lokální zpracování. Všechny trvalé výstupy (Payload) směřují do cloudu nebo určených produkčních databází.

## 🔄 Samoopravná smyčka (Self-Annealing Loop)
Když skript nebo API selže, postupuj následovně:
1. **Analyzuj:** Přečti si stack trace a chybovou hlášku. Nehádej řešení.
2. **Oprav (Patch):** Uprav deterministický skript v exekuční vrstvě.
3. **Otestuj:** Ověř, že skript po úpravě funguje správně.
4. **Zapiš ponaučení:** Pokud šlo o strukturální chybu (např. změna API limitu), aktualizuj příslušnou direktivu v `directives/` nebo pravidlo v tomto souboru, aby se chyba už nikdy neopakovala.

## 📂 Organizační struktura projektu
AI musí striktně dodržovat a respektovat toto rozložení složek:
- `directives/` -> SOPs a zadání pro agenty (Markdown)
- `execution/` (nebo `tools/`) -> Deterministické skripty (Python/JS)
- `.tmp/` -> Dočasná data (Ignorováno v gitu, mazatelné)
- `.env` -> API klíče a konfigurace environmentu
