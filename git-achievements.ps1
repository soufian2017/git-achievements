
$pathBackup = $Env:Path
$Env:Path = "/bin;$Env:Path"
$gaDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$shExe = [Environment]::GetEnvironmentVariable("gitAchievementsShExePath", "User")

if(!$shExe) {
	$shExe = Get-Command sh.exe -ErrorAction SilentlyContinue | Select -First 1 -Exp Definition
	if(!$shExe) {
		$gitCmd = Get-Command git.cmd | Select -First 1 -Exp Definition | Split-Path -Parent
		$shExe = "$($gitCmd | Split-Path -Parent)\bin\sh.exe"
	}
	[Environment]::SetEnvironmentVariable("gitAchievementsShExePath", $shExe, "User")
}

& $shExe "$gaDir\git-achievements" $args
$Env:Path = $pathBackup

