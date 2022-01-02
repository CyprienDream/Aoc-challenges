import re #re.split(), re.match, re.findall, Regex Guide at https://www.debuggex.com/cheatsheet/regex/python
import functools #use @functools.lru_cache(None) above a function for memoization

def run(filename):
    print("Running",filename+"...")
    inp = re.findall(r'[A-Z]+', open(filename).read())
    def solve(part2=False):
        A = [inp[0], inp[4]] if not part2 else [inp[0], 'D', 'D', inp[4]]
        B = [inp[1], inp[5]] if not part2 else [inp[1], 'C', 'B', inp[5]]
        C = [inp[2], inp[6]] if not part2 else [inp[2], 'B', 'A', inp[6]]
        D = [inp[3], inp[7]] if not part2 else [inp[3] ,'A', 'C', inp[7]]
        well_len = 3 if not part2 else 5
        b = tuple([*A,'A',*B,'B',*C,'C',*D,'D'])
        t = tuple(['E' for i in range(11)]) # 2, 4, 6, 8 can't stop won't stop
        cost = {'A':1, 'B':10, 'C':100, 'D':1000}
        botTop = {'A':2,'B':4,'C':6,'D':8}
        @functools.lru_cache(None)
        def moveTop(top, i, j): # Can move in the top row from i to front of row
            return all(top[k]=='E' for k in range(min(i,j),max(i,j)+1) if k != i)
        def frontBot(bot): # Moles that can leave the wells (column, position)
            for c,i,j in [('A',0,well_len-1),('B',well_len,well_len*2-1),('C',well_len*2,well_len*3-1),('D',well_len*3,well_len*4-1)]:
                for k in range(i,j):
                    if bot[k] != 'E':
                        if not safeBot(bot, c):
                            yield (botTop[c],k)
                        break
        def safeBot(bot, char): # Is it safe to actually enter the correct bot from top
            return all(k==char or k=='E' for k in bot[well_len*botTop[char]//2-well_len:well_len*botTop[char]//2])
        @functools.lru_cache(None)
        def brute(bot, top):
            if part2 and bot == ('A','A','A','A','A','B','B','B','B','B','C','C','C','C','C','D','D','D','D','D'): return 0
            if not part2 and bot == ('A','A','A','B','B','B','C','C','C','D','D','D'): return 0
            for i in range(len(top)): # We can only move things in the top when we send them home
                char = top[i]
                if char == 'E': continue
                j = botTop[char]
                if j and moveTop(top, i, j) and safeBot(bot, char):
                    idx = well_len*botTop[char]//2-well_len + bot[well_len*botTop[char]//2-well_len:well_len*botTop[char]//2].index(char)-1
                    return cost[char]*(abs(j-i)+(idx%well_len)+1) + brute(bot[:idx]+tuple(top[i])+bot[idx+1:], top[:i]+tuple('E')+top[i+1:])
            # If you're hard stuck, return infinity, otherwise return minimum of every possible move
            ans = float("inf")
            moves = 0
            for c,i in frontBot(bot):
                for j in range(len(top)):
                    if j in [2,4,6,8] or top[j] != 'E' or not moveTop(top, c, j): continue
                    moves += 1
                    ans = min(ans, cost[bot[i]]*(i%well_len+1+abs(c-j)) + brute(bot[:i]+tuple('E')+bot[i+1:], top[:j]+tuple(bot[i])+top[j+1:]))
            if moves == 0: return float("inf")
            else: return ans
        print(brute(b,t))
    solve(part2=False)
    solve(part2=True)



print()
run("input.txt")
