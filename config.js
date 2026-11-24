// ─────────────────────────────────────────────────────────────
//  Sifa Evolution – Konfiguration
//  Trage hier die Daten deines Supabase-Projekts ein
//  (Supabase → Project Settings → API).
//  Leer gelassen läuft die App im Demo-Modus (nur dieses Gerät).
// ─────────────────────────────────────────────────────────────
window.SIFA_CONFIG = {
  supabaseUrl: "https://aptgwscqvdftwqvpkgeo.supabase.co",          // z. B. "https://abcdefgh.supabase.co"
  supabaseAnonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFwdGd3c2NxdmRmdHdxdnBrZ2VvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTU1MTkzODIsImV4cCI6MjExMTA5NTM4Mn0.HmJpCAbX3fLRpA5GuUUhBibZW4IEI3Algr_nI1gGWEE",      // der "anon" / "publishable" Key (öffentlich, KEIN service_role!)
  room: "sifa-stuttgart-2026-11-25"  // muss zum Raum in supabase-setup.sql passen
};
