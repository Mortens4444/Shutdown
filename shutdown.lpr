//program shutdown_program;

{$mode objfpc}{$H+}

uses
//  {$IFDEF UNIX}{$IFDEF UseCThreads}
//  cthreads,
//  {$ENDIF}{$ENDIF}
  Windows;

//{$IFDEF WINDOWS}{$R shutdown.rc}{$ENDIF}

var hToken, retval: Cardinal;
    tkp: TOKEN_PRIVILEGES;
begin
  OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken);
  LookupPrivilegeValue(nil, 'SeShutDownPrivilege', tkp.Privileges[0].Luid);
  tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
  tkp.PrivilegeCount := 1;
  AdjustTokenPrivileges(hToken, False, tkp, SizeOf(TOKEN_PRIVILEGES), tkp, retval);
  Windows.ExitWindowsEx(EWX_POWEROFF, 0);
end.

