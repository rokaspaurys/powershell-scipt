<#
.Synopsis
   Leidzia pildyti, perziureti ir ieskoti duomenu sarase.
.DESCRIPTION
   Ivedus asmens varda ir pavarde, galima ieskoti asmens sarase, arba itraukti i sarasa.
.EXAMPLE
   Ivedus varda "Petras" ir pavarde "Petraitis", asmenu sarase atsiranda naujas asmuo "Petras Petraitis".
.EXAMPLE
   Ieskant asmens sarase, ivedus ieskomo asmens varda "Petras Petraitis": parodomas pranesimas, ar toks asmuo yra/nera sarase.
#>

function Duomenu-Pildymas{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline = $True)]
        [ValidateNotNullOrEmpty()]
        [string] $Vardas,
        [Parameter(Mandatory=$true, ValueFromPipeline = $True)]
        [ValidateNotNullOrEmpty()]
        [string] $Pavarde
     
    )
    $info = $Vardas + " " + $Pavarde
    $info | Add-Content 'C:\Users\Rokas\Desktop\duomenys.txt'
}

$meniu=@"
~~~~~~~~~~~~~~~~~"MENIU"~~~~~~~~~~~~~~~~~~
1. Pildyti duomenis
2. Patikrinti asmenu sarasa
3. Perziureti asmenu sarasa
4. Istrinti duomenis
4. Baigti darba
"@


$meniu
$loop=$true
while($loop)
{
    $var=Read-Host "Prasome pasirinkti [1-4]"
    Switch ($var)
    {
        1{
            Write-Host "Iveskite duomenis:"
            Duomenu-Pildymas
            $meniu
        }
        2{
            $varpav=Read-Host "Iveskite ieskomo asmens varda ir pavarde "
            $Duom=Get-Content duomenys.txt
            $var=0
            ForEach($line in $Duom)
            {
                if($varpav -eq $line){
                    $var=1
                    $asm=$line
                }
            }
            if($var -eq 1){
                Write-Host "Asmuo rastas: "
                Write-Host $line
            }
            else{
                Write-Host "Asmuo nerastas."
            }
        }
        3{
            Write-Host "Asmenu sarasas:"
            cat duomenys.txt
        $meniu
        }
        4{
            $asm=Read-Host "Pasirinkite, kurio asmens duomenis norite istrinti "
            $Duom=foreach($line in Get-Content duomenys.txt)
            {
                if($line -like $asm)
                {

                }
                else
                {
                    $line
                }
            }
            $data | Set-Content duomenys1.txt -Force
            cat duomenys1.txt
        }
        5{
            break $var
        }
        default {
            Write-Host "Netinkamas pasirikimas. Bandykite dar karta."
        }
    }
}