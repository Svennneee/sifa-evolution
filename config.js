// ─────────────────────────────────────────────────────────────
//  Sifa Evolution – Konfiguration
//  Trage hier die Daten deines Supabase-Projekts ein
//  (Supabase → Project Settings → API).
//  Leer gelassen läuft die App im Demo-Modus (nur dieses Gerät).
// ─────────────────────────────────────────────────────────────
window.SIFA_CONFIG = {
  supabaseUrl: "https://aptgwscqvdftwqvpkgeo.supabase.co",          // z. B. "https://abcdefgh.supabase.co"
  supabaseAnonKey: "sb_publishable_Wr0cbui57eEpx0ZueS_Zrg_NDBtl8l_",      // der "anon" / "publishable" Key (öffentlich, KEIN service_role!)
  room: "sifa-stuttgart-2026-11-25"  // muss zum Raum in supabase-setup.sql passen
};
