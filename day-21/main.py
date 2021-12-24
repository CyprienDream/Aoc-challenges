pos,scores,rnd,goal=[2,5],[0,0],0,1000
while max(scores)<goal:
    oldscores=scores
    pos[0]=(pos[0]+5+18*rnd)%10+1
    pos[1]=(pos[1]+14+18*rnd)%10+1
    scores=[scores[i]+pos[i] for i in [0,1]]
    rnd+=1
if scores[0]>=goal:
    print((rnd*6-3)*oldscores[1])#overcounted if Player 1 won
else:
    print(rnd*6*scores[0])


init,goal,won=(2,5,0,0),21,[0,0]
adds=[ z+y+x for x in range(1,4) for y in range(1,4) for z in range(1,4)]
perms={a:adds.count(a) for a in adds}
states={(x,y,z,w):0 for x in range(1,11) for y in range(1,11) for z in range(0,goal) for w in range(0,goal)}
states[init]=1
while not max(states.values())==0:
    for state,value in states.items():
        if value>0:
            for p,n in perms.items():#player 1
                for q,m in perms.items():#try player 2 as well
                    pos=[(state[0]+p-1)%10+1,(state[1]+q-1)%10+1]
                    new=tuple(pos+[state[2]+pos[0],state[3]+pos[1]])
                    if max(new[2:])<goal:#neither player has won
                        states[new]+=value*n*m
                    elif new[3]>=goal and new[2]<goal:#player 2 won
                        won[1]+=value*m*n
                if new[2]>=goal:#player 1 won before player 2 even played
                    won[0]+=value*n
            states[state]=0
print(max([won[0],won[1]]))
