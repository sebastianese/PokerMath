###########################################################################################
# Title     :   Poker M Ratio and Effective M calculator for Powershell
# Filename  :   PokerMath.psm1          
# Created by:   Seab4ss            
# Date      :   10/20/2017                
# Version   :   1.0        
# Update    :   This is the first version
# E-mail    :   sebastianese@gmail.com
#####################



function Get-Ratios{

<# 
    .Synopsis 
   Get-Ratios calculates both your M Ratio and Effective M. Depending on the value it will also place you on a colour zone. This is based on:
   https://en.wikipedia.org/wiki/M-ratio

   Get-Mratio will calculate your M Ratio
   
   Get-EffectiveM will calculate you Effective M Ratio 

    .DESCRIPTION 
  Get-Ratios Calculates both your M Ratio and Effective M. Depending on the value it will also place you on a colour zone. This is based on:
   https://en.wikipedia.org/wiki/M-ratio. This is to be used as a guide and reference while playing most types of Poker tournaments. 
    
    
    .EXAMPLE 
    Get-Ratios -Stack <your total Stacks> -Players <number of players> -BB <big blind> -SB <small blind> -Ante <ante>
    
    For example for a total stack of 3000, on a 10 player table with blinds of 100 and 50 and no ante:
    Get-Ratios -Stack 3000 -Players 10 -BB 100 -SB 50 -Ante 0
#> 
Param(
   [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
   [int]$Stack,
   [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
   [int]$Players,
   [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
   [int]$BB,
   [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
   [int]$SB,
   [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
   [int]$Ante
   )

$TotalAnte = $players * $Ante
$Mratio = $stack / ($BB + $SB + $TotalAnte) 
$BlindOut = $players * $Mratio
$EffectiveM = $Mratio * ($players/10)
$BlindOut2 = $players * $EffectiveM
$TotalBlinds = $Stack / $BB

Write-Host "Calculating Stats for a total stack size of [$stack], on a [$players] player table. Blinds are [$SB] and [$BB] with an ante of [$Ante] " -ForegroundColor Cyan



Function Get-Mratio{
$b = [math]::Round($BlindOut)
$a = [math]::Round($Mratio)
Write-Host "
Big Blinds: $TotalBlinds
M-ratio: $a
Blinded Out: $a rounds, or $B hands"  -ForegroundColor Cyan 
if ($Mratio -ge 20){
Write-Host "M-Ratio Zone: Green Zone" -ForegroundColor Green} 
if ($Mratio -ge 10 -and $Mratio -lt 20){
  Write-Host "M-Ratio Zone: Yellow Zone. Must take more risks" -ForegroundColor Yellow} 
if ($Mratio -ge 6 -and $Mratio -lt 10){
Write-Host "M-Ratio Zone: Orange Zone. 	Main focus is to be first-in whatever you decide to play, important to preserve chips" -ForegroundColor DarkRed} 
if ($Mratio -ge 1 -and $Mratio -lt 6){
Write-Host "M-Ratio Zone: Red Zone. Your only move is to move all-in or fold." -ForegroundColor Red} 
if ($Mratio -lt 1){
Write-Host "M-Ratio Zone: DEAD ZONE :(" -ForegroundColor Black} 
}

Function Get-EffectiveM{
$a = [math]::Round($EffectiveM)
$b = [math]::Round($BlindOut2)
Write-Host "
Effective-M Ratio: $a
Blinded Out: $a rounds, or $B hands" -ForegroundColor Cyan
if ($EffectiveM -ge 20){
Write-Host "Effective-M Ratio Zone: Green Zone" -ForegroundColor Green} 
if ($EffectiveM -ge 10 -and $EffectiveM -lt 20){
  Write-Host "Effective-M Ratio Zone: Yellow Zone. Must take more risks" -ForegroundColor Yellow} 
if ($EffectiveM -ge 6 -and $EffectiveM -lt 10){
Write-Host "Effective-M Ratio Zone: Orange Zone. 	Main focus is to be first-in whatever you decide to play, important to preserve chips" -ForegroundColor DarkRed} 
if ($EffectiveM -ge 1 -and $EffectiveM -lt 6){
Write-Host "Effective-M Ratio Zone: Red Zone. Your only move is to move all-in or fold." -ForegroundColor Red} 
if ($EffectiveM -lt 1){
Write-Host "Effective-M Ratio Zone: DEAD ZONE :(" -ForegroundColor Black} 
}
Get-Mratio
Get-EffectiveM


}

function Get-CallStats {
#Based on Phil Gordon rule of 2 and 4 . Still in development
Param(
   [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
   [int]$Outs,
   [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
   [int]$Pot,
   [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
   [int]$Callbet,
   [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
   [int]$CardsToSee
   )

$GordonC = 2
$EffectivePot = $Pot + $CallBet  
$WinP = ($Outs * $GordonC) * $CardsToSee
$contribution = ($Callbet*100)/$EffectivePot
$EV = $WinP - $contribution
$EvVal = ($EffectivePot*$EV) /100

Write-Host "Your winning percentage for [$Outs] outs is [$WinP]%.
Your EV is [$EV] and you are contributing with [$contribution]% of the pot with is about [$EvVal] chips" -ForegroundColor Cyan
if ($EV -ge "0"){
Write-Host "You are in a good position to call this hand" -ForegroundColor Green
}
else{
Write-Host "THis hand should be folded" -ForegroundColor Red
}

}

#EV = {W% * $W} - {%l *$l} needs to be 0 or more