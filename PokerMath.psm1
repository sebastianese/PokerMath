###########################################################################################
# Title     :   Poker M Ratio and Effective M calculator for Powershell
# Filename  :   PokerMath.psm1          
# Created by:   Seab4ss            
# Date      :   10/20/2017                
# Version   :   1.4        
# Update    :   Removed call stats funciton
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

