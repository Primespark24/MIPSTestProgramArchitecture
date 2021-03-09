<# Build Script to Build 64 Bit Assembler Files using Microsofts Assembler
Reference for visual studio code tasks used in development: https://code.visualstudio.com/docs/editor/tasks
Reference for assembler command line options: ml.exe /?  will list the command line options
#>
param (
	[string]$workspaceFolder = "."
)
cd "$workspaceFolder/bin/"
$assemblerfiles="" + (get-item $workspaceFolder/source/*.asm)
if ( -not $assemblerfiles) {
	echo "No files to compile!"
	exit
}
$exefile="$workspaceFolder/bin/main.exe"
# Set the 32 bit development environment by calling vcvars64.bat 
# Compile and link in one step using ml.exe 
$ranstring = -join ((48..57) + (97..122) | Get-Random -Count 32 | % {[char]$_})
$batfile = "$workspaceFolder/.vscode/" + $ranstring + ".bat"
$command = '"C:/Dev/VS/VC/Auxiliary/Build/vcvars32.bat"'
echo $command > $batfile
$command = '"ml.exe"' + " /nologo /Sg /WX /Zi /I C:\Irvine /W3 /Fe " + $exefile + " /errorReport:prompt /Ta " + $assemblerfiles + ' /link /ENTRY:main /LARGEADDRESSAWARE:NO C:/Irvine/Irvine32.lib kernel32.lib '
echo $command >> $batfile
type $batfile | CMD
$ofiles = (get-item *.obj)
if ($ofiles){
		rm $ofiles
}
rm $batfile
