#Name: Yu Mengyao (S10205696F) Class: FI01(P07) Date: 16/08/2020

import random

# +------------------------
# | Text for various menus 
# +------------------------
main_text = ["New Game",\
             "Resume Game",\
#            "View Leaderboard",\
             "Exit Game"]

town_text = ["View Character",\
             "View Map",\
             "Move",\
             "Rest",\
             "Save Game",\
             "Exit Game"]

open_text = ["View Character",\
             "View Map",\
             "Move",\
             "Sense Orb",\
             "Exit Game"]

fight_text = ["Attack",\
              "Run"]

world_map = [['T', ' ', ' ', ' ', ' ', ' ', ' ', ' '],\
             [' ', ' ', ' ', 'T', ' ', ' ', ' ', ' '],\
             [' ', ' ', ' ', ' ', ' ', 'T', ' ', ' '],\
             [' ', 'T', ' ', ' ', ' ', ' ', ' ', ' '],\
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],\
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],\
             [' ', ' ', ' ', ' ', 'T', ' ', ' ', ' '],\
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'K']]


print("Welcome to Ratventure!")
print("----------------------")

# Code your main program here

day = 1
position = [0,0]        #reference list
orb_position = [5,5]
gameover = False
hero_stat = {'min':2,'max':4,'defence':1,'hp':20,'orb':False}
rat_stat = {'min':1,'max':3,'defence':1,'hp':10}
ratking_stat = {'min':6,'max':10,'defence':5,'hp':25}

def display_main_text():
    for n in range (len(main_text)):
        print('{:d}) {:s}'.format(n+1,main_text[n]))

def display_town_text():
    for a in range (len(town_text)):
        print('{:d}) {:s}'.format(a+1,town_text[a]))

def display_world_map(world_map):
    for i in range (len(world_map)):
        print('+---+---+---+---+---+---+---+---+')
        for j in range (len(world_map[i])):
            if position[0]==i and position[1] == j:
                if world_map[i][j] == ' ':
                    print('|{:^3s}'.format('H'),end = '')
                #else:
                    #print('H/'+world_map[i][j])
                elif world_map[i][j] == 'T':
                    print('|{:^3s}'.format('H/T'),end = '')
                else:
                    print('|{:^3s}'.format('H/K'),end = '')
            else:
                print('|{:^3s}'.format(world_map[i][j]),end = '')
        print('|')
    print('+---+---+---+---+---+---+---+---+')

def display_fight_text():
    for b in range (len(fight_text)):
        print('{:d}) {:s}'.format(b+1,fight_text[b]))

def display_open_text():
    for c in range (len(open_text)):
        print('{:d}) {:s}'.format(c+1,open_text[c]))

def save_game():
    file = open('saved.txt','w')
    file.write (str(position[0]) + ',')
    file.write (str(position[1]) + ',')
    for x in hero_stat:
        file.write (str(hero_stat[x])+ ',')
    file.write (str(day))
    file.close()

def resume_game():
    global day
    file = open('saved.txt','r')
    line = file.readline()
    data = line.split (',')
    position [0] = int(data[0])
    position [1] = int(data[1])
    hero_stat['min'] = int(data[2])
    hero_stat['max'] = int(data[3])
    hero_stat['defence'] = int(data[4])
    hero_stat['hp'] = int(data[5])
    hero_stat['orb'] = data[6]
    day = int(data[7])
    if hero_stat['orb'] == 'True':
        hero_stat['orb'] = True
    else:
        hero_stat['orb'] = False
    file.close()

def movement(move):
    global day
    while move != 'W' and move != 'A' and move != 'S' and move != 'D':
        move = input('Invalid input, please enter another command: ')
        move = move.upper()
    if move == 'W':
        position[0] -= 1
        day += 1
        rat_stat['hp'] = 10
        if position[0] < 0:
            position[0] = 0
            day -= 1
            print('You cannot step out of the map.')
    elif move == 'A':
        position[1] -= 1
        day += 1
        rat_stat['hp'] = 10
        if position[1] < 0:
            position[1] = 0
            day -= 1
            print('You cannot step out of the map.')
    elif move == 'S':    
        position[0] += 1
        day += 1
        rat_stat['hp'] = 10
        if position[0] >= len(world_map):
            position[0] = 7
            day -= 1
            print('You cannot step out of the map.')
    else:
        position[1] += 1
        day += 1
        rat_stat['hp'] = 10
        if position[1] >= len(world_map[0]):
            position[1] = 7
            day -= 1
            print('You cannot step out of the map.')

def sense_orb():
    global day
    if rat_stat['hp'] <= 0 and hero_stat['orb'] == False:
        day+=1
        if position[0] == orb_position[0]:
            if position[1] > orb_position[1]:
                print('You sense that the Orb of Power is to the west.')
            elif position[1] < orb_position[1]:
                print('You sense that the Orb of Power is to the east.')
            elif position[1] == orb_position[1]:
                print('You found the Orb of Power!\nYour attack increases by 5!\nYour defence increases by 5!')
                hero_stat['min'] = hero_stat['min'] + 5
                hero_stat['max'] = hero_stat['max'] + 5
                hero_stat['defence'] = hero_stat['defence'] + 5
                hero_stat['orb'] = True
        elif position[1] == orb_position[1]:
            if position[0] > orb_position[0]:
                print('You sense that the Orb of Power is to the north.')
            elif position[0] < orb_position[0]:
                print('You sense that the Orb of Power is to the south.')
            elif position[0] == orb_position[0]:
                print('You found the Orb of Power!\nYour attack increases by 5!\nYour defence increases by 5!')
                hero_stat['min'] = hero_stat['min'] + 5
                hero_stat['max'] = hero_stat['max'] + 5
                hero_stat['defence'] = hero_stat['defence'] + 5
                hero_stat['orb'] = True
        else:
            if position[0] > orb_position[0] and position[1] > orb_position[1]:
                print('You sense that the Orb of Power is to the northwest.')
            elif position[0] < orb_position[0] and position[1] > orb_position[1]:
                print('You sense that the Orb of Power is to the southwest.')
            elif position[0] < orb_position[0] and position[1] < orb_position[1]:
                print('You sense that the Orb of Power is to the southeast.')
            elif position[0] > orb_position[0] and position[1] < orb_position[1]:
                print('You sense that the Orb of Power is to the northeast.')
    elif rat_stat['hp'] > 0:
        print('You cannot sense the Orb of Power.')
    if hero_stat['orb'] == True:
        print('You have gained the Orb of Power.')

def display_town_menu(choice1):
    global gameover
    global day
    while choice1 != '1' and choice1 != '2' and choice1 != '3' and choice1 != '4' and choice1 != '5' and choice1 != '6':
        choice1 = input('Please enter the valid instruction:')
    if choice1 == '1':
        print('The Hero\n  Damage: {:d}-{:d}\n Defence: {:d}\n      HP: {:d}'\
              .format(hero_stat['min'],hero_stat['max'],hero_stat['defence'],hero_stat['hp']))
        if hero_stat['orb'] == True :
            print('You are holding the Orb of Power.')
    elif choice1 == '2':
        display_world_map(world_map)
    elif choice1 == '3':
        display_world_map(world_map)
        print('W = up; A = left; S = down; D = right')
        move = input('Your move: ')
        move = move.upper()
        movement(move)
        display_world_map(world_map)
    elif choice1 == '4':
        hero_stat['hp']=20
        day+=1
        print('You are fully healed.\n')
    elif choice1 == '5':
        save_game()
        print('Game saved.\n')
    else:
        gameover = True
        exit()

def display_outdoor_menu (choice3):
    global gameover
    while choice3 != '1' and choice3 != '2' and choice3 != '3' and choice3 != '4' and choice3 != '5' :
        choice3 = input('Please enter the valid instruction:')
    if choice3 == '1':
        print('The Hero\n  Damage: {:d}-{:d}\n Defence: {:d}\n      HP: {:d}'\
              .format(hero_stat['min'],hero_stat['max'],hero_stat['defence'],hero_stat['hp']))
    elif choice3 == '2':
        display_world_map(world_map)
    elif choice3 == '3':
        display_world_map(world_map)
        print('W = up; A = left; S = down; D = right')
        move = input('Your move: ')
        move = move.upper()
        movement(move)
        display_world_map(world_map)
    elif choice3 == '4':
        sense_orb()
    else:
        gameover = True
        exit()
        
def display_combat_menu(choice2):
    global gameover
    while choice2 != '1' and choice2 != '2':
        choice2 = input('Please enter the valid instruction:')
    if choice2 == '1':
        if hero_damage <= rat_stat['defence']:
            print('The Rat block the attack!')
        else:
            print('You deal {:d} damage to the Rat'.format(hero_damage-rat_stat['defence']))
            rat_stat['hp'] = rat_stat['hp'] + rat_stat['defence'] - hero_damage
        if rat_damage <= hero_stat['defence'] :
            print('You block the attack!')
        else:
            print('Ouch! The Rat hit you for {:d} damage!'.format(rat_damage-hero_stat['defence']))
            hero_stat['hp'] = hero_stat['hp'] + hero_stat['defence'] - rat_damage
        print('You have {:d} HP left.'.format(hero_stat['hp']))
        if rat_stat['hp'] <= 0 and hero_stat['hp'] > 0:
            print('The Rat is dead! You are victorious!\n')
            display_open_text()
            choice3 = input('Enter choice:')
            print()
            display_outdoor_menu (choice3)
                
        elif hero_stat['hp'] <= 0:
            print('You lose, game is over.')
            gameover = True
    else:
        print('You run and hide.')
        rat_stat['hp'] = 10
        display_open_text()
        choice3 = input('Enter choice:')
        print()
        display_outdoor_menu (choice3)

def display_ratking_combat_menu(choice4):
    global gameover
    while choice4 != '1' and choice4 != '2' :
        choice4 = input('Please enter the valid instruction:')
    if choice4 == '1':
        if hero_stat['orb'] == True:    
            if hero_damage <= ratking_stat['defence']:
                print('The Rat King block the attack!')
            else:
                print('You deal {:d} damage to the Rat King'.format(hero_damage - ratking_stat['defence']))
                ratking_stat['hp'] = ratking_stat['hp'] + ratking_stat['defence'] - hero_damage
                
            if ratking_damage <= hero_stat['defence'] :
                print('You block the attack!')
            else:
                print('Ouch! The Rat King hit you for {:d} damage!'.format(ratking_damage - hero_stat['defence']))
                hero_stat['hp'] = hero_stat['hp'] + hero_stat['defence'] - ratking_damage
            print('You have {:d} HP left.'.format(hero_stat['hp']))
            
            if ratking_stat['hp'] <= 0 and hero_stat['hp'] > 0:
                print('The Rat King is dead! You are victorious!')
                print('Congratulations, you have defeated the Rat King!')
                print('The world is saved! You win!')
                gameover = True
            elif hero_stat['hp'] <= 0:
                print('You lose, game is over.')
                gameover = True
        elif hero_stat['orb'] == False:
            print('You do not have the Orb of Power - the Rat King is immune!')
            print('You deal 0 damage to the Rat King')
            print('Ouch! The Rat King hit you for {:d} damage!'.format(ratking_damage))
            hero_stat['hp'] = hero_stat['hp'] - ratking_damage
            print('You have {:d} HP left.'.format(hero_stat['hp']))
            if hero_stat['hp'] <= 0:
                gameover = True       
    else:
        print('You run and hide.')
        ratking_stat['hp'] = 25
        display_open_text()
        choice3 = input('Enter choice:')
        print()
        display_outdoor_menu (choice3)

display_main_text()
option = input('Enter choice:')
print()
while option != '1' and option != '2' and option != '3' :
    option = input('Please enter the valid instruction:')
if option == '1':
    while not (gameover):
        hero_damage = random.randint(2,4)
        rat_damage = random.randint(1,3)
        ratking_damage = random.randint(6,10)
        if world_map[position[0]][position[1]] == 'T':
            print('Day {:d}: You are in a town.'.format(day))
            display_town_text()
            choice1 = input('Enter choice:')
            print()
            display_town_menu(choice1)
            
        elif world_map[position[0]][position[1]] == ' ':
            print('Day {:d}: You are out in the open.'.format(day))
            if rat_stat['hp'] > 0:
                print('Encounter! - Rat')
                print('Damage: {:d}-{:d}\n Defence:  {:d}\n      HP:  {:d}'\
                      .format(rat_stat['min'],rat_stat['max'],rat_stat['defence'],rat_stat['hp']))
                display_fight_text()
                choice2 = input('Enter choice:')
                print()
                display_combat_menu(choice2)
                    
            elif rat_stat['hp'] <= 0:
                display_open_text()
                choice3 = input('Enter choice:')
                print()
                display_outdoor_menu (choice3)
                
        elif world_map[position[0]][position[1]] == 'K':
            print('Day {:d}: You see the Rat King.'.format(day))
            print('Encounter! - Rat King')
            print('Damage: {:d}-{:d}\n Defence:  {:d}\n      HP:  {:d}'\
                  .format(ratking_stat['min'],ratking_stat['max'],ratking_stat['defence'],ratking_stat['hp']))
            display_fight_text()
            choice4 = input('Enter choice:')
            print()
            display_ratking_combat_menu(choice4)
           
               
elif option == '2':
    resume_game()
    while not gameover:
        hero_damage = random.randint(2,4)
        rat_damage = random.randint(1,3)
        ratking_damage = random.randint(6,10)
        if world_map[position[0]][position[1]] == 'T':
            print('Day {:d}: You are in a town.'.format(day))
            display_town_text()
            choice1 = input('Enter choice:')
            print()
            display_town_menu(choice1)
            
        elif world_map[position[0]][position[1]] == ' ':
            print('Day {:d}: You are out in the open.'.format(day))
            if rat_stat['hp'] > 0:
                print('Encounter! - Rat')
                print('Damage: {:d}-{:d}\n Defence:  {:d}\n      HP:  {:d}'\
                      .format(rat_stat['min'],rat_stat['max'],rat_stat['defence'],rat_stat['hp']))
                display_fight_text()
                choice2 = input('Enter choice:')
                print()
                display_combat_menu(choice2)
                    
            elif rat_stat['hp'] <= 0:
                display_open_text()
                choice3 = input('Enter choice:')
                print()
                display_outdoor_menu (choice3)
        elif world_map[position[0]][position[1]] == 'K':
            print('Day {:d}: You see the Rat King.'.format(day))
            print('Encounter! - Rat King')
            print('Damage: {:d}-{:d}\n Defence:  {:d}\n      HP:  {:d}'\
                  .format(ratking_stat['min'],ratking_stat['max'],ratking_stat['defence'],ratking_stat['hp']))
            display_fight_text()
            choice4 = input('Enter choice:')
            print()
            display_ratking_combat_menu(choice4)

elif option == '3':
    exit()
