clc
clear
close all
load  Adventure.mat;
warning('off','all');
%% Setting
World{1,1} = Player;
World{7,8} = Sword;
World{10,5} = Shield;
World{6,9} = Health;
World{3,3} = Health;
World{2,8} = Health;
World{8,9} = Health;
World{8,3} = Health;
World{5,5} = Health;
World{10,10} = Door;

playerX = 1;
playerY = 1;
playerXtmp=1;
playerYtmp=1;

imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:}]);

playerLv=1;
playerExp=0;
playerLv1MaxExp=20;
playerLv2MaxExp=50;
playerLv3MaxExp=100;
playerLv4MaxExp=200;
playerLv5MaxExp=500;

playerHp= 50;
playerMaxHp = 50;
playerAtk=5;
playerDef=2;
playerMov=1;

sword = 0;
shield = 0;
boot = 0;

swordguardHp = 50;
swordguardMaxHp = 50;
swordguardAtk = 8;
swordguardDef = 4;

bossHp = 100;
bossMaxHp=100;
bossAtk = 15;
bossDef = 7;

shieldguardHp = 75;
shieldguardMaxHp =75;
shieldguardAtk = 6;
shieldguardDef = 6;

level123EnemyMaxHp = 20;
level123EnemyHp =20;
level123EnemyAtk = 5;
level123EnemyDef = 2;

level456EnemyMaxHp = 35;
level456EnemyHp=35;
level456EnemyAtk = 8;
level456EnemyDef = 5;

Day = 1;
%% Action
while (playerX~=10|playerY~=10)
    %% Stats show
    playerXtmp=playerX;
    playerYtmp=playerY;
    fprintf('PLAYER STATS')
    fprintf('\nPlayer LV : %i',playerLv);
    if playerLv==1
        fprintf('\nPlayer EXP: %i/%i',playerExp,playerLv1MaxExp);
    elseif playerLv==2
        fprintf('\nPlayer EXP: %i/%i',playerExp,playerLv2MaxExp);
    elseif playerLv==3
        fprintf('\nPlayer EXP: %i/%i',playerExp,playerLv3MaxExp);
    elseif playerLv==4
        fprintf('\nPlayer EXP: %i/%i',playerExp,playerLv4MaxExp);
    elseif playerLv==5
        fprintf('\nPlayer EXP: %i/%i',playerExp,playerLv5MaxExp);
    elseif playerLv==6
        fprintf('\nPlayer EXP: MAX')
    end 
    fprintf('\nPlayer HP : %i/%i',playerHp,playerMaxHp);
    fprintf('\nPlayer ATK: %i',playerAtk);
    fprintf('\nPlayer DEF: %i',playerDef);
    fprintf('\nPlayer MOV: %i',playerMov);
    if (sword == 1&shield == 1&boot==1)
        fprintf('\nPlayer Equiment: Sword Shield Boot\n')
    elseif(sword ==1&shield==1&boot==0)
        fprintf('\nPlayer Equiment: Sword Shield\n')
    elseif(sword ==1&shield==0&boot==1)
        fprintf('\nPlayer Equiment: Sword Boot\n')
    elseif(sword ==0&shield==1&boot==1)
        fprintf('\nPlayer Equiment: Shield Boot\n')
    elseif(sword ==1&shield==0&boot==0)
        fprintf('\nPlayer Equiment: Sword\n')
    elseif(sword ==0&shield==1&boot==0)
        fprintf('\nPlayer Equiment: Shield\n')
    elseif(sword ==0&shield==0&boot==1)
        fprintf('\nPlayer Equiment: Boot\n')
    elseif(sword ==0&shield==0&boot==0)
        fprintf('\nPlayer Equiment: \n')
    end
    fprintf('\nDay:%i',Day);
    %% Player Move
    Direction = input('\nEnter the direction you want to move(w,e,s,n or press Enter for stay): ','s');
    if Direction == 'w'
        playerY=playerY-1;
    elseif Direction == 'e'
        playerY=playerY+1;
    elseif Direction == 's'
        playerX=playerX+1;
    elseif Direction == 'n'
        playerX=playerX-1;
    end
    fprintf('\n')
    checkdirection = Direction ~='w'&Direction ~='e'&Direction ~='n'&Direction ~='s';
    checkborder = (playerX==0|playerX==11|playerY==0|playerY==11);
    while (checkdirection|checkborder)
        if(playerX==0||playerX==11||playerY==0||playerY==11)
        fprintf('You can not move out of the border!\n');
        end
        playerX=playerXtmp;
        playerY=playerYtmp;
        Direction = input('\nPlease correctly enter the direction you want to move(w,e,s,n): ','s');
        fprintf('\n')
    if Direction == 'w'
        playerY=playerY-1;
    elseif Direction == 'e'
        playerY=playerY+1;
    elseif Direction == 's'
        playerX=playerX+1;
    elseif Direction == 'n'
        playerX=playerX-1;
    end
    checkdirection = Direction ~='w'&Direction ~='e'&Direction ~='n'&Direction ~='s';
    checkborder = (playerX==0||playerX==11||playerY==0||playerY==11);
    end
    World{playerXtmp,playerYtmp}= Blank;
    World{playerX,playerY}=Player;
    if (playerX==7&playerY==8&sword~=1)
        EncounterSword=1;
    end
    if (playerX==10&playerY==5&shield~=1)
        EncounterShield=1;
    end

    
    imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:}]);    
%% Encounter sword
if (playerX==7&playerY==8&EncounterSword==1)
    fprintf('You encounter a monster who guard the treasure!\n\n')
    fprintf('Battle Start\n')
    turn = 1;
    MonsterHp=swordguardHp;
    MonsterDef=swordguardDef;
    MonsterAtk = swordguardAtk;
    MonsterMaxHp = swordguardMaxHp;
    while (MonsterHp>0)
        fprintf('\nTurn %i\n',turn')
        fprintf('Determine your action(Attack(a) Defence(d) Run(r) NoAction(Press Enter directly) and enter the character(or press Enter)\n')
        Action = input('Action: ','s');
        OriginalEnemyHp = MonsterHp;
        OriginalPlayerHp = playerHp;
        checkAction = Action ~='a'&Action~='d'&Action~='r';
        while checkAction
            fprintf('Please correctly enter your action(a for attack,d for defence,r for run and press enter directly for no Action)!\n')
            Action = input('Action: ','s');
            checkAction = (Action ~='a'&Action~='d'&Action~='r');
        end
        if Action == 'a'
            fprintf('\nYou choose Attack!\n')
        elseif Action =='d'
            fprintf('\nYou choose Defence!\n')
        elseif Action =='r'
            fprintf('\nYou choose Run!\n')
        else
            fprintf('\nYou choose No Action!\n')
        end
    RandomValueForEnemyAction = randi([1 3],1,1);
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        fprintf('Enemy choose Attack!\n\n')
    elseif(RandomValueForEnemyAction==3)
        fprintf('Enemy choose Defence!\n\n');
    end
    if Action == 'r'
        fprintf('You successfully run away!\n')
        World{playerXtmp,playerYtmp}= Player;
        playerX=playerXtmp;
        playerY=playerYtmp;
        World{7,8}=Sword;
        imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:}]);    
        break;
    end
    if Action == 'a'
       RandomValueForAttack = randi([-20 25],1,1)/100;
       if (RandomValueForAttack<= -0.1)
       fprintf('You have a poor attack :/\n');
       elseif(RandomValueForAttack>-0.1&RandomValueForAttack<=0.15)
       fprintf('You have a normal attack\n');
       elseif(RandomValueForAttack>0.15)
       fprintf('You have a great attack lol!\n');
       end
       damage = playerAtk+RandomValueForAttack*playerAtk;
       
       if (RandomValueForEnemyAction==3)
           RandomValueForEnemyDefence=randi([-10 10],1,1)/100;
           if (RandomValueForEnemyDefence <= -0.3)
               fprintf('Enemy has a poor defence\n')
           elseif (RandomValueForEnemyDefence >-0.3)&(RandomValueForEnemyDefence<0.3)
               fprintf('Enemy has a normal defence\n')
           elseif (RandomValueForEnemyDefence >=0.3)
               fprintf('Enemy has a great defence\n')
           end
           lastdamage = damage - (1.5*MonsterDef+RandomValueForEnemyDefence*MonsterDef);
               
       else 
           lastdamage = damage - MonsterDef;
       end
       if(lastdamage<=0)
           lastdamage=0;
       end
       MonsterHp = MonsterHp-lastdamage;
       MonsterHp = round(MonsterHp);
    end
    if(MonsterHp>0&Action == 'a')
        fprintf('EnemyHp: %i/%i -> %i/%i\n\n',OriginalEnemyHp,MonsterMaxHp,MonsterHp,MonsterMaxHp);
    elseif(MonsterHp<=0)
        fprintf('EnemyHp: %i/%i -> 0/%i\n\n', OriginalEnemyHp,MonsterMaxHp,MonsterMaxHp);
        fprintf('Enemy dies\n')
    end
    if(MonsterHp<=0)
        fprintf('You gain 50 exp!\n')
        fprintf('You find a sword, ATK+5!\n\n')
        playerExp=playerExp+50;
        sword=1;
        playerAtk=playerAtk+5;
        EncounterSword=0;
        break;
    end
    
    % Enemy turn
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        RandomValueForEnemyAttack = randi([-20 25],1,1)/100;
       if (RandomValueForEnemyAttack<= -0.1)
       fprintf('Enemy has a poor attack\n');
       elseif(RandomValueForEnemyAttack>-0.1&RandomValueForEnemyAttack<=0.15)
       fprintf('Enemy has a normal attack\n');
       elseif(RandomValueForEnemyAttack>0.15)
       fprintf('Enemy has a great attack\n');
       end
       Enemydamage = MonsterAtk+RandomValueForEnemyAttack*MonsterAtk;
       
       if (Action == 'd')
           RandomValueForDefence=randi([-10 10],1,1)/100;
           if (RandomValueForDefence <= -0.3)
               fprintf('You have a poor defence\n')
           elseif (RandomValueForDefence >-0.3)&(RandomValueForDefence<0.3)
               fprintf('You have a normal defence\n')
           elseif (RandomValueForDefence >=0.3)
               fprintf('You have a great defence\n')
           end
           lastenemydamage = Enemydamage - (1.5*playerDef+RandomValueForDefence*playerDef);
               
       else 
           lastenemydamage = Enemydamage - playerDef;
       end
       if(lastenemydamage<=0)
           lastenemydamage=0;
       end
       playerHp = playerHp-lastenemydamage;
       playerHp = round(playerHp);
    end
    if(playerHp>0&(RandomValueForEnemyAction==1||RandomValueForEnemyAction==2))
        fprintf('PlayerHp: %i/%i -> %i/%i\n\n',OriginalPlayerHp,playerMaxHp,playerHp,playerMaxHp);
    elseif(playerHp<=0)
        fprintf('PlayerHp: %i/%i -> 0/%i\n\n', OriginalPlayerHp,playerMaxHp,playerMaxHp);
        fprintf('You Died\n');
    end
    if(playerHp<=0)
        break;
    end
    turn = turn+1;
    end      
end 
%% Check Hp
if(playerHp<=0)
    fprintf('Game Over\n');
    break;
end
%% Level check here
if (playerLv==1&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 10\n');
    fprintf('Def + 5\n');
    fprintf('MaxHp + 50\n\n');
    playerAtk = playerAtk+10;
    playerDef = playerDef+5;
    playerMaxHp = playerMaxHp + 50;
    playerHp = playerHp + 50;
elseif(playerLv==1&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 8\n');
    fprintf('Def + 4\n');
    fprintf('MaxHp + 40\n\n');
    playerAtk = playerAtk+8;
    playerDef = playerDef+4;
    playerMaxHp = playerMaxHp + 40;
    playerHp = playerHp + 40;
elseif(playerLv==1&playerExp>=playerLv3MaxExp)
    playerLv=4;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 6\n');
    fprintf('Def + 3\n');
    fprintf('MaxHp + 30\n\n');
    playerAtk = playerAtk+6;
    playerDef = playerDef+3;
    playerMaxHp = playerMaxHp + 30;
    playerHp = playerHp + 30;
elseif(playerLv==1&playerExp>=playerLv2MaxExp)
    playerLv=3;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==1&playerExp>=playerLv1MaxExp)
    playerLv=2;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==2&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 8\n');
    fprintf('Def + 4\n');
    fprintf('MaxHp + 40\n\n');
    playerAtk = playerAtk+8;
    playerDef = playerDef+4;
    playerMaxHp = playerMaxHp + 40;
    playerHp = playerHp + 40;
elseif(playerLv==2&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 6\n');
    fprintf('Def + 3\n');
    fprintf('MaxHp + 30\n\n');
    playerAtk = playerAtk+6;
    playerDef = playerDef+3;
    playerMaxHp = playerMaxHp + 30;
    playerHp = playerHp + 30;
elseif(playerLv==2&playerExp>=playerLv3MaxExp)
    playerLv=4;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==2&playerExp>=playerLv2MaxExp)
    playerLv=3;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==3&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 6\n');
    fprintf('Def + 3\n');
    fprintf('MaxHp + 30\n\n');
    playerAtk = playerAtk+6;
    playerDef = playerDef+3;
    playerMaxHp = playerMaxHp + 30;
    playerHp = playerHp + 30;
elseif(playerLv==3&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==3&playerExp>=playerLv3MaxExp)
    playerLv=4;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==4&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==4&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==5&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
end
    
%% Encounter Shield
if (playerX==10&playerY==5&EncounterShield==1)
    fprintf('You encounter a monster who guard the treasure!\n\n')
    fprintf('Battle Start\n')
    turn = 1;
    MonsterHp=shieldguardHp;
    MonsterDef=shieldguardDef;
    MonsterAtk = shieldguardAtk;
    MonsterMaxHp = shieldguardMaxHp;
    while (MonsterHp>0)
        fprintf('\nTurn %i\n',turn')
        fprintf('Determine your action(Attack(a) Defence(d) Run(r) NoAction(Press Enter directly) and enter the character(or press Enter)\n')
        Action = input('Action: ','s');
        OriginalEnemyHp = MonsterHp;
        OriginalPlayerHp = playerHp;
        checkAction = Action ~='a'&Action~='d'&Action~='r';
        while checkAction
            fprintf('Please correctly enter your action(a for attack,d for defence,r for run and press enter directly for no Action)!\n')
            Action = input('Action: ','s');
            checkAction = Action ~='a'&Action~='d'&Action~='r';
        end
        if Action == 'a'
            fprintf('\nYou choose Attack!\n')
        elseif Action =='d'
            fprintf('\nYou choose Defence!\n')
        elseif Action =='r'
            fprintf('\nYou choose Run!\n')
        else
            fprintf('\nYou choose No Action!\n')
        end
    RandomValueForEnemyAction = randi([1 3],1,1);
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        fprintf('Enemy choose Attack!\n\n')
    elseif(RandomValueForEnemyAction==3)
        fprintf('Enemy choose Defence!\n\n');
    end
    if Action == 'r'
        fprintf('You successfully run away!\n')
        World{playerXtmp,playerYtmp}= Player;
        playerX=playerXtmp;
        playerY=playerYtmp;
        World{10,5}=Shield;
        imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:}]);    
        break;
    end
    if Action == 'a'
       RandomValueForAttack = randi([-20 25],1,1)/100;
       if (RandomValueForAttack<= -0.1)
       fprintf('You have a poor attack :/\n');
       elseif(RandomValueForAttack>-0.1&RandomValueForAttack<=0.15)
       fprintf('You have a normal attack\n');
       elseif(RandomValueForAttack>0.15)
       fprintf('You have a great attack lol!\n');
       end
       damage = playerAtk+RandomValueForAttack*playerAtk;
       
       if (RandomValueForEnemyAction==3)
           RandomValueForEnemyDefence=randi([-10 10],1,1)/100;
           if (RandomValueForEnemyDefence <= -0.3)
               fprintf('Enemy has a poor defence\n')
           elseif (RandomValueForEnemyDefence >-0.3)&(RandomValueForEnemyDefence<0.3)
               fprintf('Enemy has a normal defence\n')
           elseif (RandomValueForEnemyDefence >=0.3)
               fprintf('Enemy has a great defence\n')
           end
           lastdamage = damage - (1.5*MonsterDef+RandomValueForEnemyDefence*MonsterDef);
               
       else 
           lastdamage = damage - MonsterDef;
       end
       if(lastdamage<=0)
           lastdamage=0;
       end
       MonsterHp = MonsterHp-lastdamage;
       MonsterHp = round(MonsterHp);
    end
    if(MonsterHp>0&Action == 'a')
        fprintf('EnemyHp: %i/%i -> %i/%i\n\n',OriginalEnemyHp,MonsterMaxHp,MonsterHp,MonsterMaxHp);
    elseif(MonsterHp<=0)
        fprintf('EnemyHp: %i/%i -> 0/%i\n\n', OriginalEnemyHp,MonsterMaxHp,MonsterMaxHp);
        fprintf('Enemy dies\n')
    end
    if(MonsterHp<=0)
        fprintf('You gain 50 exp!\n')
        fprintf('You find a shield, Def+3!\n\n')
        playerExp=playerExp+50;
        shield=1;
        playerDef=playerDef+3;
        EncounterShield=0;
        break;
    end
    
    % Enemy turn
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        RandomValueForEnemyAttack = randi([-20 25],1,1)/100;
       if (RandomValueForEnemyAttack<= -0.1)
       fprintf('Enemy has a poor attack\n');
       elseif(RandomValueForEnemyAttack>-0.1&RandomValueForEnemyAttack<=0.15)
       fprintf('Enemy has a normal attack\n');
       elseif(RandomValueForEnemyAttack>0.15)
       fprintf('Enemy has a great attack\n');
       end
       Enemydamage = MonsterAtk+RandomValueForEnemyAttack*MonsterAtk;
       
       if (Action == 'd')
           RandomValueForDefence=randi([-10 10],1,1)/100;
           if (RandomValueForDefence <= -0.3)
               fprintf('You have a poor defence\n')
           elseif (RandomValueForDefence >-0.3)&(RandomValueForDefence<0.3)
               fprintf('You have a normal defence\n')
           elseif (RandomValueForDefence >=0.3)
               fprintf('You have a great defence\n')
           end
           lastenemydamage = Enemydamage - (1.5*playerDef+RandomValueForDefence*playerDef);
               
       else 
           lastenemydamage = Enemydamage - playerDef;
       end
       if(lastenemydamage<=0)
           lastenemydamage=0;
       end
       playerHp = playerHp-lastenemydamage;
       playerHp = round(playerHp);
    end
    if(playerHp>0&(RandomValueForEnemyAction==1||RandomValueForEnemyAction==2))
        fprintf('PlayerHp: %i/%i -> %i/%i\n\n',OriginalPlayerHp,playerMaxHp,playerHp,playerMaxHp);
    elseif(playerHp<=0)
        fprintf('PlayerHp: %i/%i -> 0/%i\n\n', OriginalPlayerHp,playerMaxHp,playerMaxHp);
        fprintf('You Died\n');
    end
    if(playerHp<=0)
        break;
    end
    turn = turn+1;
    end      
end
%% Check Hp
if(playerHp<=0)
    fprintf('Game Over\n');
    break;
end
%% Level check here
if (playerLv==1&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 10\n');
    fprintf('Def + 5\n');
    fprintf('MaxHp + 50\n\n');
    playerAtk = playerAtk+10;
    playerDef = playerDef+5;
    playerMaxHp = playerMaxHp + 50;
    playerHp = playerHp + 50;
elseif(playerLv==1&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 8\n');
    fprintf('Def + 4\n');
    fprintf('MaxHp + 40\n\n');
    playerAtk = playerAtk+8;
    playerDef = playerDef+4;
    playerMaxHp = playerMaxHp + 40;
    playerHp = playerHp + 40;
elseif(playerLv==1&playerExp>=playerLv3MaxExp)
    playerLv=4;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 6\n');
    fprintf('Def + 3\n');
    fprintf('MaxHp + 30\n\n');
    playerAtk = playerAtk+6;
    playerDef = playerDef+3;
    playerMaxHp = playerMaxHp + 30;
    playerHp = playerHp + 30;
elseif(playerLv==1&playerExp>=playerLv2MaxExp)
    playerLv=3;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==1&playerExp>=playerLv1MaxExp)
    playerLv=2;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==2&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 8\n');
    fprintf('Def + 4\n');
    fprintf('MaxHp + 40\n\n');
    playerAtk = playerAtk+8;
    playerDef = playerDef+4;
    playerMaxHp = playerMaxHp + 40;
    playerHp = playerHp + 40;
elseif(playerLv==2&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 6\n');
    fprintf('Def + 3\n');
    fprintf('MaxHp + 30\n\n');
    playerAtk = playerAtk+6;
    playerDef = playerDef+3;
    playerMaxHp = playerMaxHp + 30;
    playerHp = playerHp + 30;
elseif(playerLv==2&playerExp>=playerLv3MaxExp)
    playerLv=4;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==2&playerExp>=playerLv2MaxExp)
    playerLv=3;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==3&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 6\n');
    fprintf('Def + 3\n');
    fprintf('MaxHp + 30\n\n');
    playerAtk = playerAtk+6;
    playerDef = playerDef+3;
    playerMaxHp = playerMaxHp + 30;
    playerHp = playerHp + 30;
elseif(playerLv==3&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==3&playerExp>=playerLv3MaxExp)
    playerLv=4;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==4&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==4&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==5&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
end
if (playerX==10&playerY==10)
    fprintf('You encounter Boss who guard the Door!\n\n')
    fprintf('Battle Start\n')
    turn = 1;
    MonsterHp=bossHp;
    MonsterDef=bossDef;
    MonsterAtk = bossAtk;
    MonsterMaxHp = bossMaxHp;
    while (MonsterHp>0)
        fprintf('\nTurn %i\n',turn')
        fprintf('Determine your action(Attack(a) Defence(d) Run(r) NoAction(Press Enter directly) and enter the character(or press Enter)\n')
        Action = input('Action: ','s');
        OriginalEnemyHp = MonsterHp;
        OriginalPlayerHp = playerHp;
        checkAction = Action ~='a'&Action~='d'&Action~='r';
        while checkAction
            fprintf('Please correctly enter your action(a for attack,d for defence,r for run and press enter directly for no Action)!\n')
            Action = input('Action: ','s');
            checkAction = Action ~='a'&Action~='d'&Action~='r';
        end
        if Action == 'a'
            fprintf('\nYou choose Attack!\n')
        elseif Action =='d'
            fprintf('\nYou choose Defence!\n')
        elseif Action =='r'
            fprintf('\nYou choose Run!\n')
        else
            fprintf('\nYou choose No Action!\n')
        end
    RandomValueForEnemyAction = randi([1 3],1,1);
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        fprintf('Enemy choose Attack!\n\n')
    elseif(RandomValueForEnemyAction==3)
        fprintf('Enemy choose Defence!\n\n');
    end
    if Action == 'r'
        fprintf('You successfully run away!\n')
        World{playerXtmp,playerYtmp}= Player;
        playerX=playerXtmp;
        playerY=playerYtmp;
        World{10,10}=Door;
        imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:}]);    
        break;
    end
    if Action == 'a'
       RandomValueForAttack = randi([-20 25],1,1)/100;
       if (RandomValueForAttack<= -0.1)
       fprintf('You have a poor attack :/\n');
       elseif(RandomValueForAttack>-0.1&RandomValueForAttack<=0.15)
       fprintf('You have a normal attack\n');
       elseif(RandomValueForAttack>0.15)
       fprintf('You have a great attack lol!\n');
       end
       damage = playerAtk+RandomValueForAttack*playerAtk;
       
       if (RandomValueForEnemyAction==3)
           RandomValueForEnemyDefence=randi([-10 10],1,1)/100;
           if (RandomValueForEnemyDefence <= -0.3)
               fprintf('Enemy has a poor defence\n')
           elseif (RandomValueForEnemyDefence >-0.3)&(RandomValueForEnemyDefence<0.3)
               fprintf('Enemy has a normal defence\n')
           elseif (RandomValueForEnemyDefence >=0.3)
               fprintf('Enemy has a great defence\n')
           end
           lastdamage = damage - (1.5*MonsterDef+RandomValueForEnemyDefence*MonsterDef);
               
       else 
           lastdamage = damage - MonsterDef;
       end
       if(lastdamage<=0)
           lastdamage=0;
       end
       MonsterHp = MonsterHp-lastdamage;
       MonsterHp = round(MonsterHp);
    end
    if(MonsterHp>0&Action == 'a')
        fprintf('EnemyHp: %i/%i -> %i/%i\n\n',OriginalEnemyHp,MonsterMaxHp,MonsterHp,MonsterMaxHp);
    elseif(MonsterHp<=0)
        fprintf('EnemyHp: %i/%i -> 0/%i\n\n', OriginalEnemyHp,MonsterMaxHp,MonsterMaxHp);
        fprintf('Enemy dies\n')
    end
    if(MonsterHp<=0)
        fprintf('You beat the Boss!\n')
        fprintf('Congratulations! You successfully reach the destination!\n')
        break;
    end
    
    % Enemy turn
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        RandomValueForEnemyAttack = randi([-20 25],1,1)/100;
       if (RandomValueForEnemyAttack<= -0.1)
       fprintf('Enemy has a poor attack\n');
       elseif(RandomValueForEnemyAttack>-0.1&RandomValueForEnemyAttack<=0.15)
       fprintf('Enemy has a normal attack\n');
       elseif(RandomValueForEnemyAttack>0.15)
       fprintf('Enemy has a great attack\n');
       end
       Enemydamage = MonsterAtk+RandomValueForEnemyAttack*MonsterAtk;
       
       if (Action == 'd')
           RandomValueForDefence=randi([-10 10],1,1)/100;
           if (RandomValueForDefence <= -0.3)
               fprintf('You have a poor defence\n')
           elseif (RandomValueForDefence >-0.3)&(RandomValueForDefence<0.3)
               fprintf('You have a normal defence\n')
           elseif (RandomValueForDefence >=0.3)
               fprintf('You have a great defence\n')
           end
           lastenemydamage = Enemydamage - (1.5*playerDef+RandomValueForDefence*playerDef);
               
       else 
           lastenemydamage = Enemydamage - playerDef;
       end
       if(lastenemydamage<=0)
           lastenemydamage=0;
       end
       playerHp = playerHp-lastenemydamage;
       playerHp = round(playerHp);
    end
    if(playerHp>0&(RandomValueForEnemyAction==1||RandomValueForEnemyAction==2))
        fprintf('PlayerHp: %i/%i -> %i/%i\n\n',OriginalPlayerHp,playerMaxHp,playerHp,playerMaxHp);
    elseif(playerHp<=0)
        fprintf('PlayerHp: %i/%i -> 0/%i\n\n', OriginalPlayerHp,playerMaxHp,playerMaxHp);
        fprintf('You Died\n');
    end
    if(playerHp<=0)
        break;
    end
    turn = turn+1;
    end      
end 
%% Check Hp
if(playerHp<=0)
    fprintf('Game Over\n');
    break;
end
%% Encounter normal monster
if (playerX~=6&playerY~=9)|(playerX~=3&playerY~=3)|(playerX~=2&playerY~=8)|(playerX~=8&playerY~=9)|(playerX~=8&&playerY~=3)|(playerX~=5&playerY~=5)|(playerX~=10&playerY~=10)|(playerX~=7&playerY~=8)|(playerX~=10&playerY~=5)
    if(playerLv>=1&playerLv<=3)
        RandomValueForEncounterEnemy = randi([1 3],1,1);
        if(RandomValueForEncounterEnemy==1)
    fprintf('You encounter a monster!\n\n')
    fprintf('Battle Start\n')
    turn = 1;
    MonsterHp=level123EnemyHp;
    MonsterDef=level123EnemyDef;
    MonsterAtk = level123EnemyAtk;
    MonsterMaxHp = level123EnemyMaxHp;
    while (MonsterHp>0)
        fprintf('\nTurn %i\n',turn')
        fprintf(fid,colorizestring('red','Determine your action(Attack(a) Defence(d) Run(r) NoAction(Press Enter directly) and enter the character(or press Enter)\n<br'))
        Action = input('Action: ','s');
        OriginalEnemyHp = MonsterHp;
        OriginalPlayerHp = playerHp;
        checkAction = Action ~='a'&Action~='d'&Action~='r';
        while checkAction
            fprintf('Please correctly enter your action(a for attack,d for defence,r for run and press enter directly for no Action)!\n')
            Action = input('Action: ','s');
            checkAction = (Action ~='a'&Action~='d'&Action~='r');
        end
        if Action == 'a'
            fprintf('\nYou choose Attack!\n')
        elseif Action =='d'
            fprintf('\nYou choose Defence!\n')
        elseif Action =='r'
            fprintf('\nYou choose Run!\n')
        else
            fprintf('\nYou choose No Action!\n')
        end
    RandomValueForEnemyAction = randi([1 3],1,1);
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        fprintf('Enemy choose Attack!\n\n')
    elseif(RandomValueForEnemyAction==3)
        fprintf('Enemy choose Defence!\n\n');
    end
    if Action == 'r'
        fprintf('You successfully run away!\n')
        World{playerX,playerY}=Blank;
        World{playerXtmp,playerYtmp}= Player;
        playerX=playerXtmp;
        playerY=playerYtmp;
        imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:}]);    
        break;
    end
    if Action == 'a'
       RandomValueForAttack = randi([-20 25],1,1)/100;
       if (RandomValueForAttack<= -0.1)
       fprintf('You have a poor attack :/\n');
       elseif(RandomValueForAttack>-0.1&RandomValueForAttack<=0.15)
       fprintf('You have a normal attack\n');
       elseif(RandomValueForAttack>0.15)
       fprintf('You have a great attack lol!\n');
       end
       damage = playerAtk+RandomValueForAttack*playerAtk;
       
       if (RandomValueForEnemyAction==3)
           RandomValueForEnemyDefence=randi([-10 10],1,1)/100;
           if (RandomValueForEnemyDefence <= -0.3)
               fprintf('Enemy has a poor defence\n')
           elseif (RandomValueForEnemyDefence >-0.3)&(RandomValueForEnemyDefence<0.3)
               fprintf('Enemy has a normal defence\n')
           elseif (RandomValueForEnemyDefence >=0.3)
               fprintf('Enemy has a great defence\n')
           end
           lastdamage = damage - (1.5*MonsterDef+RandomValueForEnemyDefence*MonsterDef);
               
       else 
           lastdamage = damage - MonsterDef;
       end
       if(lastdamage<=0)
           lastdamage=0;
       end
       MonsterHp = MonsterHp-lastdamage;
       MonsterHp = round(MonsterHp);
    end
    if(MonsterHp>0&Action == 'a')
        fprintf('EnemyHp: %i/%i -> %i/%i\n\n',OriginalEnemyHp,MonsterMaxHp,MonsterHp,MonsterMaxHp);
    elseif(MonsterHp<=0)
        fprintf('EnemyHp: %i/%i -> 0/%i\n\n', OriginalEnemyHp,MonsterMaxHp,MonsterMaxHp);
        fprintf('Enemy dies\n')
    end
    if(MonsterHp<=0)
        fprintf('You gain 10 exp!\n\n')
        playerExp=playerExp+10;
        break;
    end
    
    % Enemy turn
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        RandomValueForEnemyAttack = randi([-20 25],1,1)/100;
       if (RandomValueForEnemyAttack<= -0.1)
       fprintf('Enemy has a poor attack\n');
       elseif(RandomValueForEnemyAttack>-0.1&RandomValueForEnemyAttack<=0.15)
       fprintf('Enemy has a normal attack\n');
       elseif(RandomValueForEnemyAttack>0.15)
       fprintf('Enemy has a great attack\n');
       end
       Enemydamage = MonsterAtk+RandomValueForEnemyAttack*MonsterAtk;
       
       if (Action == 'd')
           RandomValueForDefence=randi([-10 10],1,1)/100;
           if (RandomValueForDefence <= -0.3)
               fprintf('You have a poor defence\n')
           elseif (RandomValueForDefence >-0.3)&(RandomValueForDefence<0.3)
               fprintf('You have a normal defence\n')
           elseif (RandomValueForDefence >=0.3)
               fprintf('You have a great defence\n')
           end
           lastenemydamage = Enemydamage - (1.5*playerDef+RandomValueForDefence*playerDef);
               
       else 
           lastenemydamage = Enemydamage - playerDef;
       end
       if(lastenemydamage<=0)
           lastenemydamage=0;
       end
       playerHp = playerHp-lastenemydamage;
       playerHp = round(playerHp);
    end
    if(playerHp>0&(RandomValueForEnemyAction==1||RandomValueForEnemyAction==2))
        fprintf('PlayerHp: %i/%i -> %i/%i\n\n',OriginalPlayerHp,playerMaxHp,playerHp,playerMaxHp);
    elseif(playerHp<=0)
        fprintf('PlayerHp: %i/%i -> 0/%i\n\n', OriginalPlayerHp,playerMaxHp,playerMaxHp);
        fprintf('You Died\n');
    end
    if(playerHp<=0)
        break;
    end
    turn = turn+1;
    end
        end
    else
        RandomValueForEncounterEnemy = randi([1 3],1,1);
        if(RandomValueForEncounterEnemy==1)
    fprintf('You encounter a monster!\n\n')
    fprintf('Battle Start\n')
    turn = 1;
    MonsterHp=level456EnemyHp;
    MonsterDef=level456EnemyDef;
    MonsterAtk = level456EnemyAtk;
    MonsterMaxHp = level456EnemyMaxHp;
    while (MonsterHp>0)
        fprintf('\nTurn %i\n',turn')
        fprintf('Determine your action(Attack(a) Defence(d) Run(r) NoAction(Press Enter directly) and enter the character(or press Enter)\n')
        Action = input('Action: ','s');
        OriginalEnemyHp = MonsterHp;
        OriginalPlayerHp = playerHp;
        checkAction = Action ~='a'&Action~='d'&Action~='r';
        while checkAction
            fprintf('Please correctly enter your action(a for attack,d for defence,r for run and press enter directly for no Action)!\n')
            Action = input('Action: ','s');
            checkAction = (Action ~='a'&Action~='d'&Action~='r');
        end
        if Action == 'a'
            fprintf('\nYou choose Attack!\n')
        elseif Action =='d'
            fprintf('\nYou choose Defence!\n')
        elseif Action =='r'
            fprintf('\nYou choose Run!\n')
        else
            fprintf('\nYou choose No Action!\n')
        end
    RandomValueForEnemyAction = randi([1 3],1,1);
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        fprintf('Enemy choose Attack!\n\n')
    elseif(RandomValueForEnemyAction==3)
        fprintf('Enemy choose Defence!\n\n');
    end
    if Action == 'r'
        fprintf('You successfully run away!\n')
        World{playerXtmp,playerYtmp}= Player;
        World{playerXtmp,playerYtmp}= Player;
        playerX=playerXtmp;
        playerY=playerYtmp;
        imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:}]);    
        break;
    end
    if Action == 'a'
       RandomValueForAttack = randi([-20 25],1,1)/100;
       if (RandomValueForAttack<= -0.1)
       fprintf('You have a poor attack :/\n');
       elseif(RandomValueForAttack>-0.1&RandomValueForAttack<=0.15)
       fprintf('You have a normal attack\n');
       elseif(RandomValueForAttack>0.15)
       fprintf('You have a great attack lol!\n');
       end
       damage = playerAtk+RandomValueForAttack*playerAtk;
       
       if (RandomValueForEnemyAction==3)
           RandomValueForEnemyDefence=randi([-10 10],1,1)/100;
           if (RandomValueForEnemyDefence <= -0.3)
               fprintf('Enemy has a poor defence\n')
           elseif (RandomValueForEnemyDefence >-0.3)&(RandomValueForEnemyDefence<0.3)
               fprintf('Enemy has a normal defence\n')
           elseif (RandomValueForEnemyDefence >=0.3)
               fprintf('Enemy has a great defence\n')
           end
           lastdamage = damage - (1.5*MonsterDef+RandomValueForEnemyDefence*MonsterDef);
               
       else 
           lastdamage = damage - MonsterDef;
       end
       if(lastdamage<=0)
           lastdamage=0;
       end
       MonsterHp = MonsterHp-lastdamage;
       MonsterHp = round(MonsterHp);
    end
    if(MonsterHp>0&Action == 'a')
        fprintf('EnemyHp: %i/%i -> %i/%i\n\n',OriginalEnemyHp,MonsterMaxHp,MonsterHp,MonsterMaxHp);
    elseif(MonsterHp<=0)
        fprintf('EnemyHp: %i/%i -> 0/%i\n\n', OriginalEnemyHp,MonsterMaxHp,MonsterMaxHp);
        fprintf('Enemy dies\n')
    end
    if(MonsterHp<=0)
        fprintf('You gain 10 exp!\n\n')
        playerExp=playerExp+10;
        break;
    end
    
    % Enemy turn
    if (RandomValueForEnemyAction==1||RandomValueForEnemyAction==2)
        RandomValueForEnemyAttack = randi([-20 25],1,1)/100;
       if (RandomValueForEnemyAttack<= -0.1)
       fprintf('Enemy has a poor attack\n');
       elseif(RandomValueForEnemyAttack>-0.1&RandomValueForEnemyAttack<=0.15)
       fprintf('Enemy has a normal attack\n');
       elseif(RandomValueForEnemyAttack>0.15)
       fprintf('Enemy has a great attack\n');
       end
       Enemydamage = MonsterAtk+RandomValueForEnemyAttack*MonsterAtk;
       
       if (Action == 'd')
           RandomValueForDefence=randi([-10 10],1,1)/100;
           if (RandomValueForDefence <= -0.3)
               fprintf('You have a poor defence\n')
           elseif (RandomValueForDefence >-0.3)&(RandomValueForDefence<0.3)
               fprintf('You have a normal defence\n')
           elseif (RandomValueForDefence >=0.3)
               fprintf('You have a great defence\n')
           end
           lastenemydamage = Enemydamage - (1.5*playerDef+RandomValueForDefence*playerDef);
               
       else 
           lastenemydamage = Enemydamage - playerDef;
       end
       if(lastenemydamage<=0)
           lastenemydamage=0;
       end
       playerHp = playerHp-lastenemydamage;
       playerHp = round(playerHp);
    end
    if(playerHp>0&(RandomValueForEnemyAction==1||RandomValueForEnemyAction==2))
        fprintf('PlayerHp: %i/%i -> %i/%i\n\n',OriginalPlayerHp,playerMaxHp,playerHp,playerMaxHp);
    elseif(playerHp<=0)
        fprintf('PlayerHp: %i/%i -> 0/%i\n\n', OriginalPlayerHp,playerMaxHp,playerMaxHp);
        fprintf('You Died\n');
    end
    if(playerHp<=0)
        break;
    end
    turn = turn+1;
    end
        end      
    end
end
%% Check Hp
if(playerHp<=0)
    fprintf('Game Over\n');
    break;
end
%% Level check here
if (playerLv==1&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 10\n');
    fprintf('Def + 5\n');
    fprintf('MaxHp + 50\n\n');
    playerAtk = playerAtk+10;
    playerDef = playerDef+5;
    playerMaxHp = playerMaxHp + 50;
    playerHp = playerHp + 50;
elseif(playerLv==1&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 8\n');
    fprintf('Def + 4\n');
    fprintf('MaxHp + 40\n\n');
    playerAtk = playerAtk+8;
    playerDef = playerDef+4;
    playerMaxHp = playerMaxHp + 40;
    playerHp = playerHp + 40;
elseif(playerLv==1&playerExp>=playerLv3MaxExp)
    playerLv=4;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 6\n');
    fprintf('Def + 3\n');
    fprintf('MaxHp + 30\n\n');
    playerAtk = playerAtk+6;
    playerDef = playerDef+3;
    playerMaxHp = playerMaxHp + 30;
    playerHp = playerHp + 30;
elseif(playerLv==1&playerExp>=playerLv2MaxExp)
    playerLv=3;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==1&playerExp>=playerLv1MaxExp)
    playerLv=2;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==2&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 8\n');
    fprintf('Def + 4\n');
    fprintf('MaxHp + 40\n\n');
    playerAtk = playerAtk+8;
    playerDef = playerDef+4;
    playerMaxHp = playerMaxHp + 40;
    playerHp = playerHp + 40;
elseif(playerLv==2&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 6\n');
    fprintf('Def + 3\n');
    fprintf('MaxHp + 30\n\n');
    playerAtk = playerAtk+6;
    playerDef = playerDef+3;
    playerMaxHp = playerMaxHp + 30;
    playerHp = playerHp + 30;
elseif(playerLv==2&playerExp>=playerLv3MaxExp)
    playerLv=4;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==2&playerExp>=playerLv2MaxExp)
    playerLv=3;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==3&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 6\n');
    fprintf('Def + 3\n');
    fprintf('MaxHp + 30\n\n');
    playerAtk = playerAtk+6;
    playerDef = playerDef+3;
    playerMaxHp = playerMaxHp + 30;
    playerHp = playerHp + 30;
elseif(playerLv==3&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==3&playerExp>=playerLv3MaxExp)
    playerLv=4;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==4&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 4\n');
    fprintf('Def + 2\n');
    fprintf('MaxHp + 20\n\n');
    playerAtk = playerAtk+4;
    playerDef = playerDef+2;
    playerMaxHp = playerMaxHp + 20;
    playerHp = playerHp + 20;
elseif(playerLv==4&playerExp>=playerLv4MaxExp)
    playerLv=5;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
elseif(playerLv==5&playerExp>=playerLv5MaxExp)
    playerLv=6;
    fprintf('LeveL Up!\n');
    fprintf('ATK + 2\n');
    fprintf('Def + 1\n');
    fprintf('MaxHp + 10\n\n');
    playerAtk = playerAtk+2;
    playerDef = playerDef+1;
    playerMaxHp = playerMaxHp + 10;
    playerHp = playerHp + 10;
end
%% Encounter Health
if (playerX==6&playerY==9)|(playerX==3&playerY==3)|(playerX==2&playerY==8)|(playerX==8&playerY==9)|(playerX==8&playerY==3)|(playerX==5&playerY==5)
    fprintf('You use the potion and recovery 15 HP!\n');
    Origin = playerHp;
    playerHp = playerHp+15;
    if playerHp>playerMaxHp
        playerHp=playerMaxHp;
    end
    fprintf('PlayerHp: %i/%i -> %i/%i\n\n',Origin,playerMaxHp,playerHp,playerMaxHp)
end
Day = Day+1;
end


