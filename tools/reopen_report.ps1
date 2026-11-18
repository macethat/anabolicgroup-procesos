Add-Type @"
using System;
using System.Text;
using System.Runtime.InteropServices;
public class LoWin5 {
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
foreach ($p in (Get-Process soffice.bin -ErrorAction SilentlyContinue)) {
    [void][LoWin5]::Close([uint32]$p.Id, "INFORME-CAMBIOS-20261118.docx")
}
Start-Sleep -Seconds 3
Start-Process -FilePath "C:\Program Files\LibreOffice\program\soffice.exe" -ArgumentList '"C:\anabolicgroup\INFORME-CAMBIOS-20261118.docx"'
Write-Output "informe reabierto"
