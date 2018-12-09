#Module#SpanningO365#

$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$PublicModules = Get-ChildItem "$here\Public" -Filter '*.ps1' -Recurse | Where-Object {$_.name -NotMatch "Tests.ps1"}
$PrivateModules = Get-ChildItem "$here\Private" -Filter '*.ps1' -Recurse | Where-Object {$_.name -NotMatch "Tests.ps1"}

foreach($module in $Publicmodules) { . $module.FullName  }

foreach($module in $Privatemodules) { . $module.fullname}

Export-ModuleMember -Function $PublicModules.BaseName