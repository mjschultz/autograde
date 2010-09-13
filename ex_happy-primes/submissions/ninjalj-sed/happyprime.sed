h
s/^/printf %*s /e
s/^ $|^(  +)\1+$/non-/
s/ *$/prime/
x
:a
s/./+&*&/g
s//bc<<</e
tb
:b
s/^1$/happy/
s/^4$/sad/
Ta
G
s/\n/ /
