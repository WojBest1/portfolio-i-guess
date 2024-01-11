import random

yyy=input("rock,papaer or scicoes")
hi=random.randint(1,3)


if hi == 1 and yyy == 'paper':
    print("paper raps around the rock you win")
  
if hi == 1 and yyy == 'rock':
    print("its a draw")

if hi == 1 and yyy == 'sci':
    print("sci loses to rock you lose")

if hi == 2 and yyy == 'paper':
    print("paper draws with paper its a draw")
  
if hi == 2 and yyy == 'rock':
    print("rock wins against paper")

if hi == 2 and yyy == 'sci':
    print("sci cuts through paper you lose  ")

if hi == 3 and yyy == 'paper':
    print("scicors cut through paper you lose")
  
if hi == 3 and yyy == 'rock':
    print("rock wins against paper you win")

if hi == 3 and yyy == 'sci':
    print("sci draws against a sci")
