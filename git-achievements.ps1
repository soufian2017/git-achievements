
$pathBackup = $Env:Path
$Env:Path = "/bin;$Env:Path"
$gaDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$gitX = [Environment]::GetEnvironmentVariable("gitAchievementsGitPath", "User");
if(! $gitX)
{
	$gitEx = 'Git\bin\sh.exe';
	$gitX = $Env:ProgramFiles, ${Env:ProgramFiles(x86)}, $Env:ProgramW6432 | %{ "$_\$gitEx" } | ?{ Test-Path $_ } | select -first 1
	[Environment]::SetEnvironmentVariable("gitAchievementsGitPath", $gitX, "User")
}

&  $gitX "$gaDir\git-achievements" $args
$Env:Path = $pathBackup

