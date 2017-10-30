###########################################################################################
# Title     :   Poker M Ratio and Effective M calculator for Powershell
# Filename  :   PokerMath.psm1          
# Created by:   Seab4ss            
# Date      :   10/20/2017                
# Version   :   1.4        
# Update    :   Removed the Get-CallStats function for improvement. 
# E-mail    :   sebastianese@gmail.com
#####################


Get-Ratios calculates both your M Ratio and Effective M. Depending on the value it will also place you on a colour zone. This is based on:
https://en.wikipedia.org/wiki/M-ratio

PowerShell Gallery: https://www.powershellgallery.com/packages/PokerMath/1.3

Get-Mratio will calculate your M Ratio
   
Get-EffectiveM will calculate you Effective M Ratio 


    
EXAMPLE: 

Get-Ratios -Stack <your total Stacks> -Players <number of players> -BB <big blind> -SB <small blind> -Ante <ante>

For example, for a total stack of 3000, on a 10 player table with blinds of 100 and 50 and no ante:

Get-Ratios -Stack 3000 -Players 10 -BB 100 -SB 50 -Ante 0
