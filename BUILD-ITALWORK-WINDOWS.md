# Build di ItalworkSupport per Windows x64

Questo repository deriva dai sorgenti ufficiali RustDesk OSS, commit
`53996e3c404ea5083df0775057e4149e49102084`.

Default incorporati:

- ID Server: `italwork.ns0.it:21116`
- Relay Server: `italwork.ns0.it`
- chiave pubblica: `mL9KVLSCi2I2B8zJlCokFEkG9dS2TLs3xDTM1wPqu8Y=`

## 1. Prerequisiti

Installare manualmente, con i percorsi predefiniti:

1. Visual Studio Build Tools 2022, workload **Desktop development with C++**,
   includendo MSVC x64 e Windows 10/11 SDK.
2. Python 3 x64, abilitando **Add Python to PATH**.
3. Rust tramite `rustup-init.exe`.
4. LLVM/Clang 15 x64, aggiungendo la directory `bin` al `PATH`.
5. CMake e Ninja, entrambi nel `PATH`.
6. Flutter **3.24.5** in una directory senza spazi, aggiungendo `flutter\bin`
   al `PATH`, quindi eseguendo `flutter config --enable-windows-desktop`.

La macchina deve avere almeno 35 GB liberi. Il primo build scarica e compila
molte dipendenze e può richiedere oltre un'ora.

## 2. Verifica rapida

Aprire un nuovo PowerShell non elevato ed eseguire:

```powershell
git --version
python --version
rustup --version
clang --version
cmake --version
ninja --version
flutter --version
flutter doctor -v
```

`flutter --version` deve riportare `3.24.5`. `flutter doctor -v` deve rilevare
Visual Studio e il supporto Windows desktop.

## 3. Build

Dalla cartella del repository:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\build-italwork.ps1
```

Il risultato atteso è:

```text
dist\ItalworkSupport.exe
dist\ItalworkSupport.exe.sha256
```

Lo script si interrompe al primo errore e ne mostra il comando responsabile.
Non considerare completata la build se non appare `Build completata` e se il
controllo `ItalworkSupport.exe --version` fallisce.

## 4. Verifica funzionale

Su un PC di test privo di configurazioni RustDesk precedenti:

1. Avviare `ItalworkSupport.exe`.
2. Verificare la comparsa di un ID.
3. Controllare in **Impostazioni > Rete** che ID Server e Relay Server siano
   `italwork.ns0.it`.
4. Eseguire una connessione reale attraverso il server Italwork.

Il binario non è firmato digitalmente: Windows SmartScreen può mostrarne
l'origine sconosciuta. Per distribuzione professionale è consigliata una firma
Authenticode con certificato aziendale.

## Obblighi AGPL-3.0

RustDesk OSS è distribuito con licenza AGPL-3.0. Quando si distribuisce
`ItalworkSupport.exe`, ai medesimi destinatari deve essere resa disponibile la
**Corresponding Source** completa della versione esatta: questo repository
modificato, submodule, script di build, istruzioni e testo della licenza.

Non basta indicare il repository RustDesk originale, perché il binario contiene
modifiche Italwork. Conservare commit e sorgenti esatti di ogni release e
pubblicare un link stabile oppure accompagnare il binario con un'offerta valida
e concretamente utilizzabile per ottenere il sorgente. Le note e gli avvisi di
copyright esistenti non devono essere rimossi. Se il software modificato viene
offerto come servizio accessibile in rete, l'AGPL richiede inoltre che gli utenti
possano ottenere il sorgente della versione in esecuzione.

Queste indicazioni sono operative, non consulenza legale.
