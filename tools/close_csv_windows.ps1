# Cierra las ventanas de LibreOffice que tengan abiertos los CSV de exportacion
# (deja abiertos los demas documentos, p. ej. el xlsx de precios).
Add-Type @"
using System;
using System.Text;
using System.Runtime.InteropServices;
public class LoWin {
  [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWindowsProc cb, IntPtr l);
  public delegate bool EnumWindowsProc(IntPtr h, IntPtr l);
  [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int n);
  [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
  [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr h, out uint pid);
  [DllImport("user32.dll")] public static extern bool PostMessage(IntPtr h, uint msg, IntPtr w, IntPtr l);
  public static int Close(uint pid, string match) {
    int n = 0;
    EnumWindows((h, l) => {
      uint p; GetWindowThreadProcessId(h, out p);
      if (p == pid && IsWindowVisible(h)) {
        var sb = new StringBuilder(512); GetWindowText(h, sb, 512);
        if (sb.ToString().Contains(match)) { PostMessage(h, 0x0010, IntPtr.Zero, IntPtr.Zero); n++; }
      }
      return true;
    }, IntPtr.Zero);
    return n;
  }
}
"@
$procs = Get-Process soffice.bin -ErrorAction SilentlyContinue
foreach ($p in $procs) {
    [void][LoWin]::Close([uint32]$p.Id, "catalogo-fichas")
    [void][LoWin]::Close([uint32]$p.Id, "catalogo-inventario")
}
Start-Sleep -Seconds 3
Write-Output "ventanas de exportacion cerradas"
