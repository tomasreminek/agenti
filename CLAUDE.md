# Agent Instructions & Project Constitution

> Tento soubor slouží jako zdroj pravdy pro jakékoliv AI prostředí (Claude Code, Cursor, Gemini). Každý agent je povinen se jím řídit při každém kroku. Operuješ v systému, kde striktně oddělujeme záměr od exekuce, abychom maximalizovali spolehlivost.

## 🟢 Fáze 0: Inicializace projektu (Povinné)
Při startu nového projektu nebo na pokyn k inicializaci jsi povinen založit tuto strukturu a soubory:
1. `task_plan.md` -> Plán fází, úkolů a checklisty.
2. `progress.md` -> Záznam o tom, co bylo uděláno, jaké nastaly chyby a jaké jsou výsledky.
3. `gemini.md` (nebo `prd.md`) -> Ústava projektu. Zde musí být definována datová schémata (vstupy a výstupy) předtím, než začneš psát jakýkoliv kód.
4. Složky `directives/`, `execution/` a `.tmp/`.

## 🏛️ 3-Vrstvá Architektura (A.N.T.)
1. **Layer 1: Directive (Co dělat)**
   - Standardní operační postupy (SOPs) napsané v Markdownu, uložené v `directives/`.
   - Definují cíle, vstupy, očekávané výstupy a pravidla. Pokud se mění logika projektu, musíš nejprve upravit direktivu, až pak kód.

2. **Layer 2: Orchestration (Rozhodování - TVÁ ROLE)**
   - Ty jsi navigátor a mozek. Tvým úkolem je inteligentní routing dat mezi vrstvou 1 a 3.
   - Čteš direktivy, volíš správné skripty v exekuční vrstvě, předáváš jim data a zpracováváš chyby. Sám se nesnažíš dělat složité úkoly manuálně, vždy k tomu voláš specializovaný nástroj.

3. **Layer 3: Execution (Vykonávání práce)**
   - Deterministické Python/JS skripty uložené v `execution/` (nebo `tools/`).
   - Zde žije reálný kód, API volání a manipulace se soubory. Kód musí být čistý a testovatelný.

## ⚙️ Provozní zásady a pravidla
- **Data-First Rule:** Než vytvoříš jakýkoliv skript, musíme mít schválený formát dat (Payload).
- **Nejprve zkontroluj existující nástroje:** Než napíšeš nový skript, podívej se do `execution/`, zda už tam podobný nástroj není. 
- **Bezpečnost API:** Nikdy neprováděj operace, které by mohly nekontrolovaně zacyklit placená API volání. Citlivé údaje patří vždy jen do skrytého souboru `.env`.
- **Deliverables vs. Intermediates:** Složka `.tmp/` slouží výhradně pro dočasné mezisoubory, které lze smazat. Všechny trvalé výstupy směřují do cloudu, databází nebo finálních UI složek.

## 🔄 Samoopravná smyčka (Self-Annealing Loop)
Když skript nebo API selže, chyby jsou příležitostí k učení. Postupuj striktně takto:
1. **Analyzuj:** Přečti si stack trace a chybovou hlášku. Nehádej řešení.
2. **Oprav (Patch):** Uprav deterministický skript v exekuční vrstvě `execution/`.
3. **Otestuj:** Ověř, že skript po úpravě funguje správně.
4. **Zapiš ponaučení:** Aktualizuj příslušnou direktivu v `directives/` (např. o nové API limity nebo nutné hlavičky), aby se chyba už v budoucnu neopakovala. Tím se systém stává silnějším.

## 📂 Organizační struktura projektu
- `directives/` -> SOPs a zadání (Markdown)
- `execution/` -> Deterministické skripty (Python/JS/TS)
- `.tmp/` -> Dočasná data (Ignorováno v Gitu, mazatelné)
- `.env` -> API klíče a konfigurace (Ignorováno v Gitu)
- `gemini.md`, `task_plan.md`, `progress.md` -> Paměť a stav projektu
