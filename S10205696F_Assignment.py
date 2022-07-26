#Name: Yu Mengyao (S10205696F) Class: FI01(P07) Date: 16/08/2020

import random

# +------------------------
# | Text for various menus 
# +------------------------
main_text = ["New Game",\
             "Resume Game",\
            "View Leaderboard",\
             "Exit Game"]

town_text = ["View Character",\
             "View Map",\
             "Move",\
             "Rest",\
             "Shop",\
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
player_name = input ('Enter your player name: ')                #Prompt user to input the player name
day = 1                                                         #Keep track of the number of days taken by the player to win the game
position = [0,0]                                                #reference list shows the hero position on the map
orb_position = [random.randint(4,7),random.randint(4,7)]        #The position of orb of power is randomly selected
print(orb_position)
gameover = False                                                #To control when the while loop finshes
hero_stat = {'min':2,'max':4,'defence':1,'hp':20,'orb':False}   #Display the hero statistics, the rat statistics,the rat king statistics
rat_stat = {'min':1,'max':3,'defence':1,'hp':10}                
ratking_stat = {'min':6,'max':10,'defence':5,'hp':25}
ranking = {}                                                    #Empty dictionary for recording all the player name and the number of days taken by the player to win the game
gold = 0                                                        #Defined the gold
 
def display_main_text():                                                 #Display the main text using the for loop
    for n in range (len(main_text)):
        print('{:d}) {:s}'.format(n+1,main_text[n]))

def display_town_text():                                                 #Display the town text using the for loop
    for a in range (len(town_text)):
        print('{:d}) {:s}'.format(a+1,town_text[a]))

def display_world_map(world_map):                                        #Display the world map.H denotes the hero.T denotes the town. K denotes the Rat King.
    for i in range (len(world_map)):
        print('+---+---+---+---+---+---+---+---+')                       #Display the hero when printing out the world map
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

def display_fight_text():                                                #Display the fight text using the for loop
    for b in range (len(fight_text)):
        print('{:d}) {:s}'.format(b+1,fight_text[b]))

def display_open_text():                                                 #Display the open text using the for loop
    for c in range (len(open_text)):
        print('{:d}) {:s}'.format(c+1,open_text[c]))

def save_game():                                                         #Saving the game
    file = open('saved.txt','w')                                         #Open the file
    file.write (str(position[0]) + ',')                                  #Using the write mode create a new text file to store the hero position,
    file.write (str(position[1]) + ',')                                  #hero statistics and the number of days taken
    for x in hero_stat:
        file.write (str(hero_stat[x]) + ',')
    file.write (str(day) + ',')
    file.write (str(gold))
    file.close()                                                         #Close the file

def resume_game():                                                       #Resume the game
    global day
    global gold                                                          #global value
    file = open('saved.txt','r')                                         #Open the file and use the read mode to read the file
    line = file.readline()
    data = line.split (',')
    position [0] = int(data[0])                                          #Redefine the variables,values to resume the game
    position [1] = int(data[1])
    hero_stat['min'] = int(data[2])
    hero_stat['max'] = int(data[3])
    hero_stat['defence'] = int(data[4])
    hero_stat['hp'] = int(data[5])
    hero_stat['orb'] = data[6]
    day = int(data[7])
    gold = int(data[8])
    if hero_stat['orb'] == 'True':                                       #Check if the player found the Orb of Power in the last game
        hero_stat['orb'] = True
    else:
        hero_stat['orb'] = False
    file.close()                                                         #Close the file

def movement(move):                                                      #This function allows the player to move on the world map
    global day                                                           #global value
    while move != 'W' and move != 'A' and move != 'S' and move != 'D':   #If the player input an invalid instruction,the player can enter another command
        move = input('Invalid input, please enter another command: ')
        move = move.upper()
    if move == 'W':                                                      
        position[0] -= 1
        day += 1
        rat_stat['hp'] = 10                                              #If the player move, the hp of the rat will restore as 10
        if position[0] < 0:
            position[0] = 0
            day -= 1
            print('You cannot step out of the map.')                     #The player cannot step out of the map
    elif move == 'A':
        position[1] -= 1
        day += 1
        rat_stat['hp'] = 10                                              #If the player move, the hp of the rat will restore as 10
        if position[1] < 0:
            position[1] = 0
            day -= 1
            print('You cannot step out of the map.')                     #The player cannot step out of the map
    elif move == 'S':    
        position[0] += 1
        day += 1
        rat_stat['hp'] = 10                                              #If the player move, the hp of the rat will restore as 10
        if position[0] >= len(world_map):
            position[0] = 7
            day -= 1
            print('You cannot step out of the map.')                     #The player cannot step out of the map
    else:
        position[1] += 1
        day += 1
        rat_stat['hp'] = 10                                              #If the player move, the hp of the rat will restore as 10
        if position[1] >= len(world_map[0]):
            position[1] = 7
            day -= 1
            print('You cannot step out of the map.')                     #The player cannot step out of the map

def sense_orb():                                                         #This function shows how to sense the orb of power
    global day                                                           #global value
    if rat_stat['hp'] <= 0 and hero_stat['orb'] == False:                #If the rat is dead and the player haven't find the orb of power, 
        day+=1                                                           #using the hero position and orb position to find the directions of the orb
        if position[0] == orb_position[0]:                               #This process takes one day
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
                hero_stat['min'] = hero_stat['min'] + 5                                   #Once the player find the orb of power,update the hero statistic
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
    elif rat_stat['hp'] > 0:                                                              #If the player does not defeat the rat or the player run and hide, 
        print('You cannot sense the Orb of Power.')                                       #the player cannot sense the orb
    if hero_stat['orb'] == True:                                                          #If the player have found the orb of power, it will diaplay 
        print('You have gained the Orb of Power.')                                        #that 'You have gained the Orb of Power'

def display_town_menu(choice1):                                                           #Display town menu
    global gameover                                                                       #global values
    global day
    global gold
    while choice1 != '1' and choice1 != '2' and choice1 != '3' and choice1 != '4' and choice1 != '5' and choice1 != '6' and choice1 != '7':
        choice1 = input('Please enter the valid instruction:')                            #If the player input an invalid instruction,the player can enter another command
    if choice1 == '1':                                                                    #If the player chooses "View Character"
        print('{:>8s}\n  Damage: {:d}-{:d}\n Defence: {:d}\n      HP: {:d}'\
              .format(player_name,hero_stat['min'],hero_stat['max'],hero_stat['defence'],hero_stat['hp']))
        if hero_stat['orb'] == True :                                                     #If the player have found the orb of power, it will diaplay
            print('You are holding the Orb of Power.')                                    #that 'You are holding the Orb of Power'
    elif choice1 == '2':                                                                  #If the player chooses "View Map"
        display_world_map(world_map)                                                      #Move to the display_world_map(world_map) function
    elif choice1 == '3':                                                                  #If the player chooses "Move"
        display_world_map(world_map)                                                      #Move to the movement(move) function
        print('W = up; A = left; S = down; D = right')
        move = input('Your move: ')
        move = move.upper()                                                               #Not case sensitive
        movement(move)
        display_world_map(world_map)                                                      #After the movement, display the world map again
    elif choice1 == '4':                                                                  #If the player chooses "Rest"
        hero_stat['hp']=20                                                                #The hp of hero restore as 20
        day+=1                                                                            #This process takes one day
        print('You are fully healed.\n')
    elif choice1 == '5':                                                                          #If the player chooses "Shop"
        print('Welcome to shop ! You can buy items in the shop. Only two things are sold here.')  #The player can buy only two things here
        print('1) Healing potion\t10 Gold coins\n2) Potion of strength\t15 Gold coins')           #One is healing potion, which helps the player to increase
        shop_option = input ('Enter 1 or 2 to buy the Potion, or enter anything to return : ')    #its hp by 3
        if shop_option == '1':                                                                    #One is potion of strength,  which helps the player to
            if gold >= 10:                                                                        #increase its attack by 5
                gold = gold - 10                                                                  #If the player wants to buy, check if the player has enough
                print('You have bought the healing potion. You are fully healed.')                #gold coins
                hero_stat['hp'] = 23
            elif gold < 10:
                print("You don't have enough gold coin to buy.")
        elif shop_option == '2':
            if gold >= 15:
                gold = gold - 15
                print('You have bought the potion of strength. Your attack increases by 5!')
                hero_stat['min'] = hero_stat['min'] + 5
                hero_stat['max'] = hero_stat['max'] + 5
            elif gold < 15:
                print("You don't have enough gold coin to buy.")                                                                          #The player can enter anything to return the start_game() function
                
    elif choice1 == '6':                                                                          #If the player chooses "Save Game"
        save_game()                                                                               #Move to the save_game() function to save the game
        print('Game saved.\n')
    else:
        gameover = True                                                                           #If the player chooses "Exit Game"
        exit()                                                                                    #The while loop stops. The player may close the game

def display_outdoor_menu (choice3):                                                                         #Display outdoor menu
    global gameover                                                                                         #global value
    while choice3 != '1' and choice3 != '2' and choice3 != '3' and choice3 != '4' and choice3 != '5' :      #If the player input an invalid instruction,the player can enter another command
        choice3 = input('Please enter the valid instruction:')
    if choice3 == '1':                                                                                      #If the player chooses "View Character"
        print('{:>8s}\n  Damage: {:d}-{:d}\n Defence: {:d}\n      HP: {:d}'\
              .format(player_name,hero_stat['min'],hero_stat['max'],hero_stat['defence'],hero_stat['hp']))  
    elif choice3 == '2':                                                                                    #If the player chooses "View Map"
        display_world_map(world_map)                                                                        #Move to the display_world_map(world_map) function
    elif choice3 == '3':                                                                                    #If the player chooses "Move"
        display_world_map(world_map)                                                                        #Move to the movement(move) function
        print('W = up; A = left; S = down; D = right')
        move = input('Your move: ')
        move = move.upper()                                                                                 #Not case sensitive
        movement(move)
        display_world_map(world_map)                                                                        #After the movement, display the world map again
    elif choice3 == '4':                                                                                    #If the player chooses "Sense Orb"
        sense_orb()                                                                                         #Move to sense_orb() function
    else:                                                                                                   #If the player chooses "Exit Game"
        gameover = True                                                                                     #The while loop stops
        exit()                                                                                              #The player may close the game
        
def display_combat_menu(choice2):                                                                           #Display combat menu
    global gameover                                                                                         #global values
    global gold
    global drop
    while choice2 != '1' and choice2 != '2':                                                                #If the player input an invalid instruction,the player can enter another command
        choice2 = input('Please enter the valid instruction:')
    if choice2 == '1':                                                                                      #Choose "Attack"
        if hero_damage <= rat_stat['defence']:                                                              #damage minus the defence at first, and then minus the hp
            print('The Rat block the attack!')                                                              #If the damage is less than or equals to defence,there will be no damage 
        else:
            print('You deal {:d} damage to the Rat'.format(hero_damage-rat_stat['defence']))
            rat_stat['hp'] = rat_stat['hp'] + rat_stat['defence'] - hero_damage
        if rat_damage <= hero_stat['defence'] :
            print('You block the attack!')
        else:
            print('Ouch! The Rat hit you for {:d} damage!'.format(rat_damage-hero_stat['defence']))
            hero_stat['hp'] = hero_stat['hp'] + hero_stat['defence'] - rat_damage
        print('You have {:d} HP left.'.format(hero_stat['hp']))
        if rat_stat['hp'] <= 0 and hero_stat['hp'] > 0:                                                     #If the player is alive(hero hp>0) and the rat is dead(rat hp<=0),
            print('The Rat is dead! You are victorious!')                                                   #The player wins
            print('The Rat drops {:d} gold coins.'.format(drop))                                            #Pick up the randomly droped gold coins to buy potion in town
            gold += drop
            display_open_text()                                                                             #Display open text
            choice3 = input('Enter choice:')
            print()
            display_outdoor_menu (choice3)                                                                  #Move to display_open_text() function
                
        elif hero_stat['hp'] <= 0:                                                                          #If the hp of the hero <=0, the hero is dead
            print('You lose, game is over.')                                                                #Game Over. The while loop stops.
            gameover = True
    else:
        print('You run and hide.')                                                                          #Choose "Run"
        rat_stat['hp'] = 10                                                                                 #The hp of the rat restores as 10
        display_open_text()                                                                                 #Display open text
        choice3 = input('Enter choice:')
        print()
        display_outdoor_menu (choice3)                                                                      #Move to display_outdoor_menu (choice3) function

def display_ratking_combat_menu(choice4):                                                                   #Similar to the display_combat_menu(choice2) function
    global gameover                                                                                         #global values
    global day
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
                save_leaderboard ()                                                                #After the player win, days and player name record in file
                gameover = True                                                                    #The while loop stops.
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

def save_leaderboard ():                                                                           #Save the number of days taken by the player to win the game and player name in file
    global day                                                                                     #global values
    global player_name
    if player_name in ranking and day < ranking[player_name]:                                      #If there is a same player in the ranking dictionary,choosing the one that
        ranking[player_name] = day                                                                 #taken less day to win the game
    elif player_name not in ranking:                                                               #If there is no same player in the ranking dictionary,adding the key and values to the dictionary directly
        ranking[player_name] = day
    file = open('leaderboard.txt','w')                                                             #Using the write mode to create a new text file
    for z in ranking:                                                                              #Put all the keys and values from dictionary into the text file
        file.write (str(z) + ':' + str(ranking[z] + '\n'))
    file.close()                                                                                   #Close the file
    

def display_leaderboard ():                                                                        #Read the file and display the leaderboard
    global day                                                                                     #global values
    global player_name
    file = open('leaderboard.txt','r')
    for line in file:
        line = line.strip()
        data = line.split (':')
        ranking[data[0]] = int(data[1])                                                            #Read the file and add/update the keys and values to the dictionary
    print('Leaderboard:')
    print('Top 5     Player Name     Days')
    sort_orders = sorted(ranking.items(), key=lambda x: x[1])                                      #Sort the days in ascending order
    if len(ranking) >= 5:                                                                          #If leaderboard have >=5 players,display the 5 top ranking players of Ratventure 
        for y in range(0,5):
            print('  {:d}) {:^18s} {:^6d}'.format(y+1, sort_orders[y][0], sort_orders[y][1]))
    else:
        for y in range(0,len(ranking)):                                                            #If leaderboard do not have 5 players,display as many players as there are 
            print('  {:d}) {:^18s} {:^6d}'.format(y+1, sort_orders[y][0], sort_orders[y][1]))

def start_game():                                                                                  #Main function to start the game                                                                        
    global hero_damage                                                                             #global values
    global rat_damage
    global ratking_damage
    global drop
    while not (gameover):                                                                          #Use while loop to repeat the game process
        hero_damage = random.randint(2,4)                                                          #Randomly selected the damage of the hero, rat and rat king
        rat_damage = random.randint(1,3)
        ratking_damage = random.randint(6,10)
        drop = random.randint(0,5)                                                                 #Randomly selected the how many gold coins the opponent may drop
        if world_map[position[0]][position[1]] == 'T':                                             #In Town
            print('Day {:d}: You are in a town.'.format(day))
            display_town_text()                                                                    #Display town text
            choice1 = input('Enter choice:')
            print()
            display_town_menu(choice1)                                                             #Move to the display_town_menu(choice1) function
            
        elif world_map[position[0]][position[1]] == ' ':                                           #In Open Space
            print('Day {:d}: You are out in the open.'.format(day))
            if rat_stat['hp'] > 0:                                                                 #Encounter the rat
                print('Encounter! - Rat')
                print('Damage: {:d}-{:d}\n Defence:  {:d}\n      HP:  {:d}'\
                      .format(rat_stat['min'],rat_stat['max'],rat_stat['defence'],rat_stat['hp']))
                display_fight_text()                                                               #Display fight text
                choice2 = input('Enter choice:')
                print()
                display_combat_menu(choice2)                                                       #Move to display_combat_menu(choice2) function
                    
            elif rat_stat['hp'] <= 0:                                                              #If the rat is dead, display open text
                display_open_text()
                choice3 = input('Enter choice:')
                print()
                display_outdoor_menu (choice3)                                                     #Move to display_outdoor_menu (choice3) function 
                
        elif world_map[position[0]][position[1]] == 'K':                                           #Encounter the Rat King
            print('Day {:d}: You see the Rat King.'.format(day))
            print('Encounter! - Rat King')
            print('Damage: {:d}-{:d}\n Defence:  {:d}\n      HP:  {:d}'\
                  .format(ratking_stat['min'],ratking_stat['max'],ratking_stat['defence'],ratking_stat['hp']))
            display_fight_text()                                                                   #Display fight text
            choice4 = input('Enter choice:')
            print()
            display_ratking_combat_menu(choice4)                                                   #Move to display_ratking_combat_menu(choice4) function

display_main_text()                                                                                #Display Main text
option = input('Enter choice:')
print()
while option != '1' and option != '2' and option != '3' and option != '4' :                        #If the player input an invalid instruction,the player can enter another command
    option = input('Please enter the valid instruction:')
if option == '1':                                                                                  #"New Game" 
    start_game()                                                                                   #start_game() function
             
elif option == '2':                                                                                #"Resume Game"
    resume_game()                                                                                  #resume_game() function and start_game() function
    start_game() 

elif option == '3' :                                                                               #"View Leaderboard"
    display_leaderboard ()                                                                         #display_leaderboard () function
    display_main_text()                                                                            #Display Main text
    option = input('Enter choice:')                                                                #Repeated above process
    while option != '1' and option != '2' and option != '3' and option != '4' :
        option = input('Please enter the valid instruction:')
    if option == '1':
        start_game()
    elif option == '2':
        resume_game()
        start_game()
    else:
        exit()

else:                                                                                              #"Exit Game"
    exit()                                                                                         #Close the game

