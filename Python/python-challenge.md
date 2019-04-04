## Problem 1
```python
print(2**38)
```

## Problem 2
```python
from string import maketrans

str = '''g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb
rfyr'q ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq() gq pcamkkclbcb. lmu ynnjw ml rfc spj. '''

ans = '''http://www.pythonchallenge.com/pc/def/map.html'''

x = 'abcdefghijklmnopqrstuvwxyz'
y = 'cdefghijklmnopqrstuvwxyzab'


tran = maketrans(x, y)
print(str.translate(tran))

print(ans.translate(tran))
```

## Problem 3
```python
str = '''(复制字符串)'''

cnt = {}
for c in str:
    if ord(c) in cnt:
        cnt[ord(c)] += 1
    else:
        cnt[ord(c)] = 1

list = []
for pr in cnt:
    if cnt[pr] == 1:
        list.append(pr)

ans = ''
for c in str:
    if ord(c) in list:
        ans += c

print(ans)
```

## Problem 4
```python
input_str ='''(复制字符串)'''

sample_line = 'PBuijeoTSpsVLaOGuLVjMZXkBvVXwUuHfBihziiavGSYofPNeKsTXruMUumRRPQJzvSzJkKbtSipiqBd'

m = len(sample_line) + 1
n = len(input_str) / m

# print(n, m)

dx = [0, 1, -1, 0]
dy = [1, 0, 0, -1]

ans = ''
for i in range(0, n):
    for j in range(0, m):
        c = input_str[m *i+j]
        # print(c)
        if c.islower():
            num = 0
            for k in range(0, 4):
                ni = i + dx[k]
                nj = j + dy[k]
                if 0 <= ni < n and 0 <= nj < m:
                    if input_str[ni*m+nj].isupper() and input_str[ni*m+nj].lower() == c:
                        num += 1
            if num == 3:
                ans += c
print(ans)


```
